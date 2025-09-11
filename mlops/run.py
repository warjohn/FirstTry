from app import create_app
from app.models import predictor
import os

app = create_app()

model_path = os.getenv('MODEL_PATH', 'data/model.pkl')
preprocessor_path = os.getenv('PREPROCESSOR_PATH', 'data/preprocessor.pkl')
PORT = os.getenv('PORT', 5000)

try:
    predictor.load_model(model_path, preprocessor_path)
    app.logger.info("Model and preprocessor loaded successfully")
except Exception as e:
    app.logger.error(f"Error loading model: {str(e)}")

from app.routes import init_routes
init_routes(app, predictor)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT, debug=True)