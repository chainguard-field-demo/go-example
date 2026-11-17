FROM cgr.dev/fakecorp.meme/go:latest AS build

WORKDIR /src
COPY go.mod ./
COPY main.go ./
COPY static ./static
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /out/hello .

FROM cgr.dev/fakecorp.meme/chainguard-base:latest

COPY --from=build /out/hello /usr/bin/hello
USER 65532:65532
EXPOSE 8080
ENTRYPOINT ["/usr/bin/hello"]
