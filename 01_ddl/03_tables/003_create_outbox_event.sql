-- Events of this domain (AppointmentCompleted, AppointmentCancelled ...), written in the same
-- transaction as the change and published afterwards by a separate process (norm 5.3.11).
CREATE TABLE appointment.outbox_event (
    id              uuid        NOT NULL,
    aggregate_type  text        NOT NULL,   -- 'appointment'
    aggregate_id    uuid        NOT NULL,
    event_type      text        NOT NULL,   -- e.g. 'AppointmentCompleted'
    payload         jsonb       NOT NULL,
    correlation_id  text        NOT NULL,
    occurred_at     timestamptz NOT NULL DEFAULT now(),
    published_at    timestamptz NULL,
    CONSTRAINT pk_outbox_event PRIMARY KEY (id)
);
