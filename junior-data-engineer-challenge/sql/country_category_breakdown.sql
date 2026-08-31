DROP TABLE IF EXISTS country_category_breakdown;

CREATE TABLE country_category_breakdown AS
SELECT
    oc.country,
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
    ) AS revenue_eur
FROM orders_clean oc
LEFT JOIN fx_rates fx
    ON oc.fx_reference_date = fx.rate_date
WHERE oc.category IN ('Books', 'Electronics')
GROUP BY oc.country
HAVING SUM(
    CASE
        WHEN oc.currency = 'EUR'
            THEN oc.qty * oc.unit_price

        WHEN oc.currency = 'RON'
            THEN oc.qty * oc.unit_price * fx.rate
    END
) > 40000
ORDER BY revenue_eur DESC;