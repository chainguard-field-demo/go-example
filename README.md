# go-example

A minimal Go web server that serves a static "Hello, World!" page. It uses only the Go standard library and is built into a container image based on Chainguard images.

## Project layout

```
.
├── Dockerfile          # Multi-stage build: compile in go, run in chainguard-base
├── go.mod              # Go module definition (no third-party dependencies)
├── main.go             # HTTP server; serves files from static/
└── static/
    └── index.html      # The Hello World page
```

The `static/` directory is compiled into the binary with `go:embed`, so the binary is all you need to run the app.

## Configuration

| Variable | Default | Description             |
|----------|---------|-------------------------|
| `PORT`   | `8080`  | Port the server listens on |

## Run with Docker

```sh
docker build -t go-hello-world .
docker run --rm -p 8080:8080 go-hello-world
```

Then open http://localhost:8080.

The image is built in two stages:

1. **Build:** `cgr.dev/fakecorp.meme/go:latest` compiles a static binary (`CGO_ENABLED=0`).
2. **Run:** `cgr.dev/fakecorp.meme/chainguard-base:latest` contains only the binary, which runs as non-root user `65532`.

## Run locally

If you have Go installed:

```sh
go run .
```
