FROM python:3.10-slim

WORKDIR /app

# Копируем зависимости
COPY mlops/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем весь код ML
COPY mlops/ .

# Запуск приложения (заглушка)
CMD ["python", "train_model.py"]