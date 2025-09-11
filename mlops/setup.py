from setuptools import setup, find_packages

setup(
    name="mlops_app",
    version="0.1.0",
    packages=find_packages(),
    install_requires=[
        "flask==2.3.3",
        "scikit-learn==1.3.0",
        "pandas==2.0.3",
        "numpy==1.24.3",
        "gunicorn==21.2.0",
        "python-dotenv==1.0.0",
        "loguru==0.7.2",
    ],
)