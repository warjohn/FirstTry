FROM python:3.10-slim

WORKDIR /app


# Копируем весь код ML
COPY mlops/ .

# Устанавливаем зависимости зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Запуск приложения (заглушка)
CMD ["python", "train_model.py"]