FROM golang:1.21-alpine AS base
WORKDIR /app
COPY go.mod .
RUN go mod download
FROM base AS final
COPY . .
RUN go build -o notification-service .
EXPOSE 8080
CMD ["./notification-service"]
