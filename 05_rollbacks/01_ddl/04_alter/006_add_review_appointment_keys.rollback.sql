ALTER TABLE appointment.review
    DROP CONSTRAINT IF EXISTS uq_review_appointment,
    DROP CONSTRAINT IF EXISTS fk_review_appointment;
