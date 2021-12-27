-- 1
CREATE OR REPLACE FUNCTION profit_from_order(order_id UUID)
RETURNS INTEGER
AS
    $$
    SELECT (public.contracts.total_price - sum(contract_cases.total_price)) * 0.95
    FROM clients
    JOIN orders ON clients.id = orders.client
    JOIN contracts ON orders.contracts = contracts.id
    JOIN contract_cases ON contracts.id = contract_cases.contract_id
    WHERE orders.id = order_id
    GROUP BY public.contracts.total_price, clients.name, orders.id
    $$ LANGUAGE sql;

SELECT orders.id, profit_from_order(orders.id) as profit
FROM orders;

-- 2
CREATE TABLE a_table
(
    id   serial PRIMARY KEY,
    col1 text
);

INSERT INTO a_table(col1)
VALUES ('value1'),
       ('value2');

CREATE OR REPLACE FUNCTION table_plus_column(_table regclass)
    RETURNS void AS
$func$
DECLARE
    _tmp text := quote_ident(_table::text || '_tmp');
BEGIN

    EXECUTE format(
            'CREATE TEMP TABLE %s ON COMMIT DROP AS TABLE %s LIMIT 0', _tmp, _table);

     EXECUTE format($x$
      ALTER  TABLE %1$s ADD COLUMN col2 text;
      INSERT INTO %1$s
      SELECT *, 'ID: ' || id::text
      FROM   %2$s $x$
            , _tmp, _table);

END
$func$ LANGUAGE plpgsql;

BEGIN;
SELECT table_plus_column('a_table');
SELECT *
FROM a_table_tmp;
COMMIT;

-- 3
