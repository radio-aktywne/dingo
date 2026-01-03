# Use generic base image with Nix installed
FROM nixos/nix:2.28.5 AS env

# Configure Nix
RUN echo "extra-experimental-features = nix-command flakes" >> /etc/nix/nix.conf

# Set working directory to something other than root
WORKDIR /env/

# Copy Nix files
COPY flake.lock *.nix ./

# Copy env script
COPY scripts/env.sh scripts/env.sh

# Build runtime shell closure and activation script
RUN \
    # Mount cached store paths
    --mount=type=cache,target=/nix-store-cache/ \
    # Mount Nix evaluation cache
    --mount=type=cache,target=/root/.cache/nix/ \
    ./scripts/env.sh runtime build/ /nix-store-cache/

# Use ubuntu for runtime
FROM ubuntu:24.04 AS runtime

# Use bash as default shell
SHELL ["/bin/bash", "-c"]

# Copy runtime shell closure and activation script
COPY --from=env /env/build/closure/ /nix/store/
COPY --from=env /env/build/activate /env/activate

# Set working directory to something other than root
WORKDIR /service/

# Create service user and data directory
RUN useradd --create-home service && \
    mkdir --parents data/

# Setup entrypoint for RUN commands
COPY scripts/shell.sh scripts/shell.sh
SHELL ["/service/scripts/shell.sh"]

# Copy OpenAPI schema
COPY openapi/ openapi/

# Copy source
COPY src/ src/

# Setup main entrypoint
COPY scripts/entrypoint.sh scripts/entrypoint.sh
ENTRYPOINT ["/service/scripts/entrypoint.sh", "liquidsoap", "src/main.liq"]
CMD []

# Setup ownership
RUN chown --recursive service: ./
