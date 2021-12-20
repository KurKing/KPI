CREATE USER restaurant_owner WITH PASSWORD 'restaurant_owner';

CREATE DATABASE "restaurant-main-db" owner restaurant_owner;
ALTER DATABASE "restaurant-main-db" SET TIMEZONE = 'UTC';

GRANT ALL PRIVILEGES ON DATABASE "restaurant-main-db" TO restaurant_owner;