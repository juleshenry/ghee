# 🧈 ghee

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

> *像印度澄清黄油一样 — 纯净、浓郁，让一切变得更好。*

**ghee** 是一个包含 **538+ 个 shell 快捷键** 的工具集，专为开发者、运维工程师和高级用户设计。它无缝集成到你现有的 shell 中，让你的 CLI 变得流畅快速 — 就像真正的酥油一样。

涵盖：Git、Docker、Kubernetes、AWS、GCP、Terraform、Heroku、Vercel、Fly.io、Railway、GitHub CLI、npm/yarn/pnpm、Python/pip、Rust、Go、Redis、PostgreSQL、MongoDB、Nginx、systemd、tmux、网络、网络安全/侦察、AI/LLM 工具、媒体工具（ffmpeg/yt-dlp）、JSON/YAML/CSV、macOS 高级工具等。

---

## 📑 目录

- [✨ 功能特性](#-功能特性)
- [✅ 前置要求](#-前置要求)
- [🚀 安装](#-安装)
- [🎮 使用 G 命令](#-使用-g-命令)
- [📦 项目结构](#-项目结构)
- [📖 命令参考](#-命令参考)
- [🛠️ 添加自定义快捷键](#️-添加自定义快捷键)
- [🤝 贡献](#-贡献)
- [🎨 为什么叫 "ghee"？](#-为什么叫-ghee)
- [📄 许可证](#-许可证)

---

## ✨ 功能特性

- 🔍 **`G`** — 交互式 Python TUI，模糊搜索所有 538+ 命令，实时预览
- ⚡ **`G 'docker logs'`** — 智能匹配任何 shell 命令，复制匹配结果到剪贴板
- ➕ **`G -a <alias> <command>`** — 添加自定义快捷键，保存到 `~/.ghee-custom`
- ➖ **`G -rm <alias>`** — 删除自定义快捷键
- 📦 **模块化** — 29 个主题模块，自动加载到你的 shell
- 🐍 **Python 驱动** — 精美的 Rich TUI，模糊匹配和彩色格式化
- 🔌 **即插即用** — `./setup-ghee` 在 30 秒内完成所有配置

---

## ✅ 前置要求

- **操作系统：** macOS 或 Linux
- **Shell：** `bash` 或 `zsh`
- **Python：** `python3`（推荐 3.8 或更高版本）
- **Git：** 克隆仓库所需

---

## 🚀 安装

### 快速设置

```bash
git clone https://github.com/juleshenry/ghee.git
cd ghee
chmod +x setup-ghee
./setup-ghee
source ~/.zshrc   # 或 source ~/.bashrc
```

### 手动设置

将此代码块添加到你的 `~/.bashrc` 或 `~/.zshrc`：

```bash
export PATH="/path/to/ghee/bin:/path/to/ghee/tools:$PATH"
source "/path/to/ghee/ghee-functions.sh"
for _gg_mod in "/path/to/ghee/modules"/*.sh; do
    source "$_gg_mod"
done
```

### 安装程序做了什么

- 检测你的 shell（bash 或 zsh）并备份 RC 文件
- 创建 Python 虚拟环境（`ghee-venv`）并安装 `rich` 用于交互式 TUI
- 将 `bin/` 和 `tools/` 导出到你的 `$PATH`
- 从 `modules/*.sh` 加载所有 29 个模块到你的 shell

### 卸载

```bash
./setup-ghee --remove && source ~/.zshrc
```

---

## 🎮 使用 G 命令

```bash
G                            # 交互式模糊搜索 — 搜索所有 538+ 命令
G 'docker logs'              # 智能匹配，复制最佳匹配到剪贴板
G -a 'npm run dev' '启动开发服务器'  # 添加自定义快捷键（持久保存）
G -rm myalias                # 删除自定义快捷键
```

在交互模式下：**方向键** 导航 · **回车** 选择 · **Tab** 复制 · **Esc** 退出。

---

## 📦 项目结构

```
ghee/
├── setup-ghee              # 安装器 / 卸载器
├── ghee-functions.sh       # 核心初始化：颜色、G() 包装器、注册声明
├── ghee.py                 # Python TUI（Rich 模糊搜索 CLI）
├── modules/                # 29 个 bash 模块，shell 启动时自动加载
│   ├── git_workflow.sh       # 高级 git 函数（gwip、presto、gtag...）
│   ├── git_aliases.sh        # 90+ 标准 git 别名（gs、gco、glog...）
│   ├── docker.sh             # Docker & Compose
│   ├── kubernetes.sh         # kubectl 快捷方式
│   ├── aws_cli.sh            # AWS CLI
│   ├── gcp_gcloud.sh         # GCP gcloud
│   ├── terraform.sh          # Terraform
│   ├── cloud_deploy.sh       # Heroku、Vercel、Fly.io、Railway
│   ├── github_cli.sh         # gh CLI（PR、issue、release）
│   ├── npm_yarn_pnpm.sh      # JS 包管理器
│   ├── python_pip_venv.sh    # Python / pip / venv / pytest
│   ├── rust_go.sh            # Cargo + Go 工具
│   ├── redis.sh              # Redis CLI
│   ├── postgresql.sh         # psql 快捷方式
│   ├── mongodb.sh            # MongoDB CLI
│   ├── nginx.sh              # Nginx 管理
│   ├── systemd_services.sh   # systemctl / journalctl
│   ├── networking.sh         # curl、dig、DNS、速度测试
│   ├── cybersecurity_network_recon.sh  # nmap、tcpdump、ssl、ncat
│   ├── ai_llm.sh             # Ollama、OpenAI API
│   ├── media_tools.sh        # ffmpeg、yt-dlp、imagemagick
│   ├── data_tools.sh         # jq、YAML、CSV 处理
│   ├── macos_power_tools.sh  # macOS 专用工具
│   ├── super_utilities.sh    # cheat、weather、UUID、timer
│   ├── tmux.sh               # tmux 会话管理
│   └── shell_file_utilities.sh  # history、extract、ports、swap...
├── bin/                    # 独立 bash 脚本（添加到 PATH）
└── tools/                  # Python 脚本（添加到 PATH）
```

---

## 📖 命令参考

> **注意：** 别名和命令保持英文以保持一致性。描述已翻译为中文。

### Ai Llm

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `ollama` | `ollama run MODEL` | 通过 Ollama 运行本地 LLM 模型 |
| `ollmls` | `ollama list` | 列出本地下载的 Ollama 模型 |
| `ollpull` | `ollama pull MODEL` | 下载 Ollama 模型 |
| `ollamaserv` | `ollama serve` | 在端口 11434 启动 Ollama API 服务器 |
| `llmchat` | `curl localhost:11434/api/generate with JSON` | 通过 curl 与本地 Ollama 模型聊天 |
| `tokcount` | `python3 -c tiktoken count tokens` | 计算字符串中的 token 数（需要 tiktoken） |
| `openai` | `curl api.openai.com/v1/chat/completions` | 通过 curl 向 OpenAI API 发送提示 |

### Docker

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `dps` | `docker ps` | 列出运行中的容器 |
| `dpsa` | `docker ps -a` | 列出所有容器 |
| `di` | `docker images` | 列出镜像 |
| `drm` | `docker rm` | 删除容器 |
| `drmi` | `docker rmi` | 删除镜像 |
| `drmf` | `docker rm -f \$(docker ps -aq)` | 强制删除所有容器 |
| `drmia` | `docker rmi \$(docker images -q)` | 删除所有镜像 |
| `dex` | `docker exec -it CONTAINER bash` | 进入容器执行 bash |
| `dl` | `docker logs -f CONTAINER` | 跟踪容器日志 |
| `dstop` | `docker stop \$(docker ps -aq)` | 停止所有容器 |
| `dprune` | `docker system prune -af` | 清理所有（容器、镜像、网络） |
| `dc` | `docker compose` | Docker Compose 快捷方式 |
| `dcu` | `docker compose up -d` | Compose 启动（后台模式） |
| `dcd` | `docker compose down` | Compose 停止 |
| `dcb` | `docker compose build` | Compose 构建 |
| `dcl` | `docker compose logs -f` | 跟踪 compose 日志 |
| `dcr` | `docker compose restart` | 重启 compose 服务 |
| `dvls` | `docker volume ls` | 列出卷 |
| `dnls` | `docker network ls` | 列出网络 |
| `dbuild` | `docker build -t NAME .` | 从 Dockerfile 构建镜像 |

### Kubernetes

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `k` | `kubectl` | kubectl 快捷方式 |
| `kgp` | `kubectl get pods` | 列出 pod |
| `kgpa` | `kubectl get pods --all-namespaces` | 列出所有命名空间中的 pod |
| `kgs` | `kubectl get svc` | 列出服务 |
| `kgn` | `kubectl get nodes` | 列出节点 |
| `kgd` | `kubectl get deployments` | 列出部署 |
| `kgi` | `kubectl get ingress` | 列出 ingress |
| `kgns` | `kubectl get namespaces` | 列出命名空间 |
| `kga` | `kubectl get all` | 列出所有资源 |
| `kdp` | `kubectl describe pod POD` | 描述 pod |
| `kds` | `kubectl describe svc SVC` | 描述服务 |
| `kdd` | `kubectl describe deployment DEP` | 描述部署 |
| `kl` | `kubectl logs -f POD` | 跟踪 pod 日志 |
| `klp` | `kubectl logs -f POD -p` | 上一个 pod 日志 |
| `kex` | `kubectl exec -it POD -- bash` | 进入 pod 执行 bash |
| `kaf` | `kubectl apply -f FILE` | 应用清单文件 |
| `kdf` | `kubectl delete -f FILE` | 从清单文件删除 |
| `kctx` | `kubectl config get-contexts` | 显示 kube 上下文 |
| `kuse` | `kubectl config use-context CTX` | 切换 kube 上下文 |
| `kns` | `kubectl config set-context --current --namespace=NS` | 设置默认命名空间 |
| `kpf` | `kubectl port-forward POD LOCAL:REMOTE` | 端口转发到 pod |
| `kscale` | `kubectl scale deployment DEP --replicas=N` | 缩放部署 |
| `krollout` | `kubectl rollout status deployment DEP` | 检查发布状态 |
| `krestart` | `kubectl rollout restart deployment DEP` | 重启部署 |
| `ktop` | `kubectl top pods` | pod 资源使用 |
| `ktopn` | `kubectl top nodes` | 节点资源使用 |

### Git Aliases

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `gs` | `git status` | 显示工作树状态 |
| `gss` | `git status -s` | 简短格式状态 |
| `ga` | `git add .` | 暂存所有更改 |
| `gaf` | `git add FILE` | 暂存特定文件 |
| `gc` | `git commit -m MSG` | 提交并附消息 |
| `gca` | `git commit -a -m MSG` | 提交所有跟踪的文件 |
| `gcam` | `git commit --amend -m MSG` | 修改上次提交消息 |
| `gcan` | `git commit --amend --no-edit` | 修改上次提交，保留消息 |
| `gp` | `git push` | 推送到 origin |
| `gpf` | `git push --force` | 强制推送 |
| `gpfl` | `git push --force-with-lease` | 强制推送（更安全） |
| `gpu` | `git push -u origin BRANCH` | 推送并设置上游 |
| `gl` | `git pull` | 从 origin 拉取 |
| `glr` | `git pull --rebase` | 拉取并变基 |
| `glp` | `git pull --prune` | 拉取并修剪死引用 |
| `gb` | `git branch` | 列出本地分支 |
| `gba` | `git branch -a` | 列出所有分支（本地+远程） |
| `gbd` | `git branch -d BRANCH` | 删除分支 |
| `gbdf` | `git branch -D BRANCH` | 强制删除分支 |
| `gco` | `git checkout BRANCH` | 检出分支 |
| `gcob` | `git checkout -b BRANCH` | 创建并检出新分支 |
| `gcop` | `git checkout -` | 检出上一个分支 |
| `gcom` | `git checkout main \|\| git checkout master` | 检出 main/master |
| `gsw` | `git switch BRANCH` | 切换到分支（现代方式） |
| `gswc` | `git switch -c BRANCH` | 创建并切换到新分支 |
| `gm` | `git merge BRANCH` | 合并分支 |
| `gmnf` | `git merge --no-ff BRANCH` | 非快进合并 |
| `gma` | `git merge --abort` | 中止合并 |
| `gbm` | `git branch --merged` | 显示已合并分支 |
| `glog` | `git log --oneline --decorate --graph` | 漂亮的提交图 |
| `gloga` | `git log --oneline --decorate --graph --all` | 漂亮图表，所有分支 |
| `glogd` | `git log --pretty=format:'%h %ad %s' --date=short` | 带日期的日志 |
| `glogs` | `git log --stat` | 带文件统计的日志 |
| `glogp` | `git log -p` | 带补丁的日志 |
| `glast` | `git log -1 HEAD` | 显示上次提交 |
| `gblame` | `git blame FILE` | 显示谁更改了每一行 |
| `gshow` | `git show` | 显示上次提交详情 |
| `gauthor` | `git log --author NAME` | 按作者筛选日志 |
| `gsearch` | `git log --all --grep TERM` | 搜索提交消息 |
| `gbv` | `git branch -v` | 分支及上次提交 |
| `gbvv` | `git branch -vv` | 分支及跟踪信息 |
| `grl` | `git reflog` | 显示 reflog |
| `gd` | `git diff` | 显示未暂存的差异 |
| `gds` | `git diff --staged` | 显示已暂存的差异 |
| `gdst` | `git diff --stat` | 带统计的差异 |
| `gdw` | `git diff --word-diff` | 词级差异 |
| `gdc` | `git diff --color-words` | 彩色词级差异 |
| `gdfiles` | `git diff --name-only` | 列出更改的文件名 |
| `gdstat` | `git diff --name-status` | 更改的文件及状态 |
| `gdlc` | `git diff HEAD^ HEAD` | 上次提交的差异 |
| `gls` | `git ls-files` | 列出跟踪的文件 |
| `glsu` | `git ls-files --others` | 列出未跟踪的文件 |
| `gcontrib` | `git shortlog -sn` | 显示贡献者 |
| `gfh` | `git log --follow -p -- FILE` | 显示文件的完整历史 |
| `gst` | `git stash` | 暂存更改 |
| `gstm` | `git stash push -m MSG` | 暂存并附消息 |
| `gstu` | `git stash -u` | 暂存包括未跟踪的文件 |
| `gsta` | `git stash -a` | 暂存所有文件（包括忽略的） |
| `gstl` | `git stash list` | 列出暂存的更改 |
| `gsts` | `git stash show -p` | 显示暂存的更改内容 |
| `gstap` | `git stash apply` | 应用上次暂存的更改 |
| `gstpo` | `git stash pop` | 弹出上次暂存的更改 |
| `gstd` | `git stash drop` | 删除暂存的更改 |
| `gstc` | `git stash clear` | 清除所有暂存的更改 |
| `gr` | `git remote` | 显示远程仓库 |
| `grv` | `git remote -v` | 显示远程仓库及 URL |
| `gra` | `git remote add NAME URL` | 添加远程仓库 |
| `grr` | `git remote remove NAME` | 删除远程仓库 |
| `gf` | `git fetch` | 从 origin 获取 |
| `gfa` | `git fetch --all` | 获取所有远程仓库 |
| `gfp` | `git fetch --prune` | 获取并修剪 |
| `gcl` | `git clone URL` | 克隆仓库 |
| `gcld` | `git clone --depth 1 URL` | 浅克隆 |
| `grss` | `git reset --soft HEAD~1` | 软重置上次提交 |
| `grsm` | `git reset HEAD~1` | 混合重置上次提交 |
| `grsh` | `git reset --hard HEAD~1` | 硬重置上次提交 |
| `grso` | `git reset --hard origin/BRANCH` | 重置为远程分支 |
| `gus` | `git reset HEAD` | 取消暂存所有文件 |
| `gusf` | `git reset HEAD -- FILE` | 取消暂存特定文件 |
| `gcn` | `git clean -n` | 清理试运行 |
| `gcf` | `git clean -f` | 清理未跟踪的文件 |
| `gcfd` | `git clean -fd` | 清理未跟踪的文件和目录 |
| `gdis` | `git checkout -- FILE` | 丢弃文件中的更改 |
| `gcp` | `git cherry-pick HASH` | 挑选提交 |
| `gcpc` | `git cherry-pick --continue` | 继续挑选 |
| `gcpa` | `git cherry-pick --abort` | 中止挑选 |
| `grbi` | `git rebase -i HASH` | 交互式变基 |
| `grbc` | `git rebase --continue` | 继续变基 |
| `grba` | `git rebase --abort` | 中止变基 |
| `grbs` | `git rebase --skip` | 跳过变基步骤 |
| `gt` | `git tag` | 显示标签 |
| `gta` | `git tag -a TAG` | 创建带注释的标签 |
| `gpt` | `git push --tags` | 推送所有标签 |

### Github Cli

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `ghpr` | `gh pr create` | 创建 GitHub 拉取请求 |
| `ghprs` | `gh pr status` | 显示当前分支的 PR 状态 |
| `ghprl` | `gh pr list` | 列出开放的拉取请求 |
| `ghprd` | `gh pr diff` | 显示当前 PR 的差异 |
| `ghprm` | `gh pr merge` | 合并当前拉取请求 |
| `ghprco` | `gh pr checkout NUMBER` | 检出指定编号的拉取请求 |
| `ghil` | `gh issue list` | 列出开放的 GitHub 议题 |
| `ghic` | `gh issue create` | 创建新的 GitHub 议题 |
| `ghiv` | `gh issue view NUMBER` | 查看指定议题 |
| `ghrl` | `gh release list` | 列出 GitHub 发布 |
| `ghrc` | `gh release create` | 创建新的 GitHub 发布 |
| `ghrepo` | `gh repo view --web` | 在浏览器中打开当前仓库 |
| `ghrun` | `gh run list` | 列出最近的 GitHub Actions 工作流运行 |
| `ghrw` | `gh run watch` | 实时观看 GitHub Actions 运行 |
| `ghssh` | `gh auth refresh -h github.com -s admin:public_key` | 添加 SSH 密钥到 GitHub |
| `ghclone` | `gh repo clone OWNER/REPO` | 使用 gh 克隆仓库（自动 SSH） |
| `ghfork` | `gh repo fork --clone` | 分叉并克隆 GitHub 仓库 |

### Cybersecurity Network Recon

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `tn` | `telnet HOST` | Telnet 到主机 |
| `tnp` | `telnet HOST PORT` | Telnet 到主机:端口 |
| `nsa` | `netstat -an` | 显示所有连接 |
| `nstcp` | `netstat -tlnp` | 显示监听的 TCP 端口 |
| `nsudp` | `netstat -ulnp` | 显示监听的 UDP 端口 |
| `nsproc` | `netstat -tulnp` | 显示进程信息的网络状态 |
| `nsest` | `netstat -an \| grep ESTABLISHED` | 显示已建立的连接 |
| `nquick` | `nmap -F HOST` | Nmap 快速扫描（前 100 端口） |
| `nfull` | `nmap -p- HOST` | Nmap 全端口扫描 |
| `nsvc` | `nmap -sV HOST` | Nmap 服务版本检测 |
| `nos` | `sudo nmap -O HOST` | Nmap 操作系统检测 |
| `nagg` | `sudo nmap -A HOST` | Nmap 激进扫描（OS+版本+脚本） |
| `nsyn` | `sudo nmap -sS HOST` | Nmap  stealth SYN 扫描 |
| `nudp` | `sudo nmap -sU HOST` | Nmap UDP 扫描 |
| `nsweep` | `nmap -sn SUBNET` | Nmap ping 扫描（发现主机） |
| `nvuln` | `nmap --script vuln HOST` | Nmap 漏洞扫描 |
| `nports` | `nmap -p PORTS HOST` | Nmap 扫描指定端口 |
| `nscript` | `nmap -sC HOST` | Nmap 默认脚本扫描 |
| `nmapxml` | `nmap -oX output.xml HOST` | Nmap XML 输出 |
| `ncl` | `nc -lvp PORT` | Netcat 监听端口 |
| `ncs` | `nc HOST PORT` | Netcat 连接到主机:端口 |
| `ncscan` | `nc -zv HOST START-END` | Netcat 端口扫描 |
| `sslcheck` | `openssl s_client + x509 DOMAIN` | 检查 SSL 证书信息 |
| `sslchain` | `openssl s_client -showcerts DOMAIN` | 显示完整 SSL 证书链 |
| `sslciphers` | `nmap ssl-enum-ciphers -p 443 DOMAIN` | 枚举 SSL 密码 |
| `bannergrab` | `nc -w 3 HOST PORT` | 通过 netcat 获取横幅 |
| `myports` | `lsof -i -P -n \| grep LISTEN` | 显示本机开放端口 |
| `arptable` | `arp -a` | 显示 ARP 表 |
| `routes` | `netstat -rn / ip route show` | 显示路由表 |
| `fwrules` | `sudo iptables -L / pfctl -sr` | 显示防火墙规则 |
| `sniff` | `sudo tcpdump -i any -nn` | 数据包嗅探（tcpdump） |
| `tcapt` | `sudo tcpdump -w capture.pcap` | 捕获数据包到文件 |
| `tcport` | `sudo tcpdump port PORT` | tcpdump 按端口过滤 |
| `tchost` | `sudo tcpdump host HOST` | tcpdump 按主机过滤 |
| `secheaders` | `curl -sI URL \| grep security headers` | 检查 HTTP 安全头 |
| `hashpw` | `echo -n PW \| openssl dgst -sha512` | 哈希密码（SHA-512） |
| `genpw` | `tr -dc A-Za-z0-9... < /dev/urandom` | 生成随机密码 |
| `worldwrite` | `find / -perm -0002` | 查找全局可写文件 |
| `findsuid` | `find / -perm -4000` | 查找 SUID 二进制文件 |
| `whoson` | `who -a / w` | 显示所有登录用户 |
| `b64e` | `echo -n STR \| base64` | Base64 编码字符串 |
| `b64d` | `echo -n STR \| base64 --decode` | Base64 解码字符串 |
| `jwtdecode` | `jq -R 'split(\".\") \| .[0],.[1] \| @base64d \| fromjson'` | 解码 JWT 令牌 |
| `shodanip` | `curl -s https://internetdb.shodan.io/IP` | 快速 Shodan IP 查询 |
| `sshkey` | `ssh-keygen -t ed25519 -C EMAIL` | 生成现代安全 SSH 密钥 |

### Data Tools

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `jqpp` | `cat file.json \| jq .` | 格式化打印 JSON |
| `jqkeys` | `jq 'keys'` | 列出 JSON 顶级键 |
| `jqlen` | `jq 'length'` | 获取 JSON 数组或对象长度 |
| `jqm` | `jq 'map(.FIELD)'` | 映射/提取 JSON 数组中的字段 |
| `jqsel` | `jq '.[] \| select(.key==val)'` | 按字段值筛选 JSON 数组 |
| `yamlcheck` | `python3 -c yaml.safe_load` | 验证 YAML 文件语法 |
| `yaml2json` | `python3 yaml to json` | 将 YAML 文件转换为 JSON |
| `json2yaml` | `python3 json to yaml` | 将 JSON 文件转换为 YAML |
| `csvhead` | `head -1 FILE.csv \| tr ',' '\n'` | 显示 CSV 列头 |
| `csvcol` | `cut -d, -f N FILE.csv` | 从 CSV 提取第 N 列 |
| `sortjson` | `jq 'sort_by(.KEY)'` | 按键对 JSON 数组排序 |

### Cloud Deploy

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `vdeploy` | `vercel --prod` | 部署到 Vercel 生产环境 |
| `vdev` | `vercel dev` | 启动本地 Vercel 开发服务器 |
| `venv` | `vercel env pull .env.local` | 拉取 Vercel 环境变量到本地 |
| `hdeploy` | `git push heroku main` | 通过 git 部署到 Heroku |
| `hlogs` | `heroku logs --tail` | 跟踪 Heroku 应用日志 |
| `hbash` | `heroku run bash` | 在 Heroku dyno 上打开 bash |
| `hrestart` | `heroku restart` | 重启所有 Heroku dyno |
| `rdeploy` | `railway up` | 部署到 Railway |
| `rlogs` | `railway logs` | 显示 Railway 部署日志 |
| `fldeploy` | `fly deploy` | 部署到 Fly.io |
| `fllogs` | `fly logs` | 显示 Fly.io 日志 |
| `flssh` | `fly ssh console` | SSH 进入 Fly.io 机器 |
| `flscale` | `fly scale count N` | 缩放 Fly.io 实例数 |

### Gcp Gcloud

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `gcpid` | `gcloud config get-value project` | 显示当前 GCP 项目 |
| `gcpset` | `gcloud config set project PROJECT` | 设置 GCP 项目 |
| `gcpls` | `gcloud compute instances list` | 列出 GCE 实例 |
| `gcpssh` | `gcloud compute ssh INSTANCE` | SSH 到 GCE 实例 |
| `gcpgke` | `gcloud container clusters list` | 列出 GKE 集群 |
| `gcpgkecreds` | `gcloud container clusters get-credentials CLUSTER` | 获取 GKE kubeconfig |
| `gcpbq` | `bq ls` | 列出 BigQuery 数据集 |
| `gcpgsutil` | `gsutil ls` | 列出 GCS 存储桶 |
| `gcpcp` | `gsutil cp FILE gs://BUCKET/` | 复制文件到 GCS |
| `gcpsync` | `gsutil -m rsync -r DIR gs://BUCKET/` | 同步目录到 GCS |
| `gcprun` | `gcloud run services list` | 列出 Cloud Run 服务 |
| `gcpfn` | `gcloud functions list` | 列出 Cloud Functions |
| `gcpsql` | `gcloud sql instances list` | 列出 Cloud SQL 实例 |
| `gcplog` | `gcloud logging read FILTER --limit=50` | 读取 GCP 日志 |
| `gcpauth` | `gcloud auth login` | 验证 GCP 身份 |

### Git Workflow

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `gg` | `git add . && git commit -m MSG && git push` | 添加、提交、推送一步到位 |
| `gclo` | `git clone https://github.com/USER/REPO` | 克隆 GitHub 仓库 |
| `jclo` | `git clone https://github.com/juleshenry/REPO` | 克隆 juleshenry 仓库 |
| `presto` | `git checkout --orphan && force-push` | 破坏性：清除所有 git 历史 |
| `gwip` | `git add . && git commit -m 'wip: TIME'` | 快速工作进展提交（不推送） |
| `gunwip` | `git reset --soft HEAD~1` | 撤销上次 WIP 提交，保留暂存更改 |
| `gpristine` | `git reset --hard origin/BRANCH && git clean -fd` | 硬重置以完全匹配远程 |
| `gtag` | `git tag -a TAG -m MSG && git push origin TAG` | 创建并推送 git 标签 |
| `gpr` | `gh pr create --title TITLE --fill` | 通过 gh CLI 创建 GitHub PR |
| `gdiff-fancy` | `git diff --stat + git diff --shortstat` | 漂亮的差异摘要带统计 |
| `gacp` | `git add . && git commit -m MSG && git push` | 添加、提交、推送（同 gg） |
| `ginit` | `git init && git add . && git commit -m 'Initial commit'` | 初始化仓库并首次提交 |
| `ghcl` | `git clone https://github.com/USER/REPO` | 从 GitHub 克隆 |
| `gbc` | `git checkout -b BRANCH` | 创建并切换到新分支 |
| `gbdall` | `git branch -d B && git push origin --delete B` | 本地和远程删除分支 |
| `gundo` | `git reset --soft HEAD~1` | 撤销上次提交，保留暂存更改 |
| `gbs` | `git for-each-ref --sort=-committerdate` | 按最后修改时间排序分支 |
| `gquick` | `git add . && git commit -m 'Quick update: TIME' && git push` | 自动时间戳提交+推送 |
| `gchanged` | `git diff --name-only HEAD~N..HEAD` | 显示最近 N 次提交中更改的文件 |
| `gsearchtext` | `git log -S TEXT` | 在 git 历史中搜索文本 |
| `gnew` | `git fetch origin && git checkout -b B origin/main` | 从 origin/main 创建分支 |
| `gupdateall` | `git fetch --all && git pull` | 获取所有远程仓库并拉取 |
| `greposize` | `git count-objects -vH` | 显示仓库对象存储大小 |
| `gfilesize` | `git ls-tree -r -t -l --full-name HEAD \| sort` | 按大小列出仓库文件 |
| `glarge` | `git rev-list --objects --all \| ...` | 在历史中查找最大的 N 个 blob |
| `gsyncfork` | `git fetch upstream && merge upstream/main` | 同步分叉与 upstream/main |
| `gsquash` | `git reset --soft HEAD~N && git commit -m MSG` | 压缩最后 N 次提交 |
| `gstats` | `git shortlog -sn --all --no-merges` | 按作者统计提交数 |
| `garchive` | `git tag archive/B && delete branch` | 将分支存档为标签 |
| `galias` | `alias \| grep '^g'` | 列出所有 g* 别名 |
| `ginfo` | `repo name, branch, remote, last commit` | 显示仓库信息摘要 |
| `gbackup` | `tar -czf backup.tar.gz .` | 当前仓库的 tar.gz 备份 |

### Macos Power Tools

| 别名 | 执行 | 描述 |
|-------|------|-------------|
| `caffeinate` | `caffeinate -d` | 防止 Mac 进入睡眠 |
| `hidefiles` | `defaults write com.apple.finder ... [截断]
