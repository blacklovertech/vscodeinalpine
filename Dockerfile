# Use Alpine base image
FROM alpine:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CODE_VERSION="4.17.0"

# Install necessary packages
RUN apk update && apk add --no-cache \
    bash \
    curl \
    nodejs \
    npm \
    git \
    python3 \
    py3-pip \
    build-base \
    libstdc++ \
    libffi-dev \
    openssl-dev \
    ca-certificates

# Install code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server-${CODE_VERSION}-linux-arm64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1

# Expose the port
EXPOSE 8080

# Create workspace directory
RUN mkdir -p /workspace
WORKDIR /workspace

# Set the entrypoint to code-server
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/workspace"]
