# Dockerfile
# Use an official Python runtime as a parent image
FROM python:3.11-slim-bookworm

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -e . pytest

# Install VS Code extensions
# Retry apt-get update on transient errors
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        git
    curl -sSL https://github.com/coder/code-server/releases/download/v4.19.0/code-server-4.19.0-amd64.deb -o /tmp/code-server.deb && \
    apt install /tmp/code-server.deb && \
    code-server --version && \
    code-server --install-extension git || true && \
    code-server --install-extension github.github-vscode-theme || true && \
    code-server --install-extension ms-python.python || true && \
    code-server --install-extension google.gemini-code-assist || true && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/code-server.deb

# Run pytest by default
CMD ["pytest"]
