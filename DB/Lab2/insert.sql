INSERT INTO products(id, name, producer, price)
    VALUES ('8f9d84cd-410e-792f-9808-26c089a6ad52'::uuid, 'Apple', 'Apple company', 300);
INSERT INTO products(id, name, producer, price)
    VALUES ('07367cf3-2ab8-f715-fc79-703a9966c0e6'::uuid, 'Banana', 'Banana company', 400);
INSERT INTO products(id, name, producer, price)
    VALUES ('fb50e588-2b5c-f5aa-dff0-d605a5f5d73f'::uuid, 'Pineapple', 'Pineapple company', 500);
INSERT INTO products(id, name, producer, price)
    VALUES ('6bc5e360-b927-9693-a15b-088b83bb95ca'::uuid, 'Rabbit', 'Rabbit company', 0);
INSERT INTO products(id, name, producer, price)
    VALUES ('925fe284-2caa-ade9-6ba6-bc62841cce4e'::uuid, 'Clock', 'Armani', 700);
INSERT INTO products(id, name, producer, price)
    VALUES ('9ed03b76-ffdb-03c6-19f3-1cd85790048e'::uuid, 'mx-5', 'Mazda', 3600);

INSERT INTO contracts(id, total_price, date)
    VALUES ('2d08ae15-da10-4206-89b6-a26c9f02b6fc'::uuid, 300*10+400*20+200, current_timestamp);
INSERT INTO contracts(id, total_price, date)
    VALUES ('82096798-58e1-4882-b301-1a2983081e94'::uuid, 400*20+200, current_timestamp);

INSERT INTO contract_cases(id, amount, total_price, product_id, contract_id)
    VALUES ('994fa543-4e4f-41c6-8619-f166c305fe8a'::uuid, 10, 300*10,
            '8f9d84cd-410e-792f-9808-26c089a6ad52'::uuid,
            '2d08ae15-da10-4206-89b6-a26c9f02b6fc'::uuid);
INSERT INTO contract_cases(id, amount, total_price, product_id, contract_id)
    VALUES ('fa076713-fe80-4ee0-9989-680b49d38205'::uuid, 20, 400*20,
            '07367cf3-2ab8-f715-fc79-703a9966c0e6'::uuid,
            '2d08ae15-da10-4206-89b6-a26c9f02b6fc'::uuid);
INSERT INTO contract_cases(id, amount, total_price, product_id, contract_id)
    VALUES ('18705a63-781b-49a8-9275-15d6afb95815'::uuid, 20, 400*20,
            '07367cf3-2ab8-f715-fc79-703a9966c0e6'::uuid,
            '82096798-58e1-4882-b301-1a2983081e94'::uuid);

INSERT INTO shipping_methods(id, shipping_company, price, is_express)
    VALUES ('5e72b8e1-6c27-43e7-831e-1eece0cd9067'::uuid, 'Nova Poshta', 123, false);
INSERT INTO shipping_methods(id, shipping_company, price, is_express)
    VALUES ('da754dea-4f1b-4afd-9770-1625916e5edc'::uuid, 'Nova Poshta', 321, true);
INSERT INTO shipping_methods(id, shipping_company, price, is_express)
    VALUES ('ccc9c010-97ca-47e3-8d32-800bce137ab9'::uuid, 'Ukr Poshta', 222, false);

INSERT INTO clients(id, itn, name)
    VALUES ('28278f24-61ae-4362-b4eb-c274414049b1'::uuid, 12345678, 'Bardin Vlad');

INSERT INTO orders(id, contracts, shipping_method, date, client)
    VALUES ('1a38a3e2-9429-4466-a0f7-d60bd07815a4'::uuid,
            '2d08ae15-da10-4206-89b6-a26c9f02b6fc'::uuid,
            '5e72b8e1-6c27-43e7-831e-1eece0cd9067'::uuid,
            current_timestamp,
            '28278f24-61ae-4362-b4eb-c274414049b1'::uuid);
INSERT INTO orders(id, contracts, shipping_method, date, client)
    VALUES ('045e2120-1a28-4915-8e47-00f686fc8a2a'::uuid,
            '82096798-58e1-4882-b301-1a2983081e94'::uuid,
            'da754dea-4f1b-4afd-9770-1625916e5edc'::uuid,
            current_timestamp,
            '28278f24-61ae-4362-b4eb-c274414049b1'::uuid);
