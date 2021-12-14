CREATE TABLE IF NOT EXISTS products
(
    id          UUID,
    name        VARCHAR(64),
    producer    VARCHAR(64),
    price       INTEGER,
    CONSTRAINT product_pk PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS contracts
(
    id                  UUID,
    total_price         INTEGER,
    date                DATE,
    CONSTRAINT contract_pk  PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS contract_cases
(
    id          UUID,
    amount      INTEGER,
    total_price INTEGER,
    product_id  UUID,
    contract_id UUID,
    CONSTRAINT contract_case_pk PRIMARY KEY(id),
    CONSTRAINT products_fk
        FOREIGN KEY (product_id)
            REFERENCES products(id),
    CONSTRAINT contract_fk
        FOREIGN KEY (contract_id)
            REFERENCES contracts(id)
);

CREATE TABLE IF NOT EXISTS shipping_methods
(
    id                  UUID,
    shipping_company    VARCHAR(64),
    price               INTEGER,
    is_express          BOOLEAN,
    CONSTRAINT shipping_method_pk PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS clients
(
    id              UUID,
    itn             INTEGER,
    name            VARCHAR(64),
    CONSTRAINT client_pk  PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS orders
(
    id              UUID,
    contracts       UUID,
    shipping_method UUID,
    date            DATE,
    client          UUID,
    CONSTRAINT order_pk PRIMARY KEY(id),
    CONSTRAINT contract_fk
        FOREIGN KEY (contracts)
            REFERENCES contracts(id),
    CONSTRAINT shipping_method_fk
        FOREIGN KEY (shipping_method)
            REFERENCES shipping_methods(id),
    CONSTRAINT client_id_fk
        FOREIGN KEY (client)
            REFERENCES clients(id)
);
