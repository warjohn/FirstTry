FROM python:3.10-slim

WORKDIR /app

COPY mlops/ .

COPY configs/docker/entrypoint.sh /app/entrypoint.sh

RUN chmod +x /app/entrypoint.sh

RUN pip install --no-cache-dir -r requirements.txt

CMD ["/app/entrypoint.sh"]