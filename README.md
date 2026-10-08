# barber-saas-appointment-db

> appointment bounded context: database (schema, seeds, migrations)

Part of the **Barber Saas** distributed system — team `barber-saas`, Grupo 2.
Governance and documentation live in [`barber-saas-docs`](https://github.com/code-corhuila/barber-saas-docs).

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `barber-saas-docs`.

---

## BarberSaaS — what this repository is

The `appointment` schema (appointments with their status and price snapshot, idempotency keys,
the outbox of appointment events) versioned with Liquibase (ADR-007), following annex A and
Annex J: it has **no database instance of its own**. Its runner applies the changesets to the
single PostgreSQL instance of `barber-saas-infra-postgres`, with its own changelog tables
(`databasechangelog_appointment`). Model: `06-data/models.md` §5 and §10 in `barber-saas-docs`.

### How to run the migrations

From `barber-saas-infra-postgres`, with the platform up:

```bash
docker compose --env-file env/dev.env run --rm appointment-db-migrate            # update
docker compose --env-file env/dev.env run --rm appointment-db-migrate status --verbose
docker compose --env-file env/dev.env run --rm appointment-db-migrate rollback-count 1
```

The instance must provide the `btree_gist` extension (besides `pgcrypto`): the
no-double-booking constraint needs it, and extensions are created by the infrastructure, never
by a `-db` (Annex J J.4).

### Where the data is

Schema `appointment` in database `barbersaas` of the shared instance. The service reads and
writes it as `appointment_app` (granted `appointment_writer` in `03_dcl/`); nobody else writes it.
Barbershop, barber, service and users are referenced by id with no foreign key: appointment-api
checks them through `barbershop-api` and `schedule-api`, never by reading their tables.

### How it is tested

`.github/workflows/db-ci.yml` builds the schema from an empty database, checks that a second
update applies nothing, rolls everything back and applies it again. The double-booking
constraint `ex_appointment_no_double_booking` is exercised by the integration tests of
`barber-saas-appointment-api`.

### What is missing

No seed data: appointments are created through the API. The outbox is read and confirmed by
`barber-saas-worker` through appointment-api (ADR-016): `failed_at` and `last_error` set aside an
event it cannot deliver, and the pending index leaves those out. `reminder_sent_at` makes the
reminder of an appointment a one-time write (`DEC-APPT-07`). `coupon_id` is the loyalty reward coupon
applied at booking, and `uq_appointment_coupon` keeps a coupon on one appointment (`DEC-APPT-09`).
Every one of these arrived in a new changeset (`ddl-alter-001` … `003`, `ddl-indexes-003`, `004`):
applied changesets are never edited.
