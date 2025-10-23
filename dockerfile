# Dockerfile
# This explicitly uses the 3.11.8 version you need
FROM python:3.11.8-slim

# This installs gfortran and system libs (Resolves Read-only error)
RUN apt-get update && apt-get install -y \
    gfortran \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Use a standard port (8080) for reliability with Gunicorn/Render Docker
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080"]
