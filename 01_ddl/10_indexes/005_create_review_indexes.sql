-- The public list of a barbershop's reviews, newest first, and its filter by barber (DEC-APPT-11).
CREATE INDEX idx_review_barbershop_created ON appointment.review (barbershop_id, created_at DESC);
CREATE INDEX idx_review_barber ON appointment.review (barber_id);
