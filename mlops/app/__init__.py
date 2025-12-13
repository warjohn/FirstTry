from flask import Flask
from .logger_config import configure_logger
from .models import SalaryPredictor
from .routes import init_routes

def create_app(modelPath, preprocessPath):
    app = Flask(__name__)
    predictor = SalaryPredictor()
    
    try:
        predictor.load_model(modelPath, preprocessPath)
        app.logger.info("Model and preprocessor loaded successfully")
    except Exception as e:
        app.logger.error(f"Error loading model: {str(e)}")

    init_routes(app, predictor)
    configure_logger(app)
    return app