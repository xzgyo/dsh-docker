FROM node:24-trixie

ARG DSH_VERSION=latest

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt upgrade -Uy && \
    apt install -y --no-install-recommends \
        bash-completion sudo \
        iproute2 net-tools iputils-ping curl wget \
        git apt-transport-https ca-certificates \
        python3 python3-pip python3-venv \
        make g++ \
        tini && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

RUN npm install -g @deepseek-ai/dsh@${DSH_VERSION} && \
    npm cache clean --force

RUN mkdir -p /dsh-data /workspace && chown -R node:node /dsh-data /workspace
COPY --chown=root:root --chmod=755 dsh-entrypoint.sh /usr/local/bin/dsh-entrypoint.sh

ENV DSH_HOME=/dsh-data
ENV DSH_WORKSPACE=/workspace

USER node
EXPOSE 3080
ENTRYPOINT ["tini", "--", "/usr/local/bin/dsh-entrypoint.sh"]