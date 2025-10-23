FROM python:3.11

WORKDIR /app

# Đã thêm Fortran compiler để build SciPy
RUN apt-get update && apt-get install -y \
    gfortran \
    build-essential \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
# Thêm cờ --only-binary để ưu tiên wheels và tránh lỗi compiler
RUN pip install --no-cache-dir --only-binary :all: -r requirements.txt

COPY . .

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]
