WITH monthly AS (
    SELECT
        DATE(month) AS month,
        account,
        SUM(amount) AS actual_amount
    FROM actuals
    GROUP BY month, account
),

baseline AS (
    SELECT
        month,
        account,
        actual_amount,

        -- Seasonal naive baseline
        LAG(actual_amount, 12) OVER (
            PARTITION BY account
            ORDER BY month
        ) AS baseline_forecast

    FROM monthly
)

SELECT
    month,
    account,
    actual_amount,
    baseline_forecast
FROM baseline
ORDER BY account, month;
