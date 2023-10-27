import pickle
import pandas as pd
from flask import Flask, render_template, request, jsonify

# Load the SVR model
with open('svr_model.pkl', 'rb') as model_file:
    model = pickle.load(model_file)

app = Flask(__name__)

@app.route('/')
def index():
    # Render the HTML template
    return render_template('predict_periods.html')

@app.route('/predict', methods=['POST'])
def predict():
    try:
        # Get data from the JSON request
        data = request.get_json()

        # Check if the 'Dates' key exists in the JSON data
        if 'Dates' in data:
            dates = data['Dates']
        else:
            return jsonify({'error': 'Missing "Dates" in the request data'}), 400

        # Ensure that 'Dates' is a list (you may need to adapt this part depending on your input)
        if not isinstance(dates, list):
            return jsonify({'error': 'Dates must be a list'}), 400

        # Make predictions using the loaded model
        predictions = model.predict(pd.DataFrame({'Dates': dates}))

        # Convert numeric predictions to date format
        formatted_predictions = [pd.to_datetime('2023-01-01') + pd.DateOffset(days=int(prediction)) for prediction in predictions]

        # Return the formatted predictions as a list of date strings
        formatted_predictions_str = [prediction.strftime('%Y-%m-%d') for prediction in formatted_predictions]

        # Return the predictions as JSON
        return jsonify({'predictions': formatted_predictions_str}), 200

    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
