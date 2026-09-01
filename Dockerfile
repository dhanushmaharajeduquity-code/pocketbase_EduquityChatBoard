FROM alpine:latest

ARG PB_VERSION=0.40.1

RUN apk add --no-cache \
    unzip \
    ca-certificates

ADD https://github.com/dhanushmaharajeduquity-code/pocketbase_EduquityChatBoard/blob/main/pocketbase_0.40.1_windows_amd64.zip
RUN unzip /tmp/pb.zip -d /pb/ \
    && rm /tmp/pb.zip

COPY ./pb_migrations /pb/pb_migrations

EXPOSE 8080

CMD ["/pb/pocketbase", "serve", "--http=0.0.0.0:8080"]
