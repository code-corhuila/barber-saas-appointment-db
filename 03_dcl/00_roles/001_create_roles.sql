-- NOLOGIN roles carry the permissions. The login user appointment_app is created by
-- barber-saas-infra-postgres from a secret; no password is ever versioned here.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appointment_reader') THEN
        CREATE ROLE appointment_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appointment_writer') THEN
        CREATE ROLE appointment_writer NOLOGIN;
    END IF;
END
$$;
