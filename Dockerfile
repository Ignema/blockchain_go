FROM golang:1.17 as builder

WORKDIR /go/src/app
COPY *.go ./

RUN go mod init
RUN go mod tidy
RUN go build .

FROM debian:buster-slim
RUN set -x && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates && \
    rm -rf /var/lib/apt/lists/*

ENV NODE_ID 3000

COPY --from=builder /go/src/app/app /out/app
WORKDIR /out

CMD ["bash"]