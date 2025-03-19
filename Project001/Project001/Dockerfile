FROM nginx:alpine
COPY ./nginx.conf /etc/nginx/nginx.conf

# Copy application files
COPY src/ /usr/share/nginx/html/

WORKDIR /app
COPY . .

# Expose port 80
EXPOSE 80

# Run nginx commands for execution
CMD ["nginx", "-g", "daemon off;"]