from flask import Flask, request, jsonify
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import StandardScaler
import numpy as np

app = Flask(__name__)

# Load the dataset
data = pd.read_csv('backend/Gestational-Diabetic-Dat-Set.csv')

# Drop useless columns
data = data.drop(['OGTT', 'Case Number'], axis=1)

# Remove rows with missing values
data = data.dropna()

# Split the data into features and target
X = data.drop('Class Label(GDM /Non GDM)', axis=1)
y = data['Class Label(GDM /Non GDM)']

# Normalize the data
scaler = StandardScaler()
X = scaler.fit_transform(X)

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Train the random forest classifier
clf = RandomForestClassifier(random_state=42, n_estimators=49, max_depth=7)
clf.fit(X_train, y_train)

@app.route('/gestation', methods=['POST'])
def predict():
    # Retrieve the input from the request
    user_input = request.get_json()

    # Convert the input to a numpy array
    input_array = [user_input['Age'], user_input['No of Pregnancy'], user_input['Gestation in previous Pregnancy'], user_input['BMI'], user_input['HDL'], user_input['Family History'], user_input['unexplained prenetal loss'], user_input['Large Child or Birth Default'], user_input['PCOS'], user_input['Sys BP'], user_input['Dia BP'], user_input['Hemoglobin'],user_input['Sedentary Lifestyle'], user_input['Prediabetes']]
    
    # Normalize the input
    input_array = scaler.transform([input_array])

    # Make a prediction
    prediction = clf.predict(input_array)

    # Return the prediction as a JSON response
    if prediction == 1:
        return jsonify('GDM')
    elif prediction == 0:
        return jsonify('Non GDM')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)