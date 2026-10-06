ALTER TABLE appointment.outbox_event
    DROP CONSTRAINT IF EXISTS chk_outbox_event_last_error,
    DROP COLUMN IF EXISTS last_error,
    DROP COLUMN IF EXISTS failed_at;
