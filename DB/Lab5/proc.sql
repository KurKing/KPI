CREATE OR REPLACE PROCEDURE create_temp_table()
AS
$$
BEGIN
    CREATE TEMP TABLE IF NOT EXISTS p_temp AS
    SELECT name
    FROM products;
END;
$$ LANGUAGE plpgsql;

CALL create_temp_table();
SELECT *
FROM p_temp;

-- 2
CREATE OR REPLACE FUNCTION check_if_table_exists(schema_name varchar, _table_name varchar)
    RETURNS BOOLEAN
AS
$$
SELECT EXISTS(
               SELECT
               FROM information_schema.tables
               WHERE table_schema = schema_name
                 AND table_name = _table_name
           );
$$ LANGUAGE sql;

CREATE OR REPLACE PROCEDURE create_p_temp_if_not_exists()
AS
$$
BEGIN
    IF NOT check_if_table_exists('public', 'p_temp') THEN
        CALL create_temp_table();
    END if;
END;
$$ LANGUAGE plpgsql;

CALL create_p_temp_if_not_exists();
SELECT *
FROM p_temp;

-- 3
CREATE TABLE IF NOT EXISTS some_numbers
(
  number INTEGER
);

CREATE OR REPLACE PROCEDURE fill_numbers()
AS
$$
DECLARE
    i_increment INT := 2;
    i_current   INT := 0;
    i_end       INT := 10;
BEGIN


    WHILE i_current <= i_end
        LOOP
            i_current := i_current + i_increment;
            INSERT INTO some_numbers(number) VALUES (i_current);
        END LOOP;
END;
$$
    LANGUAGE plpgsql;

CALL fill_numbers();