-- One rating of a completed appointment by its client (06-data/models.md §5, DEC-APPT-11).
-- barbershop_id and barber_id are copied from the appointment; the foreign key to it and the
-- one-review-per-appointment key are added in 04_alter, the read indexes in 10_indexes.
CREATE TABLE appointment.review (
    id                   uuid        NOT NULL,
    appointment_id       uuid        NOT NULL,
    barbershop_id        uuid        NOT NULL,   -- copied from the appointment: no FK to the barbershop domain
    barber_id            uuid        NOT NULL,   -- copied from the appointment: no FK
    client_id            uuid        NOT NULL,   -- the token's sub; owned by identity_auth, no FK
    client_display_name  text        NOT NULL,   -- "María G.", a snapshot read once from identity-auth (ADR-014)
    rating               smallint    NOT NULL,
    comment              text        NULL,
    created_at           timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_review PRIMARY KEY (id),
    CONSTRAINT chk_review_rating  CHECK (rating BETWEEN 1 AND 5),
    CONSTRAINT chk_review_comment CHECK (char_length(comment) <= 500),
    CONSTRAINT chk_review_display_name CHECK (char_length(client_display_name) BETWEEN 1 AND 60)
);
