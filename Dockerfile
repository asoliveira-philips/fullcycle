FROM golang:1.26 AS builder

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o app .

FROM scratch

COPY --from=builder /app/app /app

ENTRYPOINT ["/app"]