SELECT
  *
FROM
  ML.FORECAST(MODEL `<youraccountname>.<dataset>.ga_sarima`,
              STRUCT(30 AS horizon, 0.8 AS confidence_level))