# Sử dụng phiên bản Python chính xác như bạn đã khai báo trong runtime.txt
FROM python:3.11.8-slim

# Cài đặt system dependencies, bao gồm gfortran (cho SciPy) và các thư viện khác (cho TensorFlow)
RUN apt-get update && apt-get install -y \
    gfortran \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements.txt và cài đặt Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy phần còn lại của code
COPY . .

# Lệnh khởi động (sử dụng gunicorn)
# Render sẽ tự động gán cổng ($PORT) cho container.
CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:8080"]
# Lưu ý: Nếu gunicorn không tự nhận PORT, thử sử dụng cổng cố định như 8080 hoặc 10000.
