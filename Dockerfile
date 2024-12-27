# Use Ubuntu as the base image
FROM ubuntu:latest

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    python3 \
    python3-pip \
    build-essential \
    nodejs \
    npm \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install code-server using the official script
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Expose the port for code-server
EXPOSE 8080

# Install any other dependencies, if needed, after code-server installation

# Use CMD to start code-server without specifying /workspace and enable authentication
CMD ["code-server", "--bind-addr", "0.0.0.0:8080", "--auth", "password", "--password", "Maha0508"]
