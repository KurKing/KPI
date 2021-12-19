-- #1

-- 1
SELECT name, price
FROM products
WHERE name = 'Apple';
-- 2
SELECT name, price
FROM products
WHERE name LIKE '%5%';
-- 3
SELECT sum(price)
FROM products
WHERE name LIKE '%pple%';
-- 4
SELECT shipping_company, price
FROM shipping_methods
WHERE is_express;
-- 5
SELECT name, price
FROM products
WHERE  price >= 1000;
-- 6
SELECT name, price
FROM products
WHERE price > 500 AND price < 2000;
-- 7
SELECT name
FROM products
WHERE price IS NULL;
-- 8
SELECT name, price
FROM products
WHERE price BETWEEN 200 AND 600;
-- 9
SELECT avg(price)
FROM products
WHERE name = 'Apple' OR name = 'Banana' OR name IS NULL;
-- 10
SELECT name, price
FROM products;
-- 11
SELECT date, id
FROM contracts
WHERE date < '2021-12-17';
-- 12
SELECT name
FROM products
WHERE price = 300;
-- 13
SELECT name, producer
FROM products
WHERE producer LIKE '%company%';
-- 14
SELECT name, producer
FROM products
WHERE producer NOT LIKE '%company%';
-- 15
SELECT id
FROM orders
WHERE extract(MONTH FROM date) = 12;

-- #2

-- 1
SELECT name, price, contract_id
FROM products
JOIN contract_cases ON products.id = contract_cases.product_id
WHERE contract_id IN (
    SELECT id
    FROM contracts
    WHERE contracts.total_price > 10000
);
-- 2
SELECT products.name, products.price
FROM contract_cases
RIGHT JOIN products on contract_cases.product_id = products.id
WHERE contract_cases IS NULL
ORDER BY name;
-- 3
SELECT products.name, products.price
FROM products
LEFT JOIN contract_cases on contract_cases.product_id = products.id
WHERE contract_cases IS NULL
ORDER BY name;
-- 4
SELECT contracts.total_price,
       shipping_company,
       shipping_methods.price,
       is_express,
       contracts.total_price + shipping_methods.price
FROM contracts
CROSS JOIN shipping_methods
ORDER BY contracts.id;
-- 5
SELECT products.name, products.price
FROM products
WHERE NOT EXISTS (
    SELECT product_id
    FROM contract_cases
    WHERE products.id = contract_cases.product_id
          )
ORDER BY name;
-- 6
SELECT name
FROM products
WHERE name IN ('Apple', 'Pineapple', 'Apppppple')
ORDER BY name;
-- 7
SELECT contract_cases.id, products.name, products.price
FROM contract_cases
INNER JOIN products ON contract_cases.product_id = products.id;
-- 8
SELECT contracts.id, contracts.total_price, products.name
FROM contracts
JOIN contract_cases ON contracts.id = contract_cases.contract_id
RIGHT OUTER JOIN products
    ON products.id = contract_cases.product_id
WHERE contract_id IS NOT NULL;
-- 9
SELECT name, producer, contract_id
FROM products
LEFT OUTER JOIN contract_cases on products.id = contract_cases.product_id
WHERE producer LIKE '%company%';
-- 10
SELECT clients.name, public.contracts.total_price,
       contract_cases.total_price, contract_cases.amount,
       products.name, products.price
FROM clients
JOIN orders ON clients.id = orders.client
JOIN contracts ON orders.contracts = contracts.id
JOIN contract_cases ON contracts.id = contract_cases.contract_id
JOIN products ON contract_cases.product_id = products.id
ORDER BY contract_id;
-- 11
SELECT clients.name, products.name,
       sum(contract_cases.amount) as amount_of_product
FROM clients
JOIN orders ON clients.id = orders.client
JOIN contracts ON orders.contracts = contracts.id
JOIN contract_cases ON contracts.id = contract_cases.contract_id
JOIN products ON contract_cases.product_id = products.id
GROUP BY clients.name, products.name, products.price
ORDER BY products.name;
-- 12
SELECT clients.name, orders.id, public.contracts.total_price,
       public.contracts.total_price - sum(contract_cases.total_price) as profit
FROM clients
JOIN orders ON clients.id = orders.client
JOIN contracts ON orders.contracts = contracts.id
JOIN contract_cases ON contracts.id = contract_cases.contract_id
GROUP BY public.contracts.total_price, clients.name, orders.id;
-- 13
SELECT clients.name,
       public.contracts.total_price as contract_price,
       shipping_methods.price as shipping_price,
       public.contracts.total_price + shipping_methods.price as total_price
FROM clients
JOIN orders ON clients.id = orders.client
JOIN contracts ON orders.contracts = contracts.id
JOIN contract_cases ON contracts.id = contract_cases.contract_id
JOIN shipping_methods ON orders.shipping_method = shipping_methods.id
GROUP BY orders.id, clients.name, public.contracts.total_price, shipping_methods.price;
-- 14
SELECT clients.name,
       shipping_methods.is_express as express,
       shipping_methods.shipping_company
FROM clients
JOIN orders ON clients.id = orders.client
JOIN shipping_methods ON orders.shipping_method = shipping_methods.id
WHERE shipping_methods.is_express;
-- 15
SELECT shipping_methods.shipping_company, count(shipping_methods.shipping_company) as c
FROM orders
RIGHT JOIN shipping_methods ON orders.shipping_method = shipping_methods.id
GROUP BY shipping_methods.shipping_company
ORDER BY c DESC;