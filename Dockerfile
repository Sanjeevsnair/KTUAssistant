# Use a Python base image
FROM python:3.8-slim

# Set environment variables to prevent Python from writing .pyc files to disc
ENV PYTHONUNBUFFERED=1

# Create and set the working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y \
    build-essential \
    libpq-dev \
    pkg-config \
    libcairo2-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container at /app
COPY requirements.txt /app/

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container at /app
COPY . /app/

RUN mkdir -p /.streamlit
COPY .streamlit/config.toml /.streamlit/config.toml

# Expose the port that the app runs on
EXPOSE 8501

# Run the application
CMD ["streamlit", "run", "chatbot.py"]
