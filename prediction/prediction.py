import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report
import datetime
import joblib

# Generate synthetic data
np.random.seed(0)
n_samples = 1000

# Simulate features (you can replace these with real features)
age = np.random.uniform(12, 55, n_samples)
cycle_length = np.random.uniform(20, 45, n_samples)
period_pain = np.random.choice([0, 1], n_samples)
stress_level = np.random.uniform(1, 10, n_samples)

# Define a function to simulate period prediction based on features
def simulate_period_prediction(age, cycle_length, period_pain, stress_level):
    probability = 1 / (1 + np.exp(-(-2 + 0.05 * age + 0.03 * cycle_length - 0.5 * period_pain + 0.1 * stress_level)))
    return np.random.binomial(1, probability)

# Generate target labels
y = [simulate_period_prediction(age[i], cycle_length[i], period_pain[i], stress_level[i]) for i in range(n_samples)]

# Create a DataFrame with the generated data
data = pd.DataFrame({'Age': age, 'CycleLength': cycle_length, 'PeriodPain': period_pain, 'StressLevel': stress_level, 'Period': y})

# Split the data into training and testing sets
X = data.drop('Period', axis=1)
y = data['Period']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Data preprocessing (you can add more feature engineering and preprocessing as needed)
scaler = StandardScaler()
X_train = scaler.fit_transform(X_train)
X_test = scaler.transform(X_test)

# Build and train the logistic regression model
model = LogisticRegression()
model.fit(X_train, y_train)

# Make predictions
y_pred = model.predict(X_test)

# Evaluate the model
accuracy = accuracy_score(y_test, y_pred)
conf_matrix = confusion_matrix(y_test, y_pred)
class_report = classification_report(y_test, y_pred)

# Print the evaluation results
print("Accuracy:", accuracy)
print("Confusion Matrix:\n", conf_matrix)
print("Classification Report:\n", class_report)

# Define a sample instance with specific feature values
sample_instance = np.array([30, 28, 1, 6]).reshape(1, -1)

# Apply data preprocessing to the sample instance
sample_instance = scaler.transform(sample_instance)

# Predict the probability of having a period (1) or not (0)
probability = model.predict_proba(sample_instance)[0][1]

if probability >= 0.5:
    prediction = 1  # Predicted to have a period
    # Calculate the predicted period date
    today = datetime.date.today()
    predicted_period_date = today + datetime.timedelta(days=28)  # Assuming a cycle length of 28 days
else:
    prediction = 0  # Predicted not to have a period
    predicted_period_date = None  # No period date

# Print the prediction and the predicted period date
if prediction == 1:
    print("The model predicts that the person is likely to have their period.")
    print("Predicted Period Date:", predicted_period_date)
else:
    print("The model predicts that the person is not likely to have their period.")
    print("No predicted period date.")


