FROM nginx:alpine

# Copy application files
COPY src/ /usr/share/nginx/html/
COPY src/css/ /usr/share/nginx/html/css/
COPY src/js/ /usr/share/nginx/html/js/
COPY src/img/ /usr/share/nginx/html/img/

# Expose port 80
EXPOSE 80

# Run nginx commands for execution
CMD ["nginx", "-g", "daemon off;"]