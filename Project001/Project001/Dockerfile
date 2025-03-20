FROM nginx:alpine

# Copy application files
COPY src/ /usr/share/nginx/html/

WORKDIR /app
COPY . .

# Expose port 80
EXPOSE 80

# Run nginx commands for execution
CMD ["nginx", "-g", "daemon off;"]