-- The loyalty reward coupon applied at booking, in which case price_at_booking_cents is 0
-- (DEC-APPT-09, FR-010). No foreign key: the coupon belongs to the loyalty domain.
ALTER TABLE appointment.appointment
    ADD COLUMN coupon_id uuid NULL;
