WITH base_actuals AS (
    SELECT
        DATE(month)          AS month,
        account,
        amount
    FROM actuals
),

monthly_rollup AS (
    SELECT
        month,
        account,
        SUM(amount) AS actual_amount
    FROM base_actuals
    GROUP BY month, account
),

ordered_actuals AS (
    SELECT
        month,
        account,
        actual_amount,
        ROW_NUMBER() OVER (
            PARTITION BY account
            ORDER BY month
        ) AS month_seq
    FROM monthly_rollup
)

SELECT
    month,
    account,
    actual_amount,
    month_seq
FROM ordered_actuals
ORDER BY account, month;
