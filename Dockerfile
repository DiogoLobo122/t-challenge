FROM golang:1.23-alpine AS builder
ENV APP_ROOT=/app

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download

COPY . ./


RUN CGO_ENABLED=0 go build -a --trimpath --installsuffix cgo --ldflags="-s -w" -o whoami

FROM ubuntu:24.04
ENV APP_ROOT=/app


COPY docker-entrypoint.sh /entrypoint.sh

COPY --from=builder /app/whoami /app/whoami

RUN chmod g=u /etc/passwd \
 && chgrp -R 0 ${APP_ROOT} \
 && chmod -R g=u ${APP_ROOT} \
 && chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

# Run as a non-root user
USER 1001

CMD ["/app/whoami"]
