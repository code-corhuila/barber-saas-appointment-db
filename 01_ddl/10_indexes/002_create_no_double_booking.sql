-- INV-APPT-001: two active appointments of the same barber never overlap in time. The service
-- checks it too, to answer a clean 422; this constraint is the guarantee under concurrency.
-- CANCELLED and NO_SHOW free the slot. Needs btree_gist (uuid with =), which the single
-- instance provides: barber-saas-infra creates extensions, never a -db (Annex J J.4).
ALTER TABLE appointment.appointment
    ADD CONSTRAINT ex_appointment_no_double_booking EXCLUDE USING gist (
        barber_id WITH =,
        tsrange(appointment_date + start_time, appointment_date + end_time) WITH &&
    ) WHERE (status NOT IN ('CANCELLED','NO_SHOW'));
