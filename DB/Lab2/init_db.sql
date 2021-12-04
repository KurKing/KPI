CREATE USER sc_owner WITH PASSWORD 'sc_owner';

CREATE DATABASE "company-main-db" owner sc_owner;
ALTER DATABASE "company-main-db" SET TIMEZONE = 'UTC';

GRANT ALL PRIVILEGES ON DATABASE "company-main-db" TO sc_owner;