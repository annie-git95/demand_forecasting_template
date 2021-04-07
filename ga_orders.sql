WITH
  raw_data AS (
  SELECT
    date,
    hits.TRANSACTION.transactionId AS orders
  FROM
    `<youraccountname>.<dataset>.ga_sessions_*`,
    UNNEST(hits) AS hits
  WHERE
    _TABLE_SUFFIX BETWEEN @start_date
    AND @end_date
    AND hits.TRANSACTION.transactionId IS NOT NULL )
SELECT
  date,
  COUNT(orders) AS dependent
FROM
  raw_data
GROUP BY
  date
ORDER BY
  date ASC