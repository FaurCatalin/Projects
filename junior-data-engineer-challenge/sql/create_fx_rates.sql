CREATE TABLE IF NOT EXISTS fx_rates (
    rate_date DATE,
    base_currency VARCHAR(10),
    target_currency VARCHAR(10),
    rate NUMERIC(12,6)
);