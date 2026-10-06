-- What the worker reads: pending events only, neither published nor set aside as failed, oldest
-- first. Replaces the index of ddl-indexes-001, which this changeset drops instead of editing it.
DROP INDEX IF EXISTS appointment.idx_outbox_event_unpublished;
CREATE INDEX idx_outbox_event_unpublished ON appointment.outbox_event (occurred_at)
    WHERE published_at IS NULL AND failed_at IS NULL;
