# Production stage: Use OpenJDK and set up non-root user
FROM ubuntu as production-stage

# Set up a non-root user
RUN addgroup --gid 1001 nonrootgroup && \
    adduser --uid 1001 --ingroup nonrootgroup --shell /bin/bash --disabled-password nonroot

# Update and install required packages
RUN apt-get update && apt-get install -y \
    jq \
    ffmpeg \
    openjdk-8-jre \
    openjdk-11-jre \
    git \
    tmux \
    wget \
    curl \
    dialog \
    && rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PORT 80
EXPOSE 80

# Set working directory for the production container
WORKDIR /

# Switch to the non-root user
USER nonroot

# Entrypoint script
ENTRYPOINT ["bash", "main.sh"]
