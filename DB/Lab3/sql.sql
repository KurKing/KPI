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
FROM orders
WHERE date < current_timestamp;
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
WHERE name in ('Apple', 'Pineapple', 'Apppppple')
ORDER BY name;
-- 7

-- 8

-- 9

-- 10

-- 11

-- 12

-- 13

-- 14

-- 15
