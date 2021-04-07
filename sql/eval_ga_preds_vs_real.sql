with raw_forecast_data as (SELECT
  *
FROM
  ML.FORECAST(MODEL `<youraccountname>.<dataset>.ga_sarima`,
              STRUCT(30 AS horizon, 0.8 AS confidence_level))),

forecast_data as (              
SELECT
FORMAT_TIMESTAMP("%Y-%m-%d", forecast_timestamp) as date,
forecast_value
FROM
raw_forecast_data
GROUP BY 1,2),

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
    AND hits.TRANSACTION.transactionId IS NOT NULL ),
ga_data as (
SELECT
  CAST(FORMAT_TIMESTAMP("%Y-%m-%d", PARSE_TIMESTAMP("%Y%m%d", date )) as STRING ) as date,
  COUNT(orders) AS real_figures
FROM
  raw_data
GROUP BY
  date
ORDER BY
  date ASC)

SELECT
forecast_data.date,
CAST(ROUND(forecast_value,2) as int64) as forecast_value,
real_figures
FROM forecast_data
JOIN ga_data
USING(date)
GROUP By 1,2,3
ORDER BY date ASC