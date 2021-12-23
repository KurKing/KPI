SELECT date, id
FROM contracts
WHERE date < '2021-12-17';

SELECT clients.name, orders.id, public.contracts.total_price,
       (public.contracts.total_price - sum(contract_cases.total_price)) * 0.95 as profit
FROM clients
JOIN orders ON clients.id = orders.client
JOIN contracts ON orders.contracts = contracts.id
JOIN contract_cases ON contracts.id = contract_cases.contract_id
GROUP BY public.contracts.total_price, clients.name, orders.id;

SELECT shipping_methods.shipping_company, count(shipping_methods.shipping_company) as c
FROM orders
RIGHT JOIN shipping_methods ON orders.shipping_method = shipping_methods.id
GROUP BY shipping_methods.shipping_company
ORDER BY c DESC;

SELECT upper(name)
from clients

SELECT lower(name)
from clients

SELECT shipping_methods.shipping_company, count(shipping_methods.shipping_company) as c
FROM orders
RIGHT JOIN shipping_methods ON orders.shipping_method = shipping_methods.id
GROUP BY shipping_methods.shipping_company
HAVING count(shipping_methods.shipping_company) > 1
ORDER BY c DESC;

SELECT count(shipping_methods.shipping_company)
FROM orders
RIGHT JOIN shipping_methods ON orders.shipping_method = shipping_methods.id
HAVING count(shipping_methods.shipping_company) > 1;

CREATE VIEW some_view AS
SELECT clients.name as client, products.name as product,
       sum(contract_cases.amount) as amount_of_product
FROM clients
JOIN orders ON clients.id = orders.client
JOIN contracts ON orders.contracts = contracts.id
JOIN contract_cases ON contracts.id = contract_cases.contract_id
JOIN products ON contract_cases.product_id = products.id
GROUP BY clients.name, products.name, products.price
ORDER BY products.name;

SELECT some_view.*, clients.itn
FROM clients
JOIN some_view ON clients.name = some_view.client;

SELECT pg_describe_object(refclassid, refobjid, refobjsubid)
FROM pg_depend
WHERE objid = (SELECT objid FROM "company-main-db".pg_catalog.pg_views WHERE viewname = 'some_view');

ALTER VIEW IF EXISTS some_view
    RENAME TO "Amount of product for client";