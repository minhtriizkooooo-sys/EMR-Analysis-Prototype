FROM python:3.11

WORKDIR /app

# Install system dependencies for scipy (gfortran is key) and other libraries
# Thêm 'gfortran' và 'build-essential' để giải quyết lỗi compiler của SciPy.
RUN apt-get update && apt-get install -y \
    gfortran \
    build-essential \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]
