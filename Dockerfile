FROM node:24-trixie

ARG DSH_VERSION=latest
ARG DEBIAN_FRONTEND=noninteractive

# 安装基础命令行工具
RUN apt upgrade -Uy && \
    apt install -y --no-install-recommends \
    ca-certificates python3 make g++ tini && \
    apt clean && \
    rm -rf /var/lib/apt/lists/*

# 安装pnpm
RUN corepack enable && corepack prepare pnpm@11.28.5 --activate

# 安装大烧货
RUN npm install -g @deepseek-ai/dsh@${DSH_VERSION} && \
    npm cache clean --force

# 创建数据目录
RUN mkdir -p /dsh-data /workspace && chown -R node:node /dsh-data /workspace
COPY --chown=root:root --chmod=755 dsh-entrypoint.sh /usr/local/bin/dsh-entrypoint.sh

# 环境变量
ENV NODE_ENV=production
ENV DSH_HOME=/dsh-data
ENV DSH_WORKSPACE=/workspace

USER node
EXPOSE 3080
ENTRYPOINT ["tini", "--", "/usr/local/bin/dsh-entrypoint.sh"]