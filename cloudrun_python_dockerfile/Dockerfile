FROM python:3.12-slim

WORKDIR /app
COPY . .

RUN pip install --no-cache-dir fastapi uvicorn

ENV PORT=80

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
