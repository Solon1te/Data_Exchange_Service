SELECT rolname
FROM pg_roles;

SELECT * 
FROM pg_roles;

SELECT current_role;

CREATE ROLE abc_open_data WITH NOSUPERUSER LOGIN;

-- SELECT * 
-- FROM pg_roles;

CREATE ROLE publishers WITH NOSUPERUSER ROLE abc_open_data;

GRANT USAGE ON SCHEMA analytics TO publishers;

GRANT SELECT ON ALL TABLES IN SCHEMA analytics to publishers;

SELECT * FROM information_schema.table_privileges
WHERE grantee = 'publishers';

SET ROLE abc_open_data;

SELECT * FROM analytics.downloads limit 10;

SET ROLE ccuser;

SELECT * FROM directory.datasets LIMIT 5;

GRANT USAGE ON SCHEMA directory TO publishers;

GRANT SELECT (id, create_date, hosting_path, src_size, publisher) ON directory.datasets to publishers;

-- SET ROLE abc_open_data;

-- SELECT id, publisher, hosting_path, data_checksum 
-- FROM directory.datasets;

CREATE POLICY policy_abc ON analytics.downloads
FOR SELECT TO publishers USING (owner=current_user);

ALTER TABLE analytics.downloads ENABLE ROW LEVEL SECURITY;

SET ROLE abc_open_data;

SELECT * FROM analytics.downloads limit 10;