FROM alpine:latest

# Set the PocketBase version you want to use
ARG PB_VERSION=0.40.1

# Install dependencies
RUN apk add --no-cache unzip ca-certificates curl

# Download and unzip PocketBase
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip -o /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /pb/
RUN chmod +x /pb/pocketbase

# Expose the default port
EXPOSE 8080

# Render injects a PORT environment variable. 
# We tell PocketBase to listen on that port, falling back to 8080 if not set.
CMD ["/bin/sh", "-c", "/pb/pocketbase serve --http=0.0.0.0:${PORT:-8080}"]
