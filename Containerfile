FROM debian:12 AS build
WORKDIR /project

COPY ./Makefile ./
COPY ./fpc-release.cfg ./

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        fp-compiler \
        make \
        libc6-dev \
    && rm -rf /var/lib/apt/lists/*

COPY ./src/ ./src/
RUN make release

FROM gcr.io/distroless/cc-debian12
WORKDIR /app

COPY --from=build /project/build/bin/main ./

ENTRYPOINT [ "/app/main" ]