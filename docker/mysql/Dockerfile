# Use the official MySQL 5.7 image as a base
FROM mysql:5.7

# Install a basic HTTP server (e.g., nginx)
RUN yum -y update && \
    yum -y install nginx && \
    yum clean all

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/nginx.conf

# Create a simple health check page
RUN echo "MySQL is running." > /usr/share/nginx/html/index.html

# Create custom-entrypoint.sh script
RUN cat <<EOF > /usr/local/bin/custom-entrypoint.sh
#!/bin/bash
set -e

# Start nginx
nginx &

# Execute the original MySQL entrypoint script
exec docker-entrypoint.sh mysqld
EOF
RUN chmod +x /usr/local/bin/custom-entrypoint.sh

# Copy custom-init.sh into the image
COPY custom-init.sh /docker-entrypoint-initdb.d/custom-init.sh

# Make custom-init.sh executable
RUN chmod +x /docker-entrypoint-initdb.d/custom-init.sh

# Set the new entrypoint
ENTRYPOINT ["/usr/local/bin/custom-entrypoint.sh"]

# Expose HTTP port
EXPOSE 8080

ENV MYSQL_ROOT_PASSWORD=test