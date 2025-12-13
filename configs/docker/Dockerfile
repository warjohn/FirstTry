FROM python:3.10-slim

WORKDIR /app

# Копируем весь код ML
COPY mlops/ .

COPY configs/docker/entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

# Устанавливаем зависимости зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Запуск приложения (заглушка)
CMD ["/app/entrypoint.sh"]