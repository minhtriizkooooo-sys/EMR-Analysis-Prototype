# Sử dụng hình ảnh Python 3.11.8 slim
FROM python:3.11.8-slim

# Cài đặt các công cụ cần thiết và gfortran
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

# Lệnh khởi động sử dụng biến PORT của Render
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]
