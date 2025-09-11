import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from app.preprocessing import DataPreprocessor
import pickle
import os
import numpy as np

url = "https://archive.ics.uci.edu/ml/machine-learning-databases/adult/adult.data"
columns = ['age', 'workclass', 'fnlwgt', 'education', 'education-num', 
           'marital-status', 'occupation', 'relationship', 'race', 'sex',
           'capital-gain', 'capital-loss', 'hours-per-week', 'native-country', 'salary']

df = pd.read_csv(url, names=columns, na_values=' ?', skipinitialspace=True)
df.dropna(inplace=True)

X = df.drop('salary', axis=1)
y = (df['salary'] == '>50K').astype(int)

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

preprocessor = DataPreprocessor()
preprocessor.fit(X_train)

os.makedirs('data', exist_ok=True)
with open('data/preprocessor.pkl', 'wb') as f:
    pickle.dump(preprocessor, f)

X_train_processed = preprocessor.transform(X_train)
X_test_processed = preprocessor.transform(X_test)

# Обучение модели
model = RandomForestClassifier(
    n_estimators=100,
    random_state=42,
    class_weight='balanced'
)
model.fit(X_train_processed, y_train)

with open('data/model.pkl', 'wb') as f:
    pickle.dump(model, f)

train_score = model.score(X_train_processed, y_train)
test_score = model.score(X_test_processed, y_test)

print(f"Model trained successfully")
print(f"Train accuracy: {train_score:.3f}")
print(f"Test accuracy: {test_score:.3f}")