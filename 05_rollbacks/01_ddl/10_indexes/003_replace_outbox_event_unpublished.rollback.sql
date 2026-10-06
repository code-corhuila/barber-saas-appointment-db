DROP INDEX IF EXISTS appointment.idx_outbox_event_unpublished;
CREATE INDEX idx_outbox_event_unpublished ON appointment.outbox_event (occurred_at) WHERE published_at IS NULL;
