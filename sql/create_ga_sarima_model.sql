CREATE OR REPLACE MODEL `<youraccountname>.<dataset>.ga_sarima` 
 OPTIONS(MODEL_TYPE='ARIMA',
         time_series_timestamp_col='date',
         time_series_data_col='dependent',
         AUTO_ARIMA = TRUE,
         DATA_FREQUENCY = 'DAILY',
         HOLIDAY_REGION = 'AE') AS
SELECT
  #cast(date as date) as date,
   CAST(FORMAT_TIMESTAMP("%Y-%m-%d", PARSE_TIMESTAMP("%Y%m%d", date )) as DATE )AS date,
  dependent
FROM
  `<youraccountname>.<dataset>.training_table`