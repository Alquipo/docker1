FROM golang:alpine AS builder

WORKDIR /go

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -gcflags="all=-N -l" -o hello hello.go

FROM scratch
COPY --from=builder /go/hello /
ENTRYPOINT ["/hello"]