# DeepSeek Harness Docker

使用 Docker Compose 运行 DeepSeek Harness（DSH）Web UI。镜像基于 Node.js 24，并通过 npm 全局安装 `@deepseek-ai/dsh`。

> [!NOTE]
> 本项目代码由AI辅助完成。

## 环境要求

- 已安装 [Docker Engine 和 Docker Compose v2](https://www.docker.com/get-started/)
- 主机的 `3080` 端口未被占用

## 启动

在项目目录执行：

```bash
docker compose up -d --build
```

启动后，在浏览器访问 [http://localhost:3080](http://localhost:3080)。查看启动日志：

```bash
docker compose logs -f dsh
```

停止并移除容器：

```bash
docker compose down
```

## 数据与工作区

Compose 会在项目目录下创建并挂载以下目录：

| 宿主机目录 | 容器目录 | 用途 |
| --- | --- | --- |
| `./dsh_data` | `/dsh-data` | DSH 数据目录（`DSH_HOME`） |
| `./dsh_workspace` | `/workspace` | DSH 工作区（`DSH_WORKSPACE`） |

这两个目录不会随容器停止或移除而删除。容器以 `node` 用户运行；如果启动日志提示数据目录不可写，请确认 Docker 对 `dsh_data` 目录有写入权限。

## 配置

Compose 默认设置如下：

| 变量 | 默认值 | 说明 |
| --- | --- | --- |
| `DSH_HOME` | `/dsh-data` | 容器内的数据目录 |
| `DSH_WORKSPACE` | `/workspace` | 容器内的工作区目录 |
| `HOST` | `0.0.0.0` | Web UI 在容器内的监听地址 |
| `PORT` | `3080` | Web UI 在容器内的监听端口 |

宿主机端口映射在 `docker-compose.yaml` 的 `ports` 中配置。需要更换端口时，同时调整映射两侧的端口，并按需更新 `PORT`。

Dockerfile 使用构建参数 `DSH_VERSION` 选择 DSH npm 包版本，默认值为 `latest`。

## 提醒

服务绑定到容器的所有网卡，并发布到宿主机端口 `3080`。请勿将该端口直接暴露到不可信网络；如需远程访问，请通过可信网络或受控的反向代理进行限制。

## Stars

<a href="https://www.star-history.com/?repos=xzgyo%2Fdsh-docker&amp;type=date">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/chart?repos=xzgyo/dsh-docker&amp;type=date&amp;theme=dark&amp;legend=top-left" />
    <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/chart?repos=xzgyo/dsh-docker&amp;type=date" />
    <img alt="GitHub Star 历史" src="https://api.star-history.com/chart?repos=xzgyo/dsh-docker&amp;type=date" />
  </picture>
</a>