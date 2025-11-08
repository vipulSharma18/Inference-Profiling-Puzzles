# Use NVIDIA CUDA base image with Ubuntu
FROM nvidia/cuda:12.8.0-cudnn-devel-ubuntu22.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    UV_CACHE_DIR=/root/.cache/uv \
    HF_HOME=/root/.cache/huggingface \
    HF_HUB_ENABLE_HF_TRANSFER=1

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    ca-certificates \
    wget \
    curl \
    openssh-client \
    openssh-server \
    less \
    vim \
    && rm -rf /var/lib/apt/lists/*

# Install uv
# Download the latest installer
ADD https://astral.sh/uv/install.sh /uv-installer.sh

# Run the installer then remove it
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure the installed binary is on the `PATH`
ENV PATH="/root/.local/bin/:$PATH"

# Accept build arguments for git repo and commit
ARG GIT_REPO
ARG GIT_COMMIT

# Set working directory
WORKDIR /workspace

# Clone the repository with sparse-checkout
RUN git clone --no-checkout ${GIT_REPO} /workspace && \
    cd /workspace && \
    git sparse-checkout init --cone && \
    git sparse-checkout set gemlite_autotune common_utils && \
    git checkout ${GIT_COMMIT}

# Install dependencies
WORKDIR /workspace/gemlite_autotune
RUN uv python install 3.12 && \
    uv venv --python 3.12 && \
    uv sync --frozen
ENTRYPOINT ["/workspace/gemlite_autotune/entrypoint.sh"]

# Set the default command
CMD ["/bin/bash", "-c", "echo '[dockerfile] Container Started' && sleep infinity"]