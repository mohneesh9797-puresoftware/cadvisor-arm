FROM golang as builder
ENV CADVISOR_VERSION "v0.34.0"
ENV GOARCH "arm"

RUN git clone --branch ${CADVISOR_VERSION} https://github.com/google/cadvisor.git /go/src/github.com/google/cadvisor

WORKDIR /go/src/github.com/google/cadvisor

RUN make build
# final image
FROM alpine
COPY --from=builder /go/src/github.com/google/cadvisor/cadvisor /usr/bin/cadvisor

EXPOSE 8080
ENTRYPOINT ["/usr/bin/cadvisor"]
