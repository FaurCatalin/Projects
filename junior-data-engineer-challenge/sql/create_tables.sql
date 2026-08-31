CREATE TABLE IF NOT EXISTS orders_raw (
    order_id VARCHAR(50),
    customer_id INTEGER,
    customer_email VARCHAR(255),
    order_ts TIMESTAMP,
    status VARCHAR(50),
    channel VARCHAR(50),
    sku VARCHAR(50),
    product_name VARCHAR(255),
    category VARCHAR(100),
    qty INTEGER,
    unit_price NUMERIC(12,2),
    currency VARCHAR(10),
    country VARCHAR(10),
    fx_reference_date DATE
);