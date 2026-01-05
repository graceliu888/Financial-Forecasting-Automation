WITH monthly AS (
    SELECT
        DATE(month) AS month,
        account,
        SUM(amount) AS actual_amount
    FROM actuals
    GROUP BY month, account
),

metrics AS (
    SELECT
        month,
        account,
        actual_amount,

        -- Prior month
        LAG(actual_amount, 1) OVER (
            PARTITION BY account
            ORDER BY month
        ) AS prior_month_amount,

        -- Prior year same month
        LAG(actual_amount, 12) OVER (
            PARTITION BY account
            ORDER BY month
        ) AS prior_year_amount,

        -- 3-month rolling average
        AVG(actual_amount) OVER (
            PARTITION BY account
            ORDER BY month
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) AS rolling_3m_avg

    FROM monthly
)

SELECT *
FROM metrics
ORDER BY account, month;
