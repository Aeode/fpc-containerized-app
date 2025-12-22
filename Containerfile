FROM debian:bookworm-slim AS builder

RUN apt-get update && apt-get install -y \
    fpc \
    make \
    binutils \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build
COPY src/ ./src/
COPY Makefile ./

RUN make release

FROM debian:bookworm-slim

# Install libc and pthreads (standard in slim)
RUN apt-get update && apt-get install -y libc6 && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY --from=builder /build/build/release/main .

EXPOSE 8080

ENTRYPOINT ["./main"]