import pickle
import os
import pandas as pd
import numpy as np

class SalaryPredictor:
    def __init__(self):
        self.model = None
        self.preprocessor = None
        
    def load_model(self, model_path, preprocessor_path):
        try:
            with open(model_path, 'rb') as f:
                self.model = pickle.load(f)
            with open(preprocessor_path, 'rb') as f:
                self.preprocessor = pickle.load(f)
        except Exception as e:
            raise Exception(f"Error loading model: {str(e)}")
            
    def predict(self, data):
        try:
            processed_data = self.preprocessor.transform(data)
            return self.model.predict(processed_data)
        except Exception as e:
            raise Exception(f"Error making prediction: {str(e)}")

predictor = SalaryPredictor()