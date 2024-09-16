# Dockerfile
FROM python:3.8-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV FLASK_ENV=production
ENV SECRET_KEY=your_secret_key
ENV SQLALCHEMY_DATABASE_URI=sqlite:///site.db

CMD ["python", "run.py"]
