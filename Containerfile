FROM fedora:latest AS builder

RUN dnf install -y fpc make && \
    dnf clean all

WORKDIR /build

COPY src/ ./src/
COPY Makefile ./

RUN make release

FROM scratch

COPY --from=builder /build/build/release/main /main

ENTRYPOINT ["/main"]