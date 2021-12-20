CREATE TABLE IF NOT EXISTS client
(
    id      UUID,
    name    VARCHAR(64),
    number  VARCHAR(10),
    CONSTRAINT client_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS credit_card
(
    id          UUID,
    number      INTEGER,
    date_expire DATE,
    client_id   UUID,
    CONSTRAINT card_pk PRIMARY KEY (id),
    CONSTRAINT client_fk
        FOREIGN KEY (client_id)
            REFERENCES client(id)
);

CREATE TABLE IF NOT EXISTS coupon
(
    id          UUID,
    discount    INTEGER CHECK ( discount > 0 AND discount < 100 ) DEFAULT 5,
    date_expire DATE,
    CONSTRAINT coupon_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS coupon_client
(
    coupon_id   UUID,
    client_id   UUID,
    PRIMARY KEY (coupon_id, client_id),
    CONSTRAINT client_fk
        FOREIGN KEY (client_id)
            REFERENCES client(id),
    CONSTRAINT coupon_fk
        FOREIGN KEY (coupon_id)
            REFERENCES coupon(id)
);

CREATE TABLE IF NOT EXISTS waiter
(
    id      UUID,
    name    VARCHAR(64),
    number  VARCHAR(10),
    CONSTRAINT waiter_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS sitting_table
(
    id          UUID,
    capacity    INTEGER CHECK ( capacity > 0 AND capacity < 20 ),
    CONSTRAINT table_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS reservation
(
    id          UUID,
    start       DATE,
    finish       DATE,
    table_id    UUID,
    CONSTRAINT reservation_pk PRIMARY KEY (id),
    CONSTRAINT table_fk
        FOREIGN KEY (table_id)
            REFERENCES sitting_table(id)
);

CREATE TABLE IF NOT EXISTS menu
(
    id              UUID,
    type            VARCHAR(64),
    is_available    BOOLEAN DEFAULT false,
    CONSTRAINT menu_pk PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS meal
(
    id              UUID,
    name            VARCHAR(64),
    description     VARCHAR(200),
    price           INTEGER CHECK ( price > 0 ),
    is_available    BOOLEAN DEFAULT true,
    menu_id         UUID,
    CONSTRAINT meal_pk PRIMARY KEY (id),
    CONSTRAINT menu_fk
        FOREIGN KEY (menu_id)
            REFERENCES menu(id)
);

CREATE TABLE IF NOT EXISTS ordering
(
    id              UUID,
    client          UUID,
    waiter          UUID,
    sitting_table   UUID,
    CONSTRAINT ordering_pk PRIMARY KEY (id),
    CONSTRAINT client_fk
        FOREIGN KEY (client)
            REFERENCES client(id),
    CONSTRAINT waiter_fk
        FOREIGN KEY (waiter)
            REFERENCES waiter(id),
    CONSTRAINT sitting_table_fk
        FOREIGN KEY (sitting_table)
            REFERENCES sitting_table(id)
);

CREATE TABLE IF NOT EXISTS order_meal
(
    order_id    UUID,
    meal_id     UUID,
    PRIMARY KEY (order_id, meal_id),
    CONSTRAINT order_fk
        FOREIGN KEY (order_id)
            REFERENCES ordering(id),
    CONSTRAINT meal_fk
        FOREIGN KEY (meal_id)
            REFERENCES meal(id)
);