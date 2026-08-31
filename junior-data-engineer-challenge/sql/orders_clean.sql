DROP TABLE IF EXISTS orders_clean;

CREATE TABLE orders_clean AS
SELECT DISTINCT *
FROM orders_raw
WHERE status <> 'test'
  AND qty >= 0
  AND unit_price <> 999999;