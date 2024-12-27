# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV CODE_VERSION="4.17.0"

# Update and install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    nodejs \
    npm \
    python3 \
    python3-pip \
    build-essential \
    libstdc++6 \
    libffi-dev \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://github.com/coder/code-server/releases/download/v${CODE_VERSION}/code-server-${CODE_VERSION}-linux-amd64.tar.gz \
    | tar -xz -C /usr/local/bin --strip-components=1

# Expose the port
EXPOSE 8080

# Create workspace directory
RUN mkdir -p /workspace
WORKDIR /workspace

# Set the entrypoint to code-server
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "none", "/workspace"]
