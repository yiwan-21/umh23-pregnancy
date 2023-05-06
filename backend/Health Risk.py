from flask import Flask, jsonify, request
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score
from sklearn.preprocessing import StandardScaler
import numpy as np
import pandas as pd
from scipy import stats
import warnings

warnings.filterwarnings('ignore')

# Load the dataset
data = pd.read_csv("backend/Maternal Health Risk Data Set.csv")

# Map 'RiskLevel' column from categorical to numerical values
risk_mapping = {"high risk": 0, "low risk": 1, "mid risk": 2}
data["RiskLevel"] = data["RiskLevel"].map(risk_mapping)

# Drop the missing values
data.dropna(inplace=True)

# converting the columns to numeric data types 
data['Age'] = pd.to_numeric(data['Age'], errors='coerce')
data['SystolicBP'] = pd.to_numeric(data['SystolicBP'], errors='coerce')
data['DiastolicBP'] = pd.to_numeric(data['DiastolicBP'], errors='coerce')
data['BS'] = pd.to_numeric(data['BS'], errors='coerce')
data['BodyTemp'] = pd.to_numeric(data['BodyTemp'], errors='coerce')
data['HeartRate'] = pd.to_numeric(data['HeartRate'], errors='coerce')

# Drop the outliers
# Calculate z-scores for each column in the dataframe
z_scores = stats.zscore(data.iloc[:, :-1])

# Find all rows where the absolute z-score for any column is greater than 3
mask = (np.abs(z_scores) < 3).all(axis=1)

# Remove the rows where the mask is False
data = data[mask]

# Drop missing value row
data = data.dropna()

# Normalize the data
scaler = StandardScaler()
X = scaler.fit_transform(data.drop('RiskLevel', axis=1))
y = data['RiskLevel']
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Define the model and its hyperparameters
model = RandomForestClassifier(n_estimators=100, random_state=42)

# Train the model
model.fit(X_train, y_train)

# Define a Flask app
app = Flask(__name__)

# Define a route to accept POST requests
@app.route('/healthrisk', methods=['POST'])
def get_health_risk():
    # Retrieve the user input from the request body
    user_input = request.get_json()
    print("Hello")

    # Convert the user input to a numpy array
    new_sample = user_input['Age'], user_input['SystolicBP'], user_input['DiastolicBP'], user_input['BS'], user_input['BodyTemp'], user_input['HeartRate']

    # Normalize the new sample
    new_sample = scaler.transform([new_sample])

    # Use the trained model to predict the RiskLevel of the new sample
    predicted_risk = model.predict(new_sample)[0]

    # Denormalize the predicted RiskLevel
    predicted_risk = int(predicted_risk * (data['RiskLevel'].max() - data['RiskLevel'].min()) + data['RiskLevel'].min())

    # Decode the predicted RiskLevel back to its original categorical value
    risk_mapping = {0: "high risk", 1: "low risk", 2: "mid risk"}
    predicted_risk = risk_mapping[predicted_risk]

    # Print the predicted RiskLevel
    print("Predicted RiskLevel:", predicted_risk)

    # Return a JSON response with the predicted RiskLevel
    return jsonify({'predicted_risk': predicted_risk}) 

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)