# Demand Forecasting on BigQuery ML

## About The Project

This project is about building a Demand Forecast model using either python libraries or BigQuery ML. The data is taken from Google Analytics database and is using SARIMA modelling to predict future orders. The code is written in a modular way and can be applied to any demand forecasting use case e.g. trends of a disease, stock performance, population growth etc. Just add your own data source and follow the steps in the notebook. 

Note: The code outputs interactive graphs of predicted vs. actual numbers that are not displayed on github. To fully visualize the results, please run the code on your environment.

The model will show the next 30 day demand for each country and can be deployed on a dashboard using Tableau or Google Data Studio. 


### Built With

This solution uses the following technologies



*  [Google Cloud BigQuery](https://cloud.google.com/bigquery/docs)



*  [Python 3.7.9](https://www.python.org/downloads/release/python-379/)


* [Google Cloud Compute Engine](https://cloud.google.com/compute)

## Getting Started

In order to get started you need to complete the following steps:

1. [Set up a Google Cloud Project](https://developers.google.com/gsuite/marketplace/create-gcp-project)
2. [Install Python 3.7.9](https://www.python.org/downloads/release/python-379/)
3. Install pip or conda install requirements file
4. [Get BigQuery Admin access](https://cloud.google.com/bigquery/docs/access-control)
5. Create a AI platform notebook.
   [Set up notebook here](https://cloud.google.com/ai-platform/notebooks/docs/create-new)
   
     * Use Tensorflow 2.3 instance
     * Ensure the service account is the compute engine default one
     * Start with a 4 CPUs instance
    
6. If you plan to automate this create a compute engine instance. 

### Pip install requirements.txt

This is an example of how to list things you need to use the software and how to install them.

  ```
  pip install -r requirements.txt
  ```

## Solution Design

This solution is broken down into 4 stages.

1. Stage 1 - Get data from Google Analytics to BigQuery

This process is set up in Google Analytics by following [these instructions]:(https://support.google.com/analytics/answer/3416092?hl=en)

2. Stage 2 - Prepare training table for each counttry

Here we will prepare the training data using a SQL query where the data source is the **ga_sessions** table

3. Stage 3 - Create the model and forecast predictions

Each country will have it's own model and its own results table. 

4. Stage 4 - Visualize results

This will be done via a Data Studio dashboard

[Data Studio Link]: (https://datastudio.google.com/reporting/712ce595-a4c1-48b5-aa85-24268902739b)


## How it works


### Building from the template notebook 
Inside the the **sarima** folder there is a notebook called **sarima_template.ipynb** This notebook will serve as a template for all forecasting projects involving Google Analytics or online store data. 

The first step is to set the **install_dependencies** variable as True. By default it is False.

```
install_dependencies = False
if install_dependencies:
    !pip install plotly==4.12.0
    !pip install pmdarima
    !pip install pystan
    !pip install fbprophet
```

Then set up the environment variables to match for your project.

The second step is to set up your queries. In the **sql** folder all the queries will be placed in there.

* ga_orders.sql - Only uses Google Analytics data and serves as the template SQL
* sql/ - BigQuery Machine Learning SQL queries.



#### Google Analytics Query Instruction

There are two parameters here that need to be entered the @start_date and @end_date. 

For example if you want to forecast from February 01,2021 until February 28, 2021 your start_date and end_date need the last 30 days. 

start_date = 2021-01-01
end_date = 2021-02-01


And there is a folder called **bqml**. This folder contains all the queries for creating, forecasting and saving the results to BigQuery. 

Here there are 3 queries

* b_source_create_model.sql - Creates the model or models depending on the number of countries
* b_source_eval_real_vs_preds.sql - Evaluates the model results against the real results
* b_source_forecast.sql - Forecasts the real results


## Contributing

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

