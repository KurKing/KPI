CREATE TABLE IF NOT EXISTS some_table
(
    name VARCHAR(10)
);

INSERT INTO some_table(name) (
    SELECT name
    FROM products
);

CREATE TABLE IF NOT EXISTS some_logs
(
    data VARCHAR(20)
);

CREATE OR REPLACE FUNCTION very_cool_func() RETURNS TRIGGER AS
$audit$
BEGIN
    IF (TG_OP = 'DELETE') THEN
        INSERT INTO some_logs(data) VALUES ('DELETE');
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO some_logs(data) VALUES ('UPDATE');
    ELSIF (TG_OP = 'INSERT') THEN
        INSERT INTO some_logs(data) VALUES ('INSERT');
    END IF;
    RETURN NULL;
END;
$audit$ LANGUAGE plpgsql;

CREATE TRIGGER cool_trigger
    AFTER INSERT OR UPDATE OR DELETE
    ON some_table
    FOR EACH ROW
EXECUTE FUNCTION very_cool_func();

INSERT INTO some_table(name) VALUES ('new');
UPDATE some_table SET name = 'Clock' WHERE name = 'Watch';
DELETE FROM some_table WHERE true;