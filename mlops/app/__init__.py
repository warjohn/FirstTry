from flask import Flask
from .logger_config import configure_logger
from .models import SalaryPredictor
from .routes import init_routes

def create_app():
    app = Flask(__name__)
    predictor = SalaryPredictor()
    init_routes(app, predictor)
    configure_logger(app)
    return app