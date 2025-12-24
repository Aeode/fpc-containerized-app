FROM fedora:43 AS build
WORKDIR /project

COPY ./Makefile ./
COPY ./src/ ./src/

RUN dnf install -y fpc make
RUN make release

FROM scratch
WORKDIR /app

COPY --from=build /project/build/bin/ ./

ENTRYPOINT [ "/app/main" ]