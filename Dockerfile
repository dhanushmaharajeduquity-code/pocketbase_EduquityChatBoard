FROM alpine:latest

# Set the exact version you requested
ARG PB_VERSION=0.40.1 

# Install dependencies
RUN apk add --no-cache unzip ca-certificates curl

# Download the LINUX version (NOT Windows). Render requires Linux binaries.
RUN curl -L https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip -o /tmp/pb.zip

# Unzip and make it executable
RUN unzip /tmp/pb.zip -d /pb/
RUN chmod +x /pb/pocketbase

# Expose the port
EXPOSE 8080

# Start PocketBase
CMD ["/bin/sh", "-c", "/pb/pocketbase serve --http=0.0.0.0:${PORT:-8080}"]
