import pickle
from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib

app = Flask(__name__)

CORS(app)
#load model
# model = joblib.load("mlmodel.pickle")
with open("mlmodel.pickle", "rb") as model_file:
    model = pickle.load(model_file)

@app.route("/", methods=["GET"])

@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json()
        logged_date = data.get('LoggedDate')

        
        prediction = model.predict(logged_date)

        prediction = logged_date

        return jsonify({"prediction": prediction})
    except Exception as e:
        return jsonify({"error": str(e)}), 500



if __name__ == "__main__":
    app.run(host="0.0.0.0", port= 5000)