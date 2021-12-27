CREATE OR REPLACE FUNCTION some_func(refcursor)
    RETURNS refcursor
AS
$$
BEGIN
    OPEN $1 FOR SELECT number FROM public.some_numbers;
    RETURN $1;
END;
$$
    LANGUAGE plpgsql;

BEGIN;
SELECT some_func('some_cursor');
FETCH ALL IN some_cursor;
COMMIT;