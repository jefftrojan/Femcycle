from fastapi import FastAPI
from pydantic import BaseModel
import pandas as pd
import statsmodels.api as sm
from datetime import date, timedelta
from sklearn.metrics import mean_absolute_error

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
    ovulation_date: date  # User logs OvulationDay

@app.post("/predict")
def predict_menstrual_cycle_dates(input_data: InputModel):
    # Load data from a CSV file
    data = pd.read_csv('your_data.csv')  # Replace 'your_data.csv' with the actual CSV file path

    # Assuming your CSV file columns are named as 'LoggedDate', 'CycleLength', 'OvulationDay', 'PeriodDate'
    # You can select the 'PeriodDate' and 'OvulationDay' columns
    data = data[['OvulationDay', 'PeriodDate']]

    # Sort the data by 'OvulationDay' in ascending order
    data = data.sort_values(by='OvulationDay', ascending=True)

    # Convert 'OvulationDay' and 'PeriodDate' to datetime
    data['OvulationDay'] = pd.to_datetime(data['OvulationDay'])
    data['PeriodDate'] = pd.to_datetime(data['PeriodDate'])

    # Find the nearest 'OvulationDay' to the user's input
    user_ovulation_date = input_data.ovulation_date
    nearest_ovulation_date = data['OvulationDay'].sub(user_ovulation_date).abs().idxmin()

    # Calculate the 'PeriodDate' based on the nearest 'OvulationDay'
    period_date = data.loc[nearest_ovulation_date, 'PeriodDate'] + timedelta(days=14)

    # Format the predicted 'PeriodDate'
    formatted_period_date = period_date.strftime("%d-%m-%Y")

    # Calculate the MAE
    actual_period_date = period_date  # You need to define the actual period date based on your dataset
    mae = mean_absolute_error([actual_period_date], [period_date])
    print(mae)

    return {"predicted_period_date": formatted_period_date, "mae": mae}
