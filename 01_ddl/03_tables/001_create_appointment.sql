-- One booking of a client with a barber, inside one barbershop (06-data/models.md §5).
-- The no-double-booking exclusion constraint is added in 10_indexes, next to the indexes.
CREATE TABLE appointment.appointment (
    id                      uuid        NOT NULL,
    barbershop_id           uuid        NOT NULL,   -- owned by the barbershop domain: referenced by id, no FK
    client_id               uuid        NULL,       -- NULL = walk-in created by staff; owned by identity_auth, no FK
    barber_id               uuid        NOT NULL,   -- barbershop.barber_profile id: referenced by id, no FK
    service_id              uuid        NOT NULL,   -- barbershop.service id: referenced by id, no FK
    appointment_date        date        NOT NULL,
    start_time              time        NOT NULL,
    end_time                time        NOT NULL,
    status                  text        NOT NULL DEFAULT 'PENDING',
    price_at_booking_cents  bigint      NOT NULL,   -- snapshot of the service price, never changes (INV-APPT-002)
    notes                   text        NULL,
    cancelled_reason        text        NULL,
    created_by              uuid        NOT NULL,   -- user who booked (client or staff)
    created_at              timestamptz NOT NULL DEFAULT now(),
    updated_at              timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_appointment PRIMARY KEY (id),
    CONSTRAINT chk_appointment_status CHECK (status IN ('PENDING','CONFIRMED','IN_PROGRESS','COMPLETED','CANCELLED','NO_SHOW')),
    CONSTRAINT chk_appointment_time   CHECK (end_time > start_time),
    CONSTRAINT chk_appointment_price  CHECK (price_at_booking_cents >= 0),
    CONSTRAINT chk_appointment_notes  CHECK (char_length(notes) <= 500),
    CONSTRAINT chk_appointment_cancelled_reason CHECK (char_length(cancelled_reason) <= 255)
);
