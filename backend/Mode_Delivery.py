import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import accuracy_score
from scipy import stats
from sklearn.preprocessing import MinMaxScaler
# import matplotlib.pyplot as plt
from flask import Flask, request, jsonify

app = Flask(__name__)

# create a MinMaxScaler object
scaler = MinMaxScaler()

# Load the dataset
df = pd.read_csv('backend/dataset_mod.csv')

num_na_rows = df.isnull().sum(axis=1).astype(bool).sum()
total_rows = df.shape[0]

# print('Number of N/A rows: {}'.format(num_na_rows))
# print('Number of total rows: {}'.format(total_rows))

#remove N/A values
df.dropna() 
# print('Number of records after removing N/A values: {}'.format(df.shape[0]))

# Calculate the z-scores for each data point
# z_scores = np.abs((df - df.mean()) / df.std())
z_scores = np.abs(stats.zscore(df))
# print(z_scores)

# Plot the distribution of the z-scores to understand the outliers lied at in the distribution
# plt.hist(z_scores.values.flatten(), bins=20)
# plt.xlabel('Z-score')
# plt.ylabel('Frequency')
# plt.show()

# Choose a threshold based on the distribution of the z-scores
min_threshold = 2.5
max_threshold = 5
# print('Number of rows after removing outliers using 4 std dev: {}'.format(df[(z_scores < min_threshold).all(axis=1)].shape[0]))
# print('Number of rows after removing outliers using 5 std dev: {}'.format(df[(z_scores < max_threshold).all(axis=1)].shape[0]))
# print('Number of rows that are within std dev 4 to 5: {}'.format(abs(df[(z_scores < min_threshold).all(axis=1)].shape[0]- df[(z_scores < max_threshold).all(axis=1)].shape[0])))

df = df[(z_scores < min_threshold).all(axis=1)]
# print(df.shape[0])

df_normalized = pd.DataFrame(scaler.fit_transform(df), columns=df.columns)
df_normalized.head(20)

X = df.drop(columns='delivery_mode', axis=1)
# print(X.shape)
y = df['delivery_mode']

# X = df_normalized.drop(columns='delivery_mode', axis=1)
# print(X.shape)
# y = df_normalized['delivery_mode']

X_train, X_test, y_train, y_test = train_test_split(X,y, test_size=0.2, random_state=42)

# Train a Random Forest classifier with 100 trees
#rfc = RandomForestClassifier(n_estimators=100, random_state=42)
# Initialize the random forest classifier with hyperparameters
#rfc = RandomForestClassifier(n_estimators=100, max_depth=17, random_state=42)
rfc = RandomForestClassifier(n_estimators=100, max_depth=17, min_samples_leaf=1, min_samples_split=2, random_state=42)

rfc.fit(X_train, y_train)

# Predict the test set labels
y_pred = rfc.predict(X_test)

# Calculate the accuracy score
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy)

#Route 
@app.route('/mode', methods=['POST'])
def predict():
    user_input = request.get_json()

    ns = [user_input['mum_age'], user_input['mum_height'], user_input['presentation_breech'], user_input['presentation_cephalic'], user_input['presentation_other'], user_input['placenta_site_previa'], user_input['amniotic_anhydramnios'], user_input['amniotic_normal'], user_input['hypertension_nil'], user_input['hypertension_pih'], user_input['diabetes_gdm'], user_input['diabetes_nil']]
    ns_reshaped = np.reshape(ns, (1, -1))
# from sklearn.preprocessing import StandardScaler


# scaler = StandardScaler()

# # fit and transform the array using the scaler
# ns_normalized = scaler.fit_transform(ns_reshaped)

# print(ns_normalized)
    predicted_mode_of_delivery = rfc.predict(ns_reshaped)

    if predicted_mode_of_delivery == 0:
        return jsonify('Vaginal Delivery')
    elif predicted_mode_of_delivery == 1:
        return jsonify('Lower segment Caesarean section')
    elif predicted_mode_of_delivery == 2:
        return jsonify('Others')

    # Print the predicted house price
    #print('Predicted mode of delivery:', predicted_mode_of_delivery)
if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=8080)
