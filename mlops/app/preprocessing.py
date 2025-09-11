import pandas as pd
from sklearn.preprocessing import StandardScaler
from sklearn.impute import SimpleImputer
import numpy as np

class DataPreprocessor:
    def __init__(self):
        self.scaler = StandardScaler()
        self.imputer = SimpleImputer(strategy='most_frequent')
        self.categorical_mappings = {}
        self.numeric_features = []
        self.categorical_features = []

    def fit(self, df):
        self.numeric_features = df.select_dtypes(include=['int64', 'float64']).columns.tolist()
        self.categorical_features = df.select_dtypes(include=['object']).columns.tolist()
        
        for col in self.categorical_features:
            unique_vals = df[col].unique()
            self.categorical_mappings[col] = {val: idx for idx, val in enumerate(unique_vals)}
        
        if len(self.numeric_features) > 0:
            self.imputer.fit(df[self.numeric_features])
            self.scaler.fit(self.imputer.transform(df[self.numeric_features]))

    def transform(self, df):
        df = df.copy()
        
        for col in self.categorical_features:
            if col in df.columns:
                df[col] = df[col].apply(lambda x: self.categorical_mappings[col].get(x, -1))
        
        if len(self.numeric_features) > 0:
            imputed_values = self.imputer.transform(df[self.numeric_features])
            scaled_values = self.scaler.transform(imputed_values)
            df[self.numeric_features] = scaled_values
        
        return df

    def get_feature_names(self):
        return self.numeric_features + list(self.categorical_mappings.keys())