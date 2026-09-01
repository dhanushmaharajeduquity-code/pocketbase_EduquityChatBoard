FROM alpine:latest

ARG PB_VERSION=0.29.4

RUN apk add --no-cache \
    ca-certificates \
    unzip \
    wget

RUN wget -O /tmp/pocketbase.zip \
    https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip \
    && unzip /tmp/pocketbase.zip -d /pocketbase \
    && rm /tmp/pocketbase.zip

WORKDIR /pocketbase

COPY pb_migrations /pocketbase/pb_migrations

EXPOSE 8080

CMD ["/pocketbase/pocketbase", "serve", "--http=0.0.0.0:8080"]
