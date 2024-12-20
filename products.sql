CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT NOT NULL
);

CREATE TABLE operations_log (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    operation VARCHAR(10) CHECK (operation IN ('ADD', 'REMOVE')),
    quantity INT NOT NULL
);

CREATE OR REPLACE FUNCTION update_stock(product_id INT, operation VARCHAR, quantity INT) RETURNS VOID AS $$
BEGIN
    IF operation = 'ADD' THEN
        UPDATE products
        SET quantity = quantity + quantity
        WHERE id = product_id;
    ELSIF operation = 'REMOVE' THEN
        UPDATE products
        SET quantity = quantity - quantity
        WHERE id = product_id
        AND quantity >= quantity;

        IF NOT FOUND THEN
            RAISE EXCEPTION 'Недостаточно товара для выполнения операции';
        END IF;
    ELSE
        RAISE EXCEPTION 'Неверная операция';
    END IF;

    INSERT INTO operations_log (product_id, operation, quantity)
    VALUES (product_id, operation, quantity);
END;
$$ LANGUAGE plpgsql;
