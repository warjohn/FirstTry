from app import create_app
from app.models import predictor
import os


model_path = os.getenv('MODEL_PATH', 'data/model.pkl')
preprocessor_path = os.getenv('PREPROCESSOR_PATH', 'data/preprocessor.pkl')
PORT = os.getenv('PORT', 8000)

app = create_app(model_path, preprocessor_path)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=PORT, debug=True)