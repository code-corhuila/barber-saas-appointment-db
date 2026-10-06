-- An event the worker cannot deliver (a 4xx, or 8 attempts) leaves the pending list with its reason
-- (ADR-016, DEC-APPT-07). New changeset: the applied ones are never edited (Liquibase checksums).
ALTER TABLE appointment.outbox_event
    ADD COLUMN failed_at  timestamptz NULL,
    ADD COLUMN last_error text        NULL,
    ADD CONSTRAINT chk_outbox_event_last_error CHECK (char_length(last_error) <= 500);
