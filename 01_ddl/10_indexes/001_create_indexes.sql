-- "agenda of a barbershop on a date", the tenant filter of every list
CREATE INDEX IF NOT EXISTS idx_appointment_barbershop_date ON appointment.appointment (barbershop_id, appointment_date);
-- "my appointments", what a CLIENT lists
CREATE INDEX IF NOT EXISTS idx_appointment_client_id ON appointment.appointment (client_id);
CREATE INDEX IF NOT EXISTS idx_appointment_status ON appointment.appointment (status);
-- what the outbox publisher reads: only the pending events, oldest first
CREATE INDEX IF NOT EXISTS idx_outbox_event_unpublished ON appointment.outbox_event (occurred_at) WHERE published_at IS NULL;
