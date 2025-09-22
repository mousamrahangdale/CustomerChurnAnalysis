import pandas as pd
import psycopg2

# Connect to PostgreSQL
conn = psycopg2.connect(
    dbname="customerchurn",
    user="postgres",
    password="*******",
    host="localhost",
    port="5432"
)
cur = conn.cursor()
query = "SELECT * FROM vw_ChurnData;"
df = pd.read_sql(query, conn)
print(df.head())
conn.close()

df.to_csv("viewChurndata.csv",index=False)
churndata=pd.read_csv("viewchurndata.csv")
churndata
churndata["customer_status"].unique()

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.preprocessing import LabelEncoder
import joblib

# Drop columns that won't be used for prediction
churndata = churndata.drop(['customer_id', 'churn_category', 'churn_reason'], axis=1)

# List of columns to be label encoded
columns_to_encode = [
    'gender', 'married', 'state', 'value_deal', 'phone_service', 'multiple_lines',
    'internet_service', 'internet_type', 'online_security', 'online_backup',
    'device_protection_plan', 'premium_support', 'streaming_tv', 'streaming_movies',
    'streaming_music', 'unlimited_data', 'contract', 'paperless_billing',
    'payment_method'
]

# Encode categorical variables except the target variable
label_encoders = {}
for column in columns_to_encode:
    label_encoders[column] = LabelEncoder()
    churndata[column] = label_encoders[column].fit_transform(churndata[column])

# Manually encode the target variable 'Customer_Status'
churndata['customer_status'] = churndata['customer_status'].map({'Stayed': 0, 'Churned': 1})

# Split data into features and target
X = churndata.drop('customer_status', axis=1)
y = churndata['customer_status']

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Initialize the Random Forest Classifier
rf_model = RandomForestClassifier(n_estimators=100, random_state=42)

# Train the model
rf_model.fit(X_train, y_train)

# Make predictions
y_pred = rf_model.predict(X_test)

# Evaluate the model
print("Confusion Matrix:")
print(confusion_matrix(y_test, y_pred))
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# Feature Selection using Feature Importance
importances = rf_model.feature_importances_
indices = np.argsort(importances)[::-1]

# Plot the feature importances
plt.figure(figsize=(15, 6))
sns.barplot(x=importances[indices], y=X.columns[indices])
plt.title('Feature Importances')
plt.xlabel('Relative Importance')
plt.ylabel('Feature Names')
plt.show()


conn = psycopg2.connect(
    dbname="customerchurn",
    user="postgres",
    password="*******",
    host="localhost",
    port="5432"
)
cur = conn.cursor()
query = "SELECT * FROM vw_joinData;"
df = pd.read_sql(query, conn)
print(df.head())
conn.close()

df.to_csv("predictiondata.csv",index=False)
new_data=pd.read_csv("predictiondata.csv")
new_data

# Display the first few rows of the fetched data
print(new_data.head())

original_data = new_data.copy()
# Now use lowercase everywhere
customer_ids = new_data['customer_id']
new_data = new_data.drop(['customer_id', 'customer_status', 'churn_category', 'churn_reason'], axis=1)

# Use errors='ignore' to avoid KeyError if a column is missing
new_data = new_data.drop(['customer_id', 'customer_status', 'churn_category', 'churn_reason'], axis=1, errors='ignore')
# Encode categorical variables using the saved label encoders
for column in new_data.select_dtypes(include=['object']).columns:
    new_data[column] = label_encoders[column].transform(new_data[column])
  
# Make predictions
new_predictions = rf_model.predict(new_data)

# Add predictions to the original DataFrame
original_data['Customer_Status_Predicted'] = new_predictions

# Filter the DataFrame to include only records predicted as "Churned"
original_data = original_data[original_data['Customer_Status_Predicted'] == 1]

original_data.to_csv(r"C:\Users\mousa\Downloads\Predictions.csv", index=False)








