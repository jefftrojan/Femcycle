from fastapi import FastAPI, Depends
from pydantic import BaseModel
import pandas as pd
import statsmodels.api as sm
from datetime import date
import os
from dotenv import load_dotenv
import firebase_admin
from firebase_admin import credentials, firestore, auth

load_dotenv()

# Initialize Firebase Admin SDK using your Firebase Admin SDK key
firebase_admin_sdk_key = os.environ.get("FirebaseSDK")
cred = credentials.Certificate(firebase_admin_sdk_key)
firebase_admin.initialize_app(cred)

app = FastAPI()

# Input model
class InputModel(BaseModel):
    previous_dates: list[date]

# Dependency to get the current user's Firebase UID
# def get_current_user_uid(id_token: str = Depends(auth.decode_id_token)):
#     return id_token["uid"]
def get_current_user_uid(id_token: str = Depends(auth.verify_id_token)):
    return id_token['uid']

@app.post("/predict")
def predict_menstrual_cycle_dates(
    input_data: InputModel, current_user_uid: str = Depends(get_current_user_uid)
):
    # Convert input dates to pandas datetime
    dates = pd.to_datetime(input_data.previous_dates)

    # Create a time series
    ts = pd.Series([1] * len(dates), index=dates)

    # Fit an ARIMA model (you can adjust the order as needed)
    order = (1, 1, 1)  # Replace with the appropriate order for your data
    arima_model = sm.tsa.ARIMA(ts, order=order)
    arima_results = arima_model.fit()
    
    # Make predictions from the ARIMA model
    forecast_steps = 7
    forecast = arima_results.forecast(steps=forecast_steps)

    # Get the forecasted dates and format them
    last_date = ts.index[-1]
    forecasted_dates = pd.date_range(start=last_date, periods=forecast_steps + 1, closed='right')
    forecasted_dates = forecasted_dates[1:]  # Exclude the last date since it's in the past
    formatted_forecasted_dates = forecasted_dates.strftime("%d-%m-%Y")

    # Update historical data in Firestore for the current user
    db = firestore.client()
    user_id = current_user_uid  # Use the Firebase UID as the user ID
    user_ref = db.collection('users').document(user_id)

    # Get the current historical data from Firestore
    user_data = user_ref.get().to_dict()
    if user_data is None:
        user_data = {}

    # Add the newly logged period dates to historical data
    if 'historical_dates' not in user_data:
        user_data['historical_dates'] = []

    user_data['historical_dates'].extend(input_data.previous_dates)

    # Update the historical data in Firestore
    user_ref.set(user_data, merge=True)

    date_range_sentence = f"Your next cycle may fall between {formatted_forecasted_dates[0]}, {formatted_forecasted_dates[-1]}, and {formatted_forecasted_dates[-2]}."
    
    return {"forecasted_dates": date_range_sentence}
