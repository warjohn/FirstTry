FROM python:3.10-slim

WORKDIR /app

# Копируем зависимости
COPY mlops/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
RUN pwd && ls -la

RUN echo "=== Текущая директория ===" && \
    pwd && \
    echo "=== Содержимое контекста ===" && \
    ls -laR / || true
    
# Копируем весь код ML
COPY mlops/ .

# Запуск приложения (заглушка)
CMD ["python", "train_model.py"]