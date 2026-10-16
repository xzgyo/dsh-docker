#!/bin/bash
set -euo pipefail

export DSH_HOME="${DSH_HOME:-/dsh-data}"
export DSH_WORKSPACE="${DSH_WORKSPACE:-/workspace}"
export HOST="${HOST:-127.0.0.1}"
export PORT="${PORT:-3080}"

if [ ! -d "$DSH_HOME" ]; then
    echo "[dsh-entrypoint] INFO: 数据目录 $DSH_HOME 不存在，正在创建..."
    mkdir -p "$DSH_HOME"
fi

if [ ! -w "$DSH_HOME" ]; then
    echo "[dsh-entrypoint] ERR : 数据目录 $DSH_HOME 不可写，请检查挂载权限。" >&2
    exit 1
fi

if [ ! -d "$DSH_WORKSPACE" ]; then
    mkdir -p "$DSH_WORKSPACE"
fi

echo "[dsh-entrypoint] INFO: DSH_HOME      = $DSH_HOME"
echo "[dsh-entrypoint] INFO: DSH_WORKSPACE = $DSH_WORKSPACE"
echo "[dsh-entrypoint] INFO: 监听地址       = $HOST:$PORT"
echo "[dsh-entrypoint] INFO: 启动 DeepSeek Harness Web UI ..."

# --no-open  : 容器内不尝试打开浏览器
exec dsh web --no-open --host "$HOST" --port "$PORT" "$@"