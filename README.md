Demand Forecasting on BigQuery ML
About The Project
This project is about building a Demand Forecast model using either BigQueryML or Python libraries.

The aim is to build a model that will show the next 30 day demand for each country and business source.

This should be something that can be deployed on a dashboard using Tableau or Google Data Studio.

Limitations

It only will present countries and business sources with more than 999 daily values.
Some countries do not have any data so those results will not be presented
It is not real time model it does daily refreshes of the results.
Built With
This solution uses the following technologies

Google Cloud BigQuery

Python 3.7.9

Google Cloud Compute Engine

Getting Started
In order to get started you need to complete the following steps:

Set up a Google Cloud Project
Install Python 3.7.9
Install pip or conda install requirements file
Get BigQuery Admin access
Create a AI platform notebook. Set up notebook here

Use Tensorflow 2.3 instance
Ensure the service account is the compute engine default one
Start with a 4 CPUs instance
If you plan to automate this create a compute engine instance.

Pip install requirements.txt
This is an example of how to list things you need to use the software and how to install them.

pip install -r requirements.txt

Solution Design
This solution is broken down into 4 stages.

Stage 1 - Get data from Google Analytics to BigQuery
This process is set up in Google Analytics by following [these instructions]:(https://support.google.com/analytics/answer/3416092?hl=en)

Stage 2 - Prepare training table for each counttry
Here we will prepare the training data using a SQL query where the data source is the ga_sessions table

Stage 3 - Create the model and forecast predictions
Each country will have it's own model and its own results table.

Stage 4 - Visualize results
This will be done via a Data Studio dashboard

Diagram

How it works
Building from the template notebook
Inside the the sarima folder there is a notebook called sarima.ipynb This notebook will serve as a template for all forecasting projects involving Google Analytics or online store data.

The first step is to set the install_dependencies variable as True. By default it is False.

install_dependencies = False
if install_dependencies:
    !pip install plotly==4.12.0
    !pip install pmdarima
    !pip install pystan
    !pip install fbprophet
Then set up the environment variables to match for your project.

The second step is to set up your queries. In the sql folder all the queries will be placed in there.

ga_orders.sql - Only uses Google Analytics data and serves as the template SQL
order_shipment.sql - Only uses store data and serves as the template SQL
all_countries/ - Contains queries for business_source and country work.
bqml/ - BigQuery Machine Learning queries.
For the production ready work, the code located in the sql/all_countries folder. The rest of the code is meant to be a template for any forecasting solution.

Google Analytics Query Instruction
There are two parameters here that need to be entered the @start_date and @end_date.

For example if you want to forecast from February 01,2021 until February 28, 2021 your start_date and end_date need the last 30 days.

start_date = 2021-01-01 end_date = 2021-02-01

Order Shipments Query Instruction
There are two parameters here that need to be entered the @start_date and @end_date.

For example if you want to forecast from February 01,2021 until February 28, 2021 your start_date and end_date need the last 30 days.

start_date = 2021-01-01 end_date = 2021-01-30

Flash Report Demand Forecast
All queries for this report are located in all_countries/rollup_property folder.

There is the query to collect the training data. It is called "b_source_training_data.sql". This data comes from the Google Analytics View "04 - User ID View (All Platforms) - Live - 04/01/2019" and View ID "187122594".

This view is used because it is the same view used for the flash report. Which is the business facing report.

And there is a folder called bqml. This folder contains all the queries for creating, forecasting and saving the results to BigQuery.

Here there are 3 queries

b_source_create_model.sql - Creates the model or models depending on the number of countries
b_source_eval_real_vs_preds.sql - Evaluates the model results against the real results
b_source_forecast.sql - Forecasts the real results
Automating results
Every day at 1330 at GMT+4 a new forecast will be generated. The reason for this is because the GA_SESSIONS table won't update until 1230 GMT +4

This will execute from a cron job located inside this VM called demand-forecast

The cronjob will execute the Python file all_countries_user_id.py.

Please follow these instructions to know how to amend a cronjob: Link

Contributing
Fork the Project
Create your Feature Branch (git checkout -b feature/AmazingFeature)
Commit your Changes (git commit -m 'Add some AmazingFeature')
Push to the Branch (git push origin feature/AmazingFeature)
Open a Pull Request