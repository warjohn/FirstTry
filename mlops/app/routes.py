from flask import request, jsonify
import pandas as pd
import numpy as np

def init_routes(app, predictor):
    @app.route('/health', methods=['GET'])
    def health():
        app.logger.info("Health check requested")
        return jsonify({"status": "healthy", "model_loaded": predictor.model is not None})
    
    @app.route('/predict', methods=['POST'])
    def predict():
        try:
            data = request.get_json()
            app.logger.info(f"Received prediction request: {data}")
            
            if predictor.model is None:
                return jsonify({"error": "Model not loaded"}), 500
            
            df = pd.DataFrame([data])
            
            prediction = predictor.predict(df)
            result = ">50K" if prediction[0] == 1 else "<=50K"
            
            app.logger.info(f"Prediction result: {result}")
            return jsonify({"prediction": result})
            
        except Exception as e:
            app.logger.error(f"Prediction error: {str(e)}")
            return jsonify({"error": str(e)}), 400

    @app.route('/batch_predict', methods=['POST'])
    def batch_predict():
        try:
            data = request.get_json()
            app.logger.info(f"Received batch prediction request with {len(data)} records")
            
            if predictor.model is None:
                return jsonify({"error": "Model not loaded"}), 500
            
            df = pd.DataFrame(data)
            
            predictions = predictor.predict(df)
            results = [">50K" if p == 1 else "<=50K" for p in predictions]
            
            app.logger.info(f"Batch prediction completed: {len(results)} results")
            return jsonify({"predictions": results})
            
        except Exception as e:
            app.logger.error(f"Batch prediction error: {str(e)}")
            return jsonify({"error": str(e)}), 400