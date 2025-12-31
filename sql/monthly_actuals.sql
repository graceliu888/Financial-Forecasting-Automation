SELECT
  month,
  account,
  SUM(amount) AS actual_amount
FROM actuals
GROUP BY month, account
ORDER BY month, account;
