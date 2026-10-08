-- A reward coupon pays the whole appointment (DEC-APPT-09): a row that names a coupon is never
-- charged. The schema holds the rule, not only appointment-api.
ALTER TABLE appointment.appointment
    ADD CONSTRAINT chk_appointment_coupon_price CHECK (coupon_id IS NULL OR price_at_booking_cents = 0);
