FROM nginx:alpine

# Copy application files
COPY ./ /usr/share/nginx/html/

# Expose port 80
EXPOSE 80

# Run nginx commands for execution
CMD ["nginx", "-g", "daemon off;"]