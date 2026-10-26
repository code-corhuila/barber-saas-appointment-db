-- Set in the same transaction that writes the one-hour AppointmentReminderDue: the HOUR_BEFORE
-- reminder is sent once per appointment, as reminder_sent_at does for DAY_BEFORE (DEC-APPT-12).
ALTER TABLE appointment.appointment
    ADD COLUMN hour_reminder_sent_at timestamptz NULL;
