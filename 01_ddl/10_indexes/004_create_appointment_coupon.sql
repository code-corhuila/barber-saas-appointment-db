-- One appointment per coupon (DEC-APPT-09): two bookings of the same client that read the same ACTIVE
-- coupon at once cannot both use it; the second one is refused and the client books again.
CREATE UNIQUE INDEX uq_appointment_coupon ON appointment.appointment (coupon_id)
    WHERE coupon_id IS NOT NULL;
