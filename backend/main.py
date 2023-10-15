# from fastapi import FastAPI
# from fastapi.middleware.cors import CORSMiddleware
# from pydantic import BaseModel
# import pandas as pd
# import statsmodels.api as sm
# from datetime import date
# from typing import List
# import pickle
# app = FastAPI()

# app.add_middleware(
#     CORSMiddleware,
#     allow_origins=["http://localhost:33079/"],  # Replace with your frontend domain
#     allow_credentials=True,
#     allow_methods=["POST"],
#     allow_headers=["*"],
# )

# class ARIMAModel:
#     def __init__(self, order=(1, 1, 1)):
#         self.order = order

#     def fit(self, ts):
#         self.model = sm.tsa.ARIMA(ts, order=self.order)
#         self.results = self.model.fit()

#     def predict(self, forecast_steps):
#         forecast = self.results.forecast(steps=forecast_steps)
#         return forecast

# class InputModel(BaseModel):
#     previous_dates: List[date]

# class PredictedDatesResponse(BaseModel):
#     forecasted_dates: str

# @app.post("/predict", response_model=PredictedDatesResponse)
# def predict_menstrual_cycle_dates(input_data: InputModel):
#     # Convert input dates to pandas datetime
#     dates = pd.to_datetime(input_data.previous_dates)

#     # Create a time series
#     ts = pd.Series([1] * len(dates), index=dates)

#     # Fit ARIMA model
#     arima_model = ARIMAModel()
#     arima_model.fit(ts)

#     # Make the predictions from the ARIMA model
#     forecast_steps = 7
#     forecast = arima_model.predict(forecast_steps)

#     # Get the forecasted dates and format them
#     last_date = ts.index[-1]
#     forecasted_dates = pd.date_range(start=last_date, periods=forecast_steps + 1, closed='right')
#     forecasted_dates = forecasted_dates[1:]  # Exclude the last date since it's in the past
#     formatted_forecasted_dates = forecasted_dates.strftime("%d-%m-%Y")

#     date_range_sentence = f"Your next cycle may fall between {formatted_forecasted_dates[0]}, {formatted_forecasted_dates[-1]}, and {formatted_forecasted_dates[-2]}."

#     return PredictedDatesResponse(forecasted_dates=date_range_sentence)

from datetime import timedelta
import pandas as pd
import numpy as np

# Set a random seed for reproducibility
np.random.seed(0)

# Generate synthetic data
samples = 1000
data = {
    'LoggedDate': pd.date_range(start='2023-01-01', periods=samples, freq='20D'),
    'CycleLength': np.random.randint(21, 35, samples),
    'OvulationDay': np.random.randint(12, 28, samples)
}

# Calculate the 'PeriodDate' by adding 'CycleLength' days to 'LoggedDate'
data['PeriodDate'] = data['LoggedDate'] + pd.to_timedelta(data['CycleLength'], unit='D')

# Create a DataFrame
df = pd.DataFrame(data)

# Save the data to a CSV file
df.to_csv('period_data.csv', index=False)

