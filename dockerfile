# Sử dụng Python 3.11.8 slim
FROM python:3.11.8-slim

# Cài đặt các gói hệ thống cần thiết
RUN apt-get update && apt-get install -y \
    gfortran \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép và cài đặt requirements.txt
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Sao chép mã nguồn
COPY . .

# Lệnh khởi động
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]
