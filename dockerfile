FROM python:3.11.8-slim

# Install system dependencies, including gfortran for SciPy/NumPy
RUN apt-get update && apt-get install -y \
    gfortran \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Use the environment variable $PORT as required by Render for Docker services
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080"]
# Note: Render often maps the public port to 8080/10000 inside the container for Docker.
# If "0.0.0.0:8080" fails, try "0.0.0.0:10000" or just "0.0.0.0" depending on your gunicorn version and Render setup.
