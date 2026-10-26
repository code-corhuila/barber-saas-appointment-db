-- A review belongs to one appointment of this schema and goes with it (ON DELETE CASCADE), and an
-- appointment has at most one review: uq_review_appointment refuses the second one even when two
-- requests race, and appointment-api answers it with 422 (DEC-APPT-11).
ALTER TABLE appointment.review
    ADD CONSTRAINT fk_review_appointment FOREIGN KEY (appointment_id)
        REFERENCES appointment.appointment (id) ON DELETE CASCADE,
    ADD CONSTRAINT uq_review_appointment UNIQUE (appointment_id);
