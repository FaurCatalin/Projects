DROP TABLE IF EXISTS customer_spend_eur;

CREATE TABLE customer_spend_eur AS
SELECT
    oc.customer_id,
    oc.customer_email,
    ROUND(
        SUM(
            CASE
                WHEN oc.currency = 'EUR'
                    THEN oc.qty * oc.unit_price

                WHEN oc.currency = 'RON'
                    THEN oc.qty * oc.unit_price * fx.rate
            END
        )::numeric,
        2
    ) AS total_spend_eur
FROM orders_clean oc
LEFT JOIN fx_rates fx
    ON oc.fx_reference_date = fx.rate_date
GROUP BY
    oc.customer_id,
    oc.customer_email;