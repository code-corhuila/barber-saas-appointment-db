# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2026-10-08

User stories: code-corhuila/barber-saas-docs#4, code-corhuila/barber-saas-docs#5, code-corhuila/barber-saas-docs#59

### Added

- deploy: add the migration runner with its own changelog tables
- ddl: create the appointment schema
- ddl: create appointment
- ddl: create idempotency key
- ddl: create outbox event
- ddl: prevent double booking of a barber
- dcl: create roles
- dcl: grants
- ddl: record why an outbox event could not be delivered
- ddl: remember when the reminder of an appointment was written
- ddl: add coupon_id to appointment
- ddl: keep a reward coupon on one appointment
- ddl: an appointment paid by a reward coupon costs 0

### Fixed

- keep the applied .sql files identical to develop

### Changed

- ddl: create indexes
- ddl: leave the failed events out of the pending outbox index

### Documentation

- readme: explain how the schema is migrated and where the data is
- readme: point the header to Barber Saas and barber-saas-docs
- readme: explain the outbox failure columns and the reminder mark
- readme: roll back only with rollback-count

### Tests

- ci: rebuild the schema from an empty database on every pull request

### Maintenance

- db: ignore local env files and liquibase output
- github: add the pull request template
- github: track the story environment on the board
- liquibase: add the master changelog and the ddl, dml, dcl and tcl families
- use the new repository name barber-saas-infra-postgres

[2.0.0]: https://github.com/code-corhuila/barber-saas-appointment-db/releases/tag/v2.0.0
