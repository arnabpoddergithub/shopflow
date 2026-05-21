FROM python:3.11-slim AS base

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

FROM base AS final

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
