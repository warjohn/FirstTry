from loguru import logger
import sys

def configure_logger(app):
    logger.add(
        "logs/app.log",
        format="{time:YYYY-MM-DD HH:mm:ss} | {level} | {message}",
        rotation="10 MB",
        backtrace=True,
        diagnose=True
    )
    app.logger = logger