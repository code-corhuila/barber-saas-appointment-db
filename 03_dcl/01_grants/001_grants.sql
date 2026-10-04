GRANT USAGE ON SCHEMA appointment TO appointment_reader, appointment_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA appointment TO appointment_reader;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA appointment TO appointment_writer;
ALTER DEFAULT PRIVILEGES IN SCHEMA appointment GRANT SELECT ON TABLES TO appointment_reader;
ALTER DEFAULT PRIVILEGES IN SCHEMA appointment GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO appointment_writer;

-- The domain grants its writer role to its own login user (Annex J J.7). The user exists only
-- where the infrastructure created it, so the grant is conditional. No other domain is granted
-- appointment_reader: other domains read this data through appointment-api (Annex J J.3.3).
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appointment_app') THEN
        GRANT appointment_writer TO appointment_app;
    END IF;
END
$$;
