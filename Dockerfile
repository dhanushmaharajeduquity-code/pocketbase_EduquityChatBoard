FROM alpine:latest

# ============================================================
# PocketBase Version & Architecture
# ============================================================
ARG PB_VERSION=0.28.5
ARG TARGETARCH

# ============================================================
# Image metadata
# ============================================================
LABEL maintainer="Eduquity" \
      org.opencontainers.image.title="PocketBase - Eduquity Backend" \
      org.opencontainers.image.version="${PB_VERSION}" \
      org.opencontainers.image.description="PocketBase backend for the Eduquity Agent Platform" \
      org.opencontainers.image.source="https://github.com/pocketbase/pocketbase"

# ============================================================
# Install dependencies + create non-root user
# ============================================================
RUN apk add --no-cache \
        unzip \
        ca-certificates \
        curl \
    && addgroup -S pocketbase \
    && adduser -S -G pocketbase -h /pb -s /bin/sh pocketbase

# ============================================================
# Download, install, and clean up PocketBase
# ============================================================
RUN mkdir -p /pb/pb_data \
    && curl -L "https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_${TARGETARCH:-amd64}.zip" \
        -o /tmp/pb.zip \
    && unzip -o /tmp/pb.zip -d /pb/ \
    && chmod +x /pb/pocketbase \
    && rm -f /tmp/pb.zip \
    && chown -R pocketbase:pocketbase /pb

# ============================================================
# Persist data directory (mount this volume in production)
# ============================================================
VOLUME /pb/pb_data

# ============================================================
# Runtime configuration
# ============================================================
USER pocketbase
WORKDIR /pb
EXPOSE 8080

# Health check against PocketBase's official /api/health endpoint
HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
    CMD /bin/sh -c 'curl -sf "http://localhost:${PORT:-8080}/api/health" > /dev/null || exit 1'

# Render injects PORT env var; we fall back to 8080 locally
CMD ["/bin/sh", "-c", "/pb/pocketbase serve --http=0.0.0.0:${PORT:-8080}"]
