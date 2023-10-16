from flask import Flask, request, jsonify
from flask_cors import CORS
import joblib

app = Flask(__name__)

CORS(app)
#load model
model = joblib.load("mlmodel.pickle")
@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    if data is None:
        return jsonify({"error":"Invalid input data"}), 400
    
    #prediction logic
    try:
        prediction = model.predict(data)
        return jsonify({"prediction": prediction})
    except Exception as e:
        return jsonify({"error":str(e)}), 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port= 5000)