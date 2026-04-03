FROM golang:1.24.1-alpine AS builder
WORKDIR /source
COPY . .
RUN go build -o /distrust .


# Use distroless as minimal base image to package the distrust binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM gcr.io/distroless/static:nonroot
WORKDIR /
COPY --from=builder /distrust /
USER nonroot:nonroot

EXPOSE 3000

ENTRYPOINT ["/distrust"]
