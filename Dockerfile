# Use an official lightweight Python image
FROM python:3.9

# Set working directory
WORKDIR /app

# Copy application files
COPY . .

# Install dependencies
RUN pip install flask

# Define the command to run the app
CMD ["python", "app.py"]
