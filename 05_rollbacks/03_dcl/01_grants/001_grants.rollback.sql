DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'appointment_app') THEN
        REVOKE appointment_writer FROM appointment_app;
    END IF;
END
$$;
ALTER DEFAULT PRIVILEGES IN SCHEMA appointment REVOKE ALL ON TABLES FROM appointment_reader, appointment_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA appointment FROM appointment_reader, appointment_writer;
REVOKE USAGE ON SCHEMA appointment FROM appointment_reader, appointment_writer;
