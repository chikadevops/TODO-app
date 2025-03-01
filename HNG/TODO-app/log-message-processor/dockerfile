# Use Python 3.7 as the base image
FROM python:3.7-slim

# Set the working directory
WORKDIR /app
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    libc-dev \
    libssl-dev \
    libffi-dev \
    build-essential \
    python3-pip \
    && rm -rf /var/lib/apt/lists/
# Copy requirements and install dependencies
COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
RUN pip install --upgrade pip && \
    pip install thriftpy2==0.4.14 && \
    pip install wheel && \
    pip install redis py_zipkin requests six && \
    pip install --no-cache-dir -r requirements.txt \
    pip uninstall -y thriftpy || true

ENV REDIS_HOST=redis \
    REDIS_PORT=6379 \
    REDIS_CHANNEL=log_channel
# Copy the rest of the application code
COPY . .
EXPOSE 8084
# Run the application
CMD ["python", "main.py"]