FROM ubuntu:18.04
LABEL maintainer="Sean Cheung <theoxuanx@gmail.com>"

ARG RUNNER_URL="https://github.com/actions/runner/releases/download/v2.165.2/actions-runner-linux-x64-2.165.2.tar.gz"
ARG DOCKER_URL="https://download.docker.com/linux/static/stable/x86_64/docker-18.06.3-ce.tgz"
ARG CN_MIRROR=false
RUN if [ "$CN_MIRROR" = true ]; then sed -i 's#http://\(archive\|security\).ubuntu.com/#http://mirrors.aliyun.com/#' /etc/apt/sources.list; fi

RUN set -ex && \
    echo "Install Dependencies..." && \
    apt-get update && \
    apt-get install -y --no-install-recommends curl tar ca-certificates sudo && \
    echo "Download github-runner archive..." && \
    mkdir -p /runner && \
    curl -L "$RUNNER_URL" | tar -xz -C /runner && \
    echo "Download docker archive..." && \
    curl -L "$DOCKER_URL" | tar -xz --strip=1 -C /usr/local/bin/ docker/docker && \
    apt-get remove -y curl && \
    echo "Download github-runner dependencies..." && \
    /runner/bin/installdependencies.sh && \
    echo "Configure..." && \
    useradd github && \
    echo "github ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    usermod -aG sudo github && \
    chown -R github:github /runner && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /runner
COPY entrypoint.sh /
USER github

ENTRYPOINT ["/entrypoint.sh"]