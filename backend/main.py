from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import statsmodels.api as sm
from datetime import date

app = FastAPI()
from fastapi.middleware.cors import CORSMiddleware

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

class ARIMAModel:
    def __init__(self, order=(1, 1, 1)):
        self.order = order

    def fit(self, ts):
        self.model = sm.tsa.ARIMA(ts, order=self.order)
        self.results = self.model.fit()

    def predict(self, forecast_steps):
        forecast = self.results.forecast(steps=forecast_steps)
        return forecast

# Input model
class InputModel(BaseModel):
    previous_dates: list[date]

@app.post("/predict")
def predict_menstrual_cycle_dates(input_data: InputModel):
    # convert input dates to pandas datetime
    dates = pd.to_datetime(input_data.previous_dates)

    # create a time series
    ts = pd.Series([1] * len(dates), index=dates)

    # Fit ARIMA model
    arima_model = ARIMAModel()
    arima_model.fit(ts)
    

    # Make  teh predictions from the arim model
    forecast_steps = 7
    forecast = arima_model.predict(forecast_steps)

    # get the forecasted dates and format them
    last_date = ts.index[-1]
    forecasted_dates = pd.date_range(start=last_date, periods=forecast_steps + 1, closed='right')
    forecasted_dates = forecasted_dates[1:]  # Exclude the last date since it's in the past
    formatted_forecasted_dates = forecasted_dates.strftime("%d-%m-%Y")


    date_range_sentence = f"Your next cycle may fall between {formatted_forecasted_dates[0]}, {formatted_forecasted_dates[-1]}, and {formatted_forecasted_dates[-2]}."

    return {"forecasted_dates": date_range_sentence}
