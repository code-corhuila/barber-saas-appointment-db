-- Set in the same transaction that writes AppointmentReminderDue: a reminder is sent once per
-- appointment, however many times the worker asks (DEC-APPT-07).
ALTER TABLE appointment.appointment
    ADD COLUMN reminder_sent_at timestamptz NULL;
