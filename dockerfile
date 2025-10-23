FROM python:3.11

WORKDIR /app

# Install system dependencies.
# The key fix is adding 'gfortran' and 'build-essential'
RUN apt-get update && apt-get install -y \
    gfortran \
    build-essential \
    libblas-dev \
    liblapack-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
# Pip will now find gfortran and successfully build SciPy
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["gunicorn", "app:app", "--bind", "0.0.0.0:$PORT"]
