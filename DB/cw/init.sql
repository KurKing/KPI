CREATE USER restaurant_owner WITH PASSWORD 'restaurant_owner';

CREATE DATABASE "restaurant-main-db" owner restaurant_owner;
ALTER DATABASE "restaurant-main-db" SET TIMEZONE = 'UTC';

GRANT ALL PRIVILEGES ON DATABASE "restaurant-main-db" TO restaurant_owner;

CREATE USER restaurant_reader WITH PASSWORD 'restaurant_reader';
GRANT CONNECT ON DATABASE "restaurant-main-db" TO restaurant_reader;
GRANT USAGE ON SCHEMA public TO restaurant_reader;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO restaurant_reader;