import sys
import os
import pytest

sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from app import create_app
from app.models import SalaryPredictor

@pytest.fixture
def client():
    app = create_app()
    with app.test_client() as client:
        yield client

def test_health(client):
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json['status'] == 'healthy'

def test_predict_without_model(client):
    test_data = {
        'age': 35,
        'workclass': 'Private',
        'fnlwgt': 100000,
        'education': 'Bachelors',
        'education-num': 13,
        'marital-status': 'Never-married',
        'occupation': 'Exec-managerial',
        'relationship': 'Not-in-family',
        'race': 'White',
        'sex': 'Male',
        'capital-gain': 0,
        'capital-loss': 0,
        'hours-per-week': 40,
        'native-country': 'United-States'
    }
    
    response = client.post('/predict', json=test_data)
    assert response.status_code == 500
    assert 'error' in response.json

def test_predictor_class():
    predictor = SalaryPredictor()
    assert predictor.model is None
    assert predictor.preprocessor is None