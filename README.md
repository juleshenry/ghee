# 🧈 ghee

![ghee](ghee.png)

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

> *Like Indian clarified butter — pure, rich, and makes everything better.*

🌍 **Read in your language:**
🇪🇸 [Español](README.es.md) · 🇨🇳 [中文](README.zh.md) · 🇮🇳 [हिन्दी](README.hi.md) · 🇰🇷 [한국어](README.ko.md) · 🇸🇦 [العربية](README.ar.md)
<!-- 🌐 Translations cover descriptions; aliases & commands stay in English for consistency. -->

**ghee** is a collection of **616+ shell shortcuts** for developers, devops engineers, and power users. It layers smoothly on top of your existing shell, making your CLI crispy and fast — just like the real thing.

Covers: Git, Docker, Kubernetes, AWS, GCP, Terraform, Heroku, Vercel, Fly.io, Railway, GitHub CLI, npm/yarn/pnpm, Python/pip/uv/ruff/poetry, Rust, Go, Java/Maven/Gradle, Homebrew, SSH/SCP, Redis, PostgreSQL, MongoDB, Nginx, systemd, tmux, networking, cybersecurity/recon, AI/LLM tools, media (ffmpeg/yt-dlp), JSON/YAML/CSV, macOS power tools, and more.

---

## 📑 Table of Contents

- [✨ Features](#-features)
- [✅ Prerequisites](#-prerequisites)
- [🚀 Installation](#-installation)
- [🎮 Using the G Command](#-using-the-g-command)
- [📦 Project Structure](#-project-structure)
- [📖 Command Reference](#-command-reference)
- [🛠️ Adding Custom Shortcuts](#️-adding-custom-shortcuts)
- [🤝 Contributing](#-contributing)
- [🍴 Forking & Personalizing](#-forking--personalizing)
- [🎨 Why "ghee"?](#-why-ghee)
- [📄 License](#-license)

---

## ✨ Features

- 🔍 **`G`** — Interactive Python TUI to fuzzy-search all 616+ commands with live preview
- ⚡ **`G 'docker logs'`** — Best-guess any shell command, copies match to clipboard
- ➕ **`G -a olist 'ollama list'`** — Add your own custom shortcut, instantly available.
- 🛡️ **Clash Detection** — Automatically warns if an alias clashes with a system command or existing Ghee shortcut, asking for confirmation before overwriting.
- ➖ **`G -rm olist`** — Remove a custom shortcut
- 📋 **`G ls`** — List all your custom shortcuts
- 🔄 **`G update`** — Self-update ghee via git pull
- 📦 **Modular** — 32 topic-based modules, auto-sourced into your shell
- 🐍 **Python-powered** — Beautiful Rich TUI with fuzzy matching and color formatting
- 🔌 **Plug-and-play** — `./setup-ghee` sets everything up in under 30 seconds

---

## ✅ Prerequisites

- **OS:** macOS or Linux
- **Shell:** `bash` or `zsh`
- **Python:** `python3` (3.8 or newer recommended)
- **Git:** Required to clone the repository

---

## 🚀 Installation

### Quick Setup

```bash
git clone https://github.com/juleshenry/ghee.git
cd ghee
chmod +x setup-ghee
./setup-ghee
source ~/.zshrc   # or source ~/.bashrc
```

### Manual Setup

Add this block to your `~/.bashrc` or `~/.zshrc`:

```bash
export PATH="/path/to/ghee/bin:/path/to/ghee/tools:$PATH"
source "/path/to/ghee/ghee-functions.sh"
for _gg_mod in "/path/to/ghee/modules"/*.sh; do
    source "$_gg_mod"
done
```

### What the Installer Does

- Detects your shell (bash or zsh) and backs up your RC file
- Creates a Python virtualenv (`ghee-venv`) with `rich` for the interactive TUI
- Exports `bin/` and `tools/` to your `$PATH`
- Sources all 32 modules from `modules/*.sh` into your shell

### Uninstall

```bash
./setup-ghee --remove && source ~/.zshrc
```

---

## 🎮 Using the G Command

```bash
G                            # Interactive fuzzy finder — search all 616+ commands
G 'docker logs'              # Best-guess, copies best match to clipboard
G -a olist 'ollama list'     # Add a custom shortcut (works instantly)
G -rm olist                  # Remove a custom shortcut
G ls                         # List all custom shortcuts
G -q 'find large files'     # Ask Ollama AI (alias for -o)
G -q 'find large files' --model qwen2.5 # Ask specific Ollama model
G info docker                # Show all aliases for a specific module
G update                     # Self-update ghee via git pull
G --sync <gist_url>          # Sync custom shortcuts from a GitHub Gist
G --help                     # Show help and module list
```

In interactive mode: **arrows** to navigate · **Enter** to select · **Tab** to copy · **Esc** to quit.

---

## 📦 Project Structure

```
ghee/
├── setup-ghee              # Installer / uninstaller
├── ghee-functions.sh       # Core init: colors, G() wrapper, registry declaration
├── ghee.py                 # Python TUI (rich-powered fuzzy search CLI)
├── modules/                # 32 bash modules, auto-sourced on shell start
│   ├── git_workflow.sh       # Advanced git functions (gwip, presto, gtag...)
│   ├── git_aliases.sh        # 90+ standard git aliases (gs, gco, glog...)
│   ├── docker.sh             # Docker & Compose
│   ├── kubernetes.sh         # kubectl shortcuts
│   ├── aws_cli.sh            # AWS CLI
│   ├── gcp_gcloud.sh         # GCP gcloud
│   ├── terraform.sh          # Terraform
│   ├── cloud_deploy.sh       # Heroku, Vercel, Fly.io, Railway
│   ├── github_cli.sh         # gh CLI (PRs, issues, releases)
│   ├── npm_yarn_pnpm.sh      # JS package managers
│   ├── python_pip_venv.sh    # Python / pip / venv / uv / ruff / poetry
│   ├── rust_go.sh            # Cargo + Go tools
│   ├── java_jvm.sh           # Java / Maven / Gradle
│   ├── homebrew.sh           # Homebrew (macOS package manager)
│   ├── ssh_scp.sh            # SSH tunnels, keys, SCP
│   ├── redis.sh              # Redis CLI
│   ├── postgresql.sh         # psql shortcuts
│   ├── mongodb.sh            # MongoDB CLI
│   ├── nginx.sh              # Nginx management
│   ├── systemd_services.sh   # systemctl / journalctl
│   ├── networking.sh         # curl, dig, DNS, speed
│   ├── cybersecurity_network_recon.sh  # nmap, tcpdump, ssl, ncat
│   ├── ai_llm.sh             # Ollama, OpenAI API
│   ├── media_tools.sh        # ffmpeg, yt-dlp, imagemagick
│   ├── data_tools.sh         # jq, YAML, CSV processing
│   ├── macos_power_tools.sh  # macOS-specific utilities
│   ├── super_utilities.sh    # cheat, weather, UUID, timer
│   ├── tmux.sh               # tmux session management
│   └── shell_file_utilities.sh  # history, extract, ports, swap...
├── bin/                    # Standalone bash scripts (added to PATH)
└── tools/                  # Python scripts (added to PATH)
```

---

## 📖 Command Reference

### Ai Llm

| Alias | Runs | Description |
|-------|------|-------------|
| `ollrun` | `ollama run MODEL` | Run a local LLM model via Ollama |
| `ollmls` | `ollama list` | List locally downloaded Ollama models |
| `ollpull` | `ollama pull MODEL` | Download an Ollama model |
| `ollamaserv` | `ollama serve` | Start Ollama API server on port 11434 |
| `llmchat` | `curl localhost:11434/api/generate with JSON` | Chat with local Ollama model via curl |
| `tokcount` | `python3 -c tiktoken count tokens` | Count tokens in a string (requires tiktoken) |
| `openai` | `curl api.openai.com/v1/chat/completions` | Send a prompt to OpenAI API via curl |

### Aws Cli

| Alias | Runs | Description |
|-------|------|-------------|
| `awsid` | `aws sts get-caller-identity` | Show current AWS identity |
| `awsls` | `aws s3 ls` | List S3 buckets |
| `awscp` | `aws s3 cp FILE s3://BUCKET/` | Copy file to S3 |
| `awssync` | `aws s3 sync DIR s3://BUCKET/` | Sync directory to S3 |
| `awsec2` | `aws ec2 describe-instances` | List EC2 instances |
| `awsecr` | `aws ecr get-login-password \| docker login` | ECR docker login |
| `awslam` | `aws lambda list-functions` | List Lambda functions |
| `awslog` | `aws logs tail LOG_GROUP --follow` | Tail CloudWatch logs |
| `awseb` | `aws elasticbeanstalk describe-environments` | List EB environments |
| `awscf` | `aws cloudformation list-stacks` | List CloudFormation stacks |
| `awseks` | `aws eks list-clusters` | List EKS clusters |
| `awsrds` | `aws rds describe-db-instances` | List RDS instances |
| `awsssm` | `aws ssm start-session --target INSTANCE` | SSM session to instance |
| `awswho` | `aws iam get-user` | Show current IAM user |
| `awsregions` | `aws ec2 describe-regions --output table` | List all AWS regions |

### Cloud Deploy

| Alias | Runs | Description |
|-------|------|-------------|
| `vdeploy` | `vercel --prod` | Deploy to Vercel production |
| `vdev` | `vercel dev` | Start local Vercel dev server |
| `venvpull` | `vercel env pull .env.local` | Pull Vercel environment variables to local |
| `hdeploy` | `git push heroku main` | Deploy to Heroku via git |
| `hlogs` | `heroku logs --tail` | Tail Heroku app logs |
| `hbash` | `heroku run bash` | Open bash shell on Heroku dyno |
| `hrestart` | `heroku restart` | Restart all Heroku dynos |
| `rdeploy` | `railway up` | Deploy to Railway |
| `rlogs` | `railway logs` | Show Railway deployment logs |
| `fldeploy` | `fly deploy` | Deploy to Fly.io |
| `fllogs` | `fly logs` | Show Fly.io logs |
| `flssh` | `fly ssh console` | SSH into Fly.io machine |
| `flscale` | `fly scale count N` | Scale Fly.io instance count |

### Cybersecurity Network Recon

| Alias | Runs | Description |
|-------|------|-------------|
| `tn` | `telnet HOST` | Telnet to a host |
| `tnp` | `telnet HOST PORT` | Telnet to host:port |
| `nsa` | `netstat -an` | Netstat all connections |
| `nstcp` | `netstat -tlnp` | Netstat listening TCP ports |
| `nsudp` | `netstat -ulnp` | Netstat listening UDP ports |
| `nsproc` | `netstat -tulnp` | Netstat with process info |
| `nsest` | `netstat -an \| grep ESTABLISHED` | Netstat established connections |
| `nquick` | `nmap -F HOST` | Nmap quick scan (top 100 ports) |
| `nfull` | `nmap -p- HOST` | Nmap full TCP port scan |
| `nsvc` | `nmap -sV HOST` | Nmap service version detection |
| `nos` | `sudo nmap -O HOST` | Nmap OS detection |
| `nagg` | `sudo nmap -A HOST` | Nmap aggressive scan (OS+ver+scripts) |
| `nsyn` | `sudo nmap -sS HOST` | Nmap stealth SYN scan |
| `nudp` | `sudo nmap -sU HOST` | Nmap UDP scan |
| `nsweep` | `nmap -sn SUBNET` | Nmap ping sweep (discover hosts) |
| `nvuln` | `nmap --script vuln HOST` | Nmap vulnerability scan |
| `nports` | `nmap -p PORTS HOST` | Nmap scan specific ports |
| `nscript` | `nmap -sC HOST` | Nmap scan with default scripts |
| `nmapxml` | `nmap -oX output.xml HOST` | Nmap XML output for parsing |
| `ncl` | `nc -lvp PORT` | Netcat listen on port |
| `ncs` | `nc HOST PORT` | Netcat connect to host:port |
| `ncscan` | `nc -zv HOST START-END` | Port scan with netcat |
| `sslcheck` | `openssl s_client + x509 DOMAIN` | Check SSL certificate info |
| `sslchain` | `openssl s_client -showcerts DOMAIN` | Show full SSL cert chain |
| `sslciphers` | `nmap ssl-enum-ciphers -p 443 DOMAIN` | Enumerate SSL ciphers |
| `bannergrab` | `nc -w 3 HOST PORT` | Banner grab via netcat |
| `myports` | `lsof -i -P -n \| grep LISTEN` | Show open ports on this host |
| `arptable` | `arp -a` | Show ARP table |
| `routes` | `netstat -rn / ip route show` | Show routing table |
| `fwrules` | `sudo iptables -L / pfctl -sr` | Show firewall rules |
| `sniff` | `sudo tcpdump -i any -nn` | Packet sniffing (tcpdump) |
| `tcapt` | `sudo tcpdump -w capture.pcap` | Capture packets to file |
| `tcport` | `sudo tcpdump port PORT` | tcpdump filter by port |
| `tchost` | `sudo tcpdump host HOST` | tcpdump filter by host |
| `secheaders` | `curl -sI URL \| grep security headers` | Check HTTP security headers |
| `hashpw` | `echo -n PW \| openssl dgst -sha512` | Hash a password (SHA-512) |
| `genpw` | `tr -dc A-Za-z0-9... < /dev/urandom` | Generate random password |
| `worldwrite` | `find / -perm -0002` | Find world-writable files |
| `findsuid` | `find / -perm -4000` | Find SUID binaries |
| `whoson` | `who -a / w` | Show all logged-in users |
| `b64e` | `echo -n STR \| base64` | Base64 encode string |
| `b64d` | `echo -n STR \| base64 --decode` | Base64 decode string |
| `jwtdecode` | `jq -R 'split(\".\") \| .[0],.[1] \| @base64d \| fromjson'` | Decode JWT token |
| `shodanip` | `curl -s https://internetdb.shodan.io/IP` | Fast Shodan IP lookup |
| `sshkey` | `ssh-keygen -t ed25519 -C EMAIL` | Generate modern secure SSH key |

### Data Tools

| Alias | Runs | Description |
|-------|------|-------------|
| `jqpp` | `cat file.json \| jq .` | Pretty-print JSON |
| `jqkeys` | `jq 'keys'` | List top-level JSON keys |
| `jqlen` | `jq 'length'` | Get length of JSON array or object |
| `jqm` | `jq 'map(.FIELD)'` | Map/extract a field from JSON array |
| `jqsel` | `jq '.[] \| select(.key==val)'` | Filter JSON array by field value |
| `yamlcheck` | `python3 -c yaml.safe_load` | Validate YAML file syntax |
| `yaml2json` | `python3 yaml to json` | Convert YAML file to JSON |
| `json2yaml` | `python3 json to yaml` | Convert JSON file to YAML |
| `csvhead` | `head -1 FILE.csv \| tr ',' '\n'` | Show CSV column headers |
| `csvcol` | `cut -d, -f N FILE.csv` | Extract column N from CSV |
| `sortjson` | `jq 'sort_by(.KEY)'` | Sort JSON array by a key |

### Docker

| Alias | Runs | Description |
|-------|------|-------------|
| `dps` | `docker ps` | List running containers |
| `dpsa` | `docker ps -a` | List all containers |
| `di` | `docker images` | List images |
| `drm` | `docker rm` | Remove a container |
| `drmi` | `docker rmi` | Remove an image |
| `drmf` | `docker rm -f \$(docker ps -aq)` | Force remove all containers |
| `drmia` | `docker rmi \$(docker images -q)` | Remove all images |
| `dex` | `docker exec -it CONTAINER bash` | Exec into container |
| `dl` | `docker logs -f CONTAINER` | Follow container logs |
| `dstop` | `docker stop \$(docker ps -aq)` | Stop all containers |
| `dprune` | `docker system prune -af` | Prune everything (containers, images, networks) |
| `dcom` | `docker compose` | Docker Compose shortcut |
| `dcu` | `docker compose up -d` | Compose up (detached) |
| `dcd` | `docker compose down` | Compose down |
| `dcb` | `docker compose build` | Compose build |
| `dcl` | `docker compose logs -f` | Follow compose logs |
| `dcr` | `docker compose restart` | Restart compose services |
| `dvls` | `docker volume ls` | List volumes |
| `dnls` | `docker network ls` | List networks |
| `dbuild` | `docker build -t NAME .` | Build image from Dockerfile |

### Gcp Gcloud

| Alias | Runs | Description |
|-------|------|-------------|
| `gcpid` | `gcloud config get-value project` | Show current GCP project |
| `gcpset` | `gcloud config set project PROJECT` | Set GCP project |
| `gcpls` | `gcloud compute instances list` | List GCE instances |
| `gcpssh` | `gcloud compute ssh INSTANCE` | SSH into GCE instance |
| `gcpgke` | `gcloud container clusters list` | List GKE clusters |
| `gcpgkecreds` | `gcloud container clusters get-credentials CLUSTER` | Get GKE kubeconfig |
| `gcpbq` | `bq ls` | List BigQuery datasets |
| `gcpgsutil` | `gsutil ls` | List GCS buckets |
| `gcpcp` | `gsutil cp FILE gs://BUCKET/` | Copy file to GCS |
| `gcpsync` | `gsutil -m rsync -r DIR gs://BUCKET/` | Sync directory to GCS |
| `gcprun` | `gcloud run services list` | List Cloud Run services |
| `gcpfn` | `gcloud functions list` | List Cloud Functions |
| `gcpsql` | `gcloud sql instances list` | List Cloud SQL instances |
| `gcplog` | `gcloud logging read FILTER --limit=50` | Read GCP logs |
| `gcpauth` | `gcloud auth login` | Authenticate with GCP |

### Git Aliases

| Alias | Runs | Description |
|-------|------|-------------|
| `gs` | `git status` | Show working tree status |
| `gss` | `git status -s` | Short-format status |
| `ga` | `git add .` | Stage all changes |
| `gaf` | `git add FILE` | Stage a specific file |
| `gc` | `git commit -m MSG` | Commit with message |
| `gca` | `git commit -a -m MSG` | Commit all tracked files |
| `gcam` | `git commit --amend -m MSG` | Amend last commit message |
| `gcan` | `git commit --amend --no-edit` | Amend last commit, keep message |
| `gp` | `git push` | Push to origin |
| `gpf` | `git push --force` | Force push |
| `gpfl` | `git push --force-with-lease` | Force push (safer) |
| `gpu` | `git push -u origin BRANCH` | Push and set upstream |
| `gl` | `git pull` | Pull from origin |
| `glr` | `git pull --rebase` | Pull with rebase |
| `glp` | `git pull --prune` | Pull and prune dead refs |
| `gb` | `git branch` | List local branches |
| `gba` | `git branch -a` | List all branches (local+remote) |
| `gbd` | `git branch -d BRANCH` | Delete a branch |
| `gbdf` | `git branch -D BRANCH` | Force delete a branch |
| `gco` | `git checkout BRANCH` | Checkout a branch |
| `gcob` | `git checkout -b BRANCH` | Create + checkout new branch |
| `gcop` | `git checkout -` | Checkout previous branch |
| `gcom` | `git checkout main \|\| git checkout master` | Checkout main/master |
| `gsw` | `git switch BRANCH` | Switch to branch (modern) |
| `gswc` | `git switch -c BRANCH` | Create + switch to new branch |
| `gm` | `git merge BRANCH` | Merge a branch |
| `gmnf` | `git merge --no-ff BRANCH` | Merge with no fast-forward |
| `gma` | `git merge --abort` | Abort a merge |
| `gbm` | `git branch --merged` | Show merged branches |
| `glog` | `git log --oneline --decorate --graph` | Pretty commit graph |
| `gloga` | `git log --oneline --decorate --graph --all` | Pretty graph, all branches |
| `glogd` | `git log --pretty=format:'%h %ad %s' --date=short` | Log with dates |
| `glogs` | `git log --stat` | Log with file stats |
| `glogp` | `git log -p` | Log with patches |
| `glast` | `git log -1 HEAD` | Show last commit |
| `gblame` | `git blame FILE` | Show who changed each line |
| `gshow` | `git show` | Show last commit details |
| `gauthor` | `git log --author NAME` | Filter log by author |
| `gsearch` | `git log --all --grep TERM` | Search commit messages |
| `gbv` | `git branch -v` | Branches with last commit |
| `gbvv` | `git branch -vv` | Branches with tracking info |
| `grl` | `git reflog` | Show reflog |
| `gd` | `git diff` | Show unstaged diff |
| `gds` | `git diff --staged` | Show staged diff |
| `gdst` | `git diff --stat` | Diff with stats |
| `gdw` | `git diff --word-diff` | Word-level diff |
| `gdc` | `git diff --color-words` | Color word diff |
| `gdfiles` | `git diff --name-only` | List changed filenames |
| `gdstat` | `git diff --name-status` | Changed files with status |
| `gdlc` | `git diff HEAD^ HEAD` | Diff of last commit |
| `glst` | `git ls-files` | List tracked files |
| `glsu` | `git ls-files --others` | List untracked files |
| `gcontrib` | `git shortlog -sn` | Show contributors |
| `gfh` | `git log --follow -p -- FILE` | Show full file history |
| `gst` | `git stash` | Stash changes |
| `gstm` | `git stash push -m MSG` | Stash with message |
| `gstu` | `git stash -u` | Stash including untracked |
| `gsta` | `git stash -a` | Stash all (including ignored) |
| `gstl` | `git stash list` | List stashes |
| `gsts` | `git stash show -p` | Show stash content |
| `gstap` | `git stash apply` | Apply last stash |
| `gstpo` | `git stash pop` | Pop last stash |
| `gstd` | `git stash drop` | Drop a stash |
| `gstc` | `git stash clear` | Clear all stashes |
| `gr` | `git remote` | Show remotes |
| `grv` | `git remote -v` | Show remotes with URLs |
| `gra` | `git remote add NAME URL` | Add a remote |
| `grr` | `git remote remove NAME` | Remove a remote |
| `gf` | `git fetch` | Fetch from origin |
| `gfa` | `git fetch --all` | Fetch all remotes |
| `gfp` | `git fetch --prune` | Fetch with prune |
| `gcl` | `git clone URL` | Clone a repository |
| `gcld` | `git clone --depth 1 URL` | Shallow clone |
| `grss` | `git reset --soft HEAD~1` | Soft reset last commit |
| `grsm` | `git reset HEAD~1` | Mixed reset last commit |
| `grsh` | `git reset --hard HEAD~1` | Hard reset last commit |
| `grso` | `git reset --hard origin/BRANCH` | Reset to origin |
| `gus` | `git reset HEAD` | Unstage all files |
| `gusf` | `git reset HEAD -- FILE` | Unstage a specific file |
| `gcn` | `git clean -n` | Clean dry run |
| `gcf` | `git clean -f` | Clean untracked files |
| `gcfd` | `git clean -fd` | Clean untracked files + dirs |
| `gdis` | `git checkout -- FILE` | Discard changes in file |
| `gcpy` | `git cherry-pick HASH` | Cherry-pick a commit |
| `gcpc` | `git cherry-pick --continue` | Continue cherry-pick |
| `gcpa` | `git cherry-pick --abort` | Abort cherry-pick |
| `grbi` | `git rebase -i HASH` | Interactive rebase |
| `grbc` | `git rebase --continue` | Continue rebase |
| `grba` | `git rebase --abort` | Abort rebase |
| `grbs` | `git rebase --skip` | Skip rebase step |
| `gt` | `git tag` | Show tags |
| `gta` | `git tag -a TAG` | Create annotated tag |
| `gpht` | `git push --tags` | Push all tags |

### Git Workflow

| Alias | Runs | Description |
|-------|------|-------------|
| `gg` | `git add . && git commit -m MSG && git push` | Add all, commit, push in one shot |
| `gclo` | `git clone https://github.com/USER/REPO` | Clone a GitHub repo |
| `jclo` | `git clone https://github.com/juleshenry/REPO` | Clone a juleshenry repo |
| `presto` | `git checkout --orphan && force-push` | DESTRUCTIVE: wipe all git history |
| `gwip` | `git add . && git commit -m 'wip: TIME'` | Quick work-in-progress commit (no push) |
| `gunwip` | `git reset --soft HEAD~1` | Undo last WIP commit, keep changes staged |
| `gpristine` | `git reset --hard origin/BRANCH && git clean -fd` | Hard-reset to match remote exactly |
| `gtag` | `git tag -a TAG -m MSG && git push origin TAG` | Create and push a git tag |
| `ghprc` | `gh pr create --title TITLE --fill` | Create a GitHub PR via gh CLI |
| `gdiff-fancy` | `git diff --stat + git diff --shortstat` | Pretty diff summary with stats |
| `gacp` | `git add . && git commit -m MSG && git push` | Add, commit, push (same as gg) |
| `ginit` | `git init && git add . && git commit -m 'Initial commit'` | Init repo with first commit |
| `ghcl` | `git clone https://github.com/USER/REPO` | Clone from GitHub |
| `gbc` | `git checkout -b BRANCH` | Create and switch to new branch |
| `gbdall` | `git branch -d B && git push origin --delete B` | Delete branch locally + remotely |
| `gundo` | `git reset --soft HEAD~1` | Undo last commit, keep changes staged |
| `gbs` | `git for-each-ref --sort=-committerdate` | Show branches sorted by last modified |
| `gquick` | `git add . && git commit -m 'Quick update: TIME' && git push` | Commit+push with auto-timestamp |
| `gchanged` | `git diff --name-only HEAD~N..HEAD` | Show changed files in last N commits |
| `gsearchtext` | `git log -S TEXT` | Search for text across git history |
| `gnew` | `git fetch origin && git checkout -b B origin/main` | Create branch from origin/main |
| `gupdateall` | `git fetch --all && git pull` | Fetch all remotes and pull |
| `greposize` | `git count-objects -vH` | Show repo object storage size |
| `gfilesize` | `git ls-tree -r -t -l --full-name HEAD \| sort` | List files by size in repo |
| `glarge` | `git rev-list --objects --all \| ...` | Find N largest blobs in history |
| `gsyncfork` | `git fetch upstream && merge upstream/main` | Sync fork with upstream/main |
| `gsquash` | `git reset --soft HEAD~N && git commit -m MSG` | Squash last N commits |
| `gstats` | `git shortlog -sn --all --no-merges` | Commit count by author |
| `garchive` | `git tag archive/B && delete branch` | Archive a branch as a tag |
| `galias` | `alias \| grep '^g'` | List all g* aliases |
| `ginfo` | `repo name, branch, remote, last commit` | Show repo info summary |
| `gbackup` | `tar -czf backup.tar.gz .` | Tar.gz backup of current repo |

### Github Cli

| Alias | Runs | Description |
|-------|------|-------------|
| `ghpr` | `gh pr create` | Create a GitHub pull request |
| `ghprs` | `gh pr status` | Show status of PR for current branch |
| `ghprl` | `gh pr list` | List open pull requests |
| `ghprd` | `gh pr diff` | Show diff of current PR |
| `ghprm` | `gh pr merge` | Merge current pull request |
| `ghprco` | `gh pr checkout NUMBER` | Checkout a pull request by number |
| `ghil` | `gh issue list` | List open GitHub issues |
| `ghic` | `gh issue create` | Create a new GitHub issue |
| `ghiv` | `gh issue view NUMBER` | View a specific issue |
| `ghrl` | `gh release list` | List GitHub releases |
| `ghrc` | `gh release create` | Create a new GitHub release |
| `ghrepo` | `gh repo view --web` | Open current repo in browser |
| `ghrun` | `gh run list` | List recent GitHub Actions workflow runs |
| `ghrw` | `gh run watch` | Watch GitHub Actions run live |
| `ghssh` | `gh auth refresh -h github.com -s admin:public_key` | Add SSH key to GitHub |
| `ghclone` | `gh repo clone OWNER/REPO` | Clone repo using gh (auto SSH) |
| `ghfork` | `gh repo fork --clone` | Fork and clone a GitHub repo |

### Homebrew

| Alias | Runs | Description |
|-------|------|-------------|
| `brewi` | `brew install PACKAGE` | Install a Homebrew package |
| `brewic` | `brew install --cask APP` | Install a Homebrew cask (GUI app) |
| `brewu` | `brew upgrade` | Upgrade all Homebrew packages |
| `brewup` | `brew upgrade PACKAGE` | Upgrade a specific package |
| `brewun` | `brew uninstall PACKAGE` | Uninstall a Homebrew package |
| `brewls` | `brew list` | List installed Homebrew packages |
| `brewlsc` | `brew list --cask` | List installed casks |
| `brews` | `brew search TERM` | Search Homebrew packages |
| `brewinfo` | `brew info PACKAGE` | Show info about a package |
| `brewout` | `brew outdated` | List outdated packages |
| `brewdr` | `brew doctor` | Check Homebrew for issues |
| `brewcl` | `brew cleanup` | Remove old versions and cache |
| `brewpin` | `brew pin PACKAGE` | Pin a package to prevent upgrades |
| `brewupin` | `brew unpin PACKAGE` | Unpin a package |
| `brewsv` | `brew services list` | List all Homebrew services |
| `brewstart` | `brew services start SERVICE` | Start a Homebrew service |
| `brewstop` | `brew services stop SERVICE` | Stop a Homebrew service |
| `brewre` | `brew services restart SERVICE` | Restart a Homebrew service |
| `brewdeps` | `brew deps --tree PACKAGE` | Show dependency tree for a package |
| `brewsize` | `brew info PACKAGE \| grep -i 'installed'` | Show installed size of a package |
| `brewup-all` | `brew update && upgrade && cleanup` | Update, upgrade, and clean up everything |

### Java Jvm

| Alias | Runs | Description |
|-------|------|-------------|
| `jver` | `java -version` | Show Java version |
| `jcc` | `javac FILE.java` | Compile Java source file |
| `jrun` | `java CLASS` | Run compiled Java class |
| `mci` | `mvn clean install` | Maven clean install |
| `mcp` | `mvn clean package` | Maven clean package |
| `mt` | `mvn test` | Maven run tests |
| `mcl` | `mvn clean` | Maven clean |
| `mdeps` | `mvn dependency:tree` | Maven dependency tree |
| `mspring` | `mvn spring-boot:run` | Maven Spring Boot run |
| `grb` | `gradle build` | Gradle build |
| `grcl` | `gradle clean` | Gradle clean |
| `grt` | `gradle test` | Gradle run tests |
| `grrun` | `gradle run` | Gradle run application |
| `grdeps` | `gradle dependencies` | Gradle dependency tree |
| `grspring` | `gradle bootRun` | Gradle Spring Boot run |

### Kubernetes

| Alias | Runs | Description |
|-------|------|-------------|
| `k` | `kubectl` | kubectl shortcut |
| `kgp` | `kubectl get pods` | List pods |
| `kgpa` | `kubectl get pods --all-namespaces` | List all pods across namespaces |
| `kgs` | `kubectl get svc` | List services |
| `kgn` | `kubectl get nodes` | List nodes |
| `kgd` | `kubectl get deployments` | List deployments |
| `kgi` | `kubectl get ingress` | List ingresses |
| `kgns` | `kubectl get namespaces` | List namespaces |
| `kga` | `kubectl get all` | List all resources |
| `kdp` | `kubectl describe pod POD` | Describe a pod |
| `kds` | `kubectl describe svc SVC` | Describe a service |
| `kdd` | `kubectl describe deployment DEP` | Describe a deployment |
| `kl` | `kubectl logs -f POD` | Follow pod logs |
| `klp` | `kubectl logs -f POD -p` | Previous pod logs |
| `kex` | `kubectl exec -it POD -- bash` | Exec into a pod |
| `kaf` | `kubectl apply -f FILE` | Apply a manifest |
| `kdf` | `kubectl delete -f FILE` | Delete from manifest |
| `kctx` | `kubectl config get-contexts` | Show kube contexts |
| `kuse` | `kubectl config use-context CTX` | Switch kube context |
| `kns` | `kubectl config set-context --current --namespace=NS` | Set default namespace |
| `kpf` | `kubectl port-forward POD LOCAL:REMOTE` | Port-forward to a pod |
| `kscale` | `kubectl scale deployment DEP --replicas=N` | Scale a deployment |
| `krollout` | `kubectl rollout status deployment DEP` | Check rollout status |
| `krestart` | `kubectl rollout restart deployment DEP` | Restart a deployment |
| `ktop` | `kubectl top pods` | Pod resource usage |
| `ktopn` | `kubectl top nodes` | Node resource usage |

### Macos Power Tools

| Alias | Runs | Description |
|-------|------|-------------|
| `caf` | `caffeinate -d` | Prevent Mac from sleeping |
| `hidefiles` | `defaults write com.apple.finder AppleShowAllFiles NO; killall Finder` | Hide hidden files in Finder |
| `showfiles` | `defaults write com.apple.finder AppleShowAllFiles YES; killall Finder` | Show hidden files in Finder |
| `flushui` | `killall Dock; killall Finder` | Restart Dock and Finder to fix UI glitches |
| `copyurl` | `osascript -e 'tell app \"Safari\" to get URL of front document' \| pbcopy` | Copy URL of active Safari tab |
| `copycwd` | `pwd \| tr -d '\n' \| pbcopy` | Copy current directory path to clipboard |
| `locks` | `/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend` | Lock mac screen immediately |
| `emptytrash` | `rm -rf ~/.Trash/*` | Empty the Trash immediately |

### Media Tools

| Alias | Runs | Description |
|-------|------|-------------|
| `ytdl` | `yt-dlp URL` | Download a YouTube video (best quality) |
| `ytmp3` | `yt-dlp -x --audio-format mp3 URL` | Download YouTube video as MP3 |
| `ytpl` | `yt-dlp -i URL` | Download entire YouTube playlist |
| `ffconv` | `ffmpeg -i INPUT OUTPUT` | Convert video with ffmpeg |
| `ff2mp4` | `ffmpeg -i INPUT -c:v libx264 output.mp4` | Convert any video to H.264 mp4 |
| `fftrim` | `ffmpeg -i INPUT -ss START -to END -c copy OUTPUT` | Trim video by time range |
| `ffcomp` | `ffmpeg -i INPUT -crf 28 -preset fast OUTPUT.mp4` | Compress video (CRF 28) |
| `ffvid2gif` | `ffmpeg -i INPUT -vf scale=480:-1 OUTPUT.gif` | Convert video to GIF |
| `ffaudio` | `ffmpeg -i INPUT -vn -q:a 0 OUTPUT.mp3` | Extract audio from video |
| `imgres` | `convert INPUT -resize WxH OUTPUT` | Resize image with ImageMagick |
| `imgstrip` | `convert INPUT -strip OUTPUT` | Strip EXIF metadata from image |
| `imgnorm` | `mogrify -auto-orient -strip FOLDER/*.jpg` | Normalize images in folder |

### Meta

| Alias | Runs | Description |
|-------|------|-------------|
| `G` | `G [cmd] or G -a <alias> <cmd>` | Ghee hot-doc shell |
| `gheelp` | `print reference table` | Full command reference |
| `gupdate` | `git pull && ./setup-ghee` | Auto-update ghee to latest version |

### Misc Cli Tools

| Alias | Runs | Description |
|-------|------|-------------|
| `duh` | `du -sh * \| sort -rh` | Disk usage summary (sorted) |
| `dfh` | `df -h` | Disk free (human-readable) |
| `fmem` | `free -h` | Free memory |
| `cpuinfo` | `lscpu` | CPU info |
| `w2` | `watch -n 2 CMD` | Watch a command every 2 seconds |
| `lsofp` | `lsof -c PROCESS` | List open files by process |
| `killname` | `pkill -f NAME` | Kill process by name |
| `hist` | `history \| tail -50` | Last 50 history entries |
| `cl` | `clear` | Clear terminal |
| `reload` | `exec \$SHELL -l` | Reload shell config |
| `erc` | `\${EDITOR:-vi} ~/.<shell>rc` | Edit shell RC file |
| `path` | `echo \$PATH \| tr : newline` | Show PATH (one per line) |
| `cx` | `chmod +x FILE` | Make file executable |
| `isodate` | `date -u +%Y-%m-%dT%H:%M:%SZ` | Print ISO 8601 timestamp |
| `sh256` | `shasum -a 256 FILE` | SHA256 hash of file |
| `md5s` | `md5 FILE` | MD5 hash of file |

### Misc Devops

| Alias | Runs | Description |
|-------|------|-------------|
| `hup` | `helm upgrade --install RELEASE CHART` | Helm upgrade/install |
| `hls` | `helm list` | List Helm releases |
| `hdel` | `helm uninstall RELEASE` | Uninstall Helm release |
| `ans` | `ansible-playbook PLAYBOOK.yml` | Run Ansible playbook |
| `vup` | `vagrant up` | Start Vagrant VM |
| `vsh` | `vagrant ssh` | SSH into Vagrant VM |
| `vhalt` | `vagrant halt` | Stop Vagrant VM |

### Mongodb

| Alias | Runs | Description |
|-------|------|-------------|
| `mongosh` | `mongosh` | Launch MongoDB shell |
| `mstart` | `brew services start mongodb-community` | Start MongoDB (macOS Homebrew) |
| `mstop` | `brew services stop mongodb-community` | Stop MongoDB (macOS Homebrew) |
| `mrestart` | `brew services restart mongodb-community` | Restart MongoDB |
| `mdump` | `mongodump --db DB --out ./dump` | Dump a MongoDB database |
| `mrestore` | `mongorestore --db DB ./dump/DB` | Restore a MongoDB database |
| `mexport` | `mongoexport --db DB --collection COL --out file.json` | Export collection to JSON |
| `mimport` | `mongoimport --db DB --collection COL --file file.json` | Import JSON into collection |

### Networking

| Alias | Runs | Description |
|-------|------|-------------|
| `curlt` | `curl with timing breakdown` | curl with DNS/connect/TLS timing |
| `curlh` | `curl -I URL` | Show HTTP response headers |
| `curlj` | `curl -X POST -H JSON -d DATA URL` | curl POST with JSON body |
| `wgetm` | `wget --mirror URL` | Mirror/download entire site |
| `myip` | `curl ifconfig.me` | Show public IP address |
| `localip` | `ipconfig getifaddr en0` | Show local IP address |
| `ping5` | `ping -c 5 HOST` | Ping with 5 packets |
| `digs` | `dig +short DOMAIN` | Quick DNS lookup |
| `digr` | `dig -x IP` | Reverse DNS lookup |
| `nsl` | `nslookup DOMAIN` | nslookup shortcut |
| `trce` | `traceroute HOST` | Traceroute to host |
| `nstat` | `netstat -tlnp` | Show listening ports (netstat) |
| `ssl` | `ss -tlnp` | Show listening ports (ss) |
| `conns` | `ss -s` | Show connection summary |
| `portcheck` | `nc -zv HOST PORT` | Check if a port is open |
| `speedtest` | `speedtest-cli via python` | Internet speed test |
| `ifls` | `ifconfig / ip addr show` | List network interfaces |
| `headers` | `curl -sI URL` | Show HTTP headers for URL |
| `dlf` | `curl -L -O --progress-bar URL` | Download file with progress |
| `macspoof` | `sudo ifconfig en0 ether \$(openssl rand -hex 6 \| sed 's/\(.*\)/\1:/g; s/.$//')` | Spoof MAC address (macOS) |
| `dnsflush` | `sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder` | Flush DNS cache (macOS) |
| `listenpy` | `python3 -m http.server 8000` | Quick HTTP server to share files |
| `urlencode` | `python3 -c 'import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))'` | URL Encode string |
| `urldecode` | `python3 -c 'import urllib.parse, sys; print(urllib.parse.unquote(sys.argv[1]))'` | URL Decode string |

### Nginx

| Alias | Runs | Description |
|-------|------|-------------|
| `ngt` | `sudo nginx -t` | Test nginx config |
| `ngr` | `sudo nginx -s reload` | Reload nginx |
| `ngstart` | `sudo systemctl start nginx` | Start nginx |
| `ngstop` | `sudo systemctl stop nginx` | Stop nginx |
| `ngrestart` | `sudo systemctl restart nginx` | Restart nginx |
| `ngstatus` | `sudo systemctl status nginx` | Nginx service status |
| `ngedit` | `sudo vi /etc/nginx/nginx.conf` | Edit nginx config |
| `ngacc` | `sudo tail -f /var/log/nginx/access.log` | Tail nginx access log |
| `ngerr` | `sudo tail -f /var/log/nginx/error.log` | Tail nginx error log |
| `ngsites` | `ls /etc/nginx/sites-enabled/` | List nginx sites-enabled |
| `ngconf` | `sudo nginx -T` | Dump full nginx config |

### Npm Yarn Pnpm

| Alias | Runs | Description |
|-------|------|-------------|
| `ni` | `npm install` | npm install |
| `nid` | `npm install --save-dev` | npm install as dev dependency |
| `nig` | `npm install -g` | npm install globally |
| `nrd` | `npm run dev` | npm run dev server |
| `nrb` | `npm run build` | npm run build |
| `nrs` | `npm run start` | npm run start |
| `nrt` | `npm run test` | npm run test |
| `nrl` | `npm run lint` | npm run lint |
| `nls` | `npm list --depth=0` | List top-level npm packages |
| `nout` | `npm outdated` | Show outdated npm packages |
| `nup` | `npm update` | Update npm packages |
| `naf` | `npm audit fix` | Fix npm audit vulnerabilities |
| `ncc` | `npm cache clean --force` | Clear npm cache |
| `ninit` | `npm init -y` | Initialize new npm project |
| `nx` | `npx` | npx shortcut |
| `yi` | `yarn install` | Yarn install dependencies |
| `ya` | `yarn add PACKAGE` | Yarn add package |
| `yad` | `yarn add --dev PACKAGE` | Yarn add dev dependency |
| `yrd` | `yarn dev` | Yarn dev server |
| `yrb` | `yarn build` | Yarn build |
| `yrs` | `yarn start` | Yarn start |
| `yrt` | `yarn test` | Yarn test |
| `yga` | `yarn global add PACKAGE` | Yarn global install |
| `pi` | `pnpm install` | pnpm install dependencies |
| `pad` | `pnpm add PACKAGE` | pnpm add package |
| `padd` | `pnpm add -D PACKAGE` | pnpm add dev dependency |
| `prd` | `pnpm dev` | pnpm dev server |
| `prb` | `pnpm build` | pnpm build |
| `prs` | `pnpm start` | pnpm start |
| `prt` | `pnpm test` | pnpm test |

### Postgresql

| Alias | Runs | Description |
|-------|------|-------------|
| `pg` | `psql` | PostgreSQL CLI |
| `pgsu` | `sudo -u postgres psql` | psql as postgres superuser |
| `pgls` | `psql -l` | List PostgreSQL databases |
| `pgdb` | `psql -d DB [-U user]` | Connect to a database |
| `pgdump` | `pg_dump DATABASE` | Dump a database |
| `pgrestore` | `pg_restore FILE` | Restore a database dump |
| `pgcreate` | `createdb DATABASE` | Create a database |
| `pgdrop` | `dropdb DATABASE` | Drop a database |
| `pgroles` | `psql -c '\\du'` | List PostgreSQL roles |
| `pgconn` | `SELECT from pg_stat_activity` | Show active connections |
| `pgsize` | `SELECT relname, pg_size_pretty(...)` | Show table sizes |
| `pgrunning` | `SELECT from pg_stat_activity WHERE active` | Show running queries |
| `pgvacuum` | `VACUUM FULL` | Run full vacuum |
| `pgstatus` | `systemctl status postgresql` | PostgreSQL service status |
| `pgver` | `psql --version` | PostgreSQL version |

### Python Pip Venv

| Alias | Runs | Description |
|-------|------|-------------|
| `py` | `python3` | Python3 shortcut |
| `py2` | `python2` | Python2 shortcut |
| `pip3i` | `pip3 install PACKAGE` | pip install a package |
| `pipr` | `pip3 install -r requirements.txt` | pip install from requirements |
| `pipf` | `pip3 freeze > requirements.txt` | Freeze pip deps to requirements |
| `pipl` | `pip3 list` | List installed pip packages |
| `pipo` | `pip3 list --outdated` | List outdated pip packages |
| `pipu` | `pip3 install --upgrade PACKAGE` | Upgrade a pip package |
| `pipun` | `pip3 uninstall PACKAGE` | Uninstall a pip package |
| `venv` | `python3 -m venv venv` | Create a virtual environment |
| `va` | `source venv/bin/activate` | Activate venv |
| `vd` | `deactivate` | Deactivate venv |
| `pt` | `pytest` | Run pytest |
| `ptv` | `pytest -v` | Run pytest verbose |
| `ptc` | `pytest --cov` | Run pytest with coverage |
| `pym` | `python3 -m MODULE` | Run Python module |
| `ipy` | `ipython` | Launch IPython |
| `jnb` | `jupyter notebook` | Launch Jupyter Notebook |
| `jlab` | `jupyter lab` | Launch Jupyter Lab |
| `pide` | `pip3 install -e .` | pip install in editable mode |

### Redis

| Alias | Runs | Description |
|-------|------|-------------|
| `rd` | `redis-cli` | Redis CLI |
| `rdping` | `redis-cli ping` | Ping Redis server |
| `rdinfo` | `redis-cli info` | Redis server info |
| `rdmon` | `redis-cli monitor` | Monitor Redis commands in real-time |
| `rdkeys` | `redis-cli keys '*'` | List all Redis keys |
| `rdget` | `redis-cli get KEY` | Get a Redis key value |
| `rdset` | `redis-cli set KEY VAL` | Set a Redis key |
| `rddel` | `redis-cli del KEY` | Delete a Redis key |
| `rdflush` | `redis-cli flushdb` | Flush current Redis DB |
| `rdflushall` | `redis-cli flushall` | Flush all Redis DBs |
| `rdsize` | `redis-cli dbsize` | Show Redis DB key count |
| `rdshut` | `redis-cli shutdown` | Shutdown Redis server |

### Rust Go

| Alias | Runs | Description |
|-------|------|-------------|
| `cb` | `cargo build` | Build Rust project |
| `cbr` | `cargo build --release` | Build Rust project in release mode |
| `cr` | `cargo run` | Build and run Rust project |
| `ct` | `cargo test` | Run Rust tests |
| `ccheck` | `cargo check` | Fast syntax/type check (no compile) |
| `cclippy` | `cargo clippy` | Run Rust linter (clippy) |
| `cfmt` | `cargo fmt` | Format Rust code |
| `cadd` | `cargo add CRATE` | Add a Rust crate dependency |
| `gbuild` | `go build ./...` | Build Go project |
| `grun` | `go run .` | Run Go main package |
| `gotst` | `go test ./...` | Run all Go tests |
| `gvet` | `go vet ./...` | Run Go static analysis |
| `gmod` | `go mod tidy` | Tidy Go module dependencies |
| `gofm` | `gofmt -w .` | Format all Go files |
| `gget` | `go get PACKAGE` | Install a Go package |

### Shell File Utilities

| Alias | Runs | Description |
|-------|------|-------------|
| `h` | `history \| grep TERM` | Grep shell history |
| `hl` | `history lucky match + exec` | Run penultimate history match |
| `dst` | `find . -name '.DS_Store' -exec rm` | Remove .DS_Store files recursively |
| `dust-kash` | `find . -name '*.kash' -exec rm` | Remove .kash cache files recursively |
| `date-file-maker` | `touch MM-DD-YY-HH:MM:SS.txt` | Create a UTC-timestamped file |
| `swap` | `mv file1 tmp && mv file2 file1 && mv tmp file2` | Swap names of two files |
| `mkcd` | `mkdir -p DIR && cd DIR` | mkdir + cd in one step |
| `extract` | `tar/unzip/7z/etc` | Universal archive extractor |
| `tre` | `tree -I '.git\|node_modules'` | tree with junk dirs ignored |
| `ports` | `lsof -iTCP -sTCP:LISTEN` | Show listening TCP ports |
| `sizeof` | `du -sh PATH` | Human-readable size of file/dir |
| `blk` | `python3 -m black FILE` | Run Python Black formatter |
| `serve` | `python3 -m http.server PORT` | Quick HTTP server |
| `jql` | `jq -C '.' FILE \| less -R` | Pretty-print JSON with less |
| `rmdstore` | `find . -name '.DS_Store' -delete` | Remove .DS_Store with feedback |
| `rmnodemodules` | `find+rm node_modules` | Interactively remove node_modules dirs |
| `countext` | `find . -type f \| sed/sort/uniq` | Count files by extension |
| `findlarge` | `find . -type f -size +N` | Find files larger than N |

### Ssh Scp

| Alias | Runs | Description |
|-------|------|-------------|
| `sshtun` | `ssh -L LOCAL_PORT:localhost:REMOTE_PORT USER@HOST` | SSH local port forwarding tunnel |
| `sshrtun` | `ssh -R REMOTE_PORT:localhost:LOCAL_PORT USER@HOST` | SSH reverse tunnel |
| `sshcopy` | `ssh-copy-id USER@HOST` | Copy SSH key to remote host |
| `sshv` | `ssh -vvv USER@HOST` | SSH with verbose output |
| `sshedit` | `${EDITOR:-vim} ~/.ssh/config` | Edit SSH config |
| `sshkeygen` | `ssh-keygen -t ed25519 -C EMAIL` | Generate ed25519 SSH key |
| `sshadd` | `ssh-add ~/.ssh/id_ed25519` | Add SSH key to agent |
| `sshls` | `ssh-add -l` | List keys loaded in SSH agent |
| `sshjump` | `ssh -J JUMP_HOST USER@DEST_HOST` | SSH via jump host / proxy |
| `sshtest` | `ssh -o ConnectTimeout=5 -q USER@HOST exit` | Test SSH connection |
| `scpto` | `scp FILE USER@HOST:REMOTE_PATH` | SCP file to remote |
| `scpfrom` | `scp USER@HOST:REMOTE_FILE LOCAL_PATH` | SCP file from remote |
| `scptor` | `scp -r DIR USER@HOST:REMOTE_PATH` | SCP directory to remote (recursive) |
| `scpfromr` | `scp -r USER@HOST:REMOTE_DIR LOCAL_PATH` | SCP directory from remote (recursive) |

### Super Utilities

| Alias | Runs | Description |
|-------|------|-------------|
| `cheat` | `curl cheat.sh/CMD` | Get cheat sheet for any CLI command |
| `weather` | `curl wttr.in/LOCATION` | Get the weather forecast in terminal |
| `qrgen` | `curl qrencode.com/STRING` | Generate a QR code in the terminal |
| `uuid` | `uuidgen \| tr '[:upper:]' '[:lower:]'` | Generate a random UUIDv4 |
| `epoch` | `date +%s` | Get current Unix Epoch timestamp |
| `stopwatch` | `time read` | Start a simple stopwatch (press Enter to stop) |
| `timer` | `sleep N && echo 'Time is up!'` | Simple countdown timer |
| `matrix` | `Pure Bash Matrix Effect` | Run the Matrix digital rain in your terminal |

### Systemd Services

| Alias | Runs | Description |
|-------|------|-------------|
| `scs` | `sudo systemctl status SERVICE` | Show service status |
| `scstart` | `sudo systemctl start SERVICE` | Start a service |
| `scstop` | `sudo systemctl stop SERVICE` | Stop a service |
| `screstart` | `sudo systemctl restart SERVICE` | Restart a service |
| `scenable` | `sudo systemctl enable SERVICE` | Enable service at boot |
| `scdisable` | `sudo systemctl disable SERVICE` | Disable service at boot |
| `screload` | `sudo systemctl reload SERVICE` | Reload service config |
| `scdaemon` | `sudo systemctl daemon-reload` | Reload systemd daemon |
| `jctl` | `sudo journalctl -f` | Follow system journal |
| `jctlu` | `sudo journalctl -u SERVICE` | Journal for a specific unit |
| `jctlt` | `sudo journalctl --since today` | Journal since today |
| `scls` | `systemctl list-units --type=service` | List active services |
| `scfail` | `systemctl --failed` | List failed services |
| `scactive` | `systemctl is-active SERVICE` | Check if service is active |
| `scenabled` | `systemctl is-enabled SERVICE` | Check if service is enabled |

### Terraform

| Alias | Runs | Description |
|-------|------|-------------|
| `tf` | `terraform` | Terraform shortcut |
| `tfi` | `terraform init` | Initialize Terraform |
| `tfp` | `terraform plan` | Plan changes |
| `tfa` | `terraform apply` | Apply changes |
| `tfaa` | `terraform apply -auto-approve` | Apply without prompt |
| `tfd` | `terraform destroy` | Destroy infrastructure |
| `tfs` | `terraform state list` | List state resources |
| `tfo` | `terraform output` | Show outputs |
| `tfv` | `terraform validate` | Validate config |
| `tff` | `terraform fmt -recursive` | Format all .tf files |
| `tfw` | `terraform workspace list` | List workspaces |

### Tmux

| Alias | Runs | Description |
|-------|------|-------------|
| `tnew` | `tmux new -s NAME` | Create a new named tmux session |
| `tls` | `tmux ls` | List tmux sessions |
| `tat` | `tmux attach -t NAME` | Attach to a tmux session |
| `tkill` | `tmux kill-session -t NAME` | Kill a tmux session |
| `tkillall` | `tmux kill-server` | Kill all tmux sessions |
| `treload` | `tmux source ~/.tmux.conf` | Reload tmux config |
| `tsplit` | `tmux split-window -h` | Split tmux pane horizontally |
| `tsplitv` | `tmux split-window -v` | Split tmux pane vertically |

---

## 🛠️ Adding Custom Shortcuts

```bash
# Add a custom shortcut — alias first, then the command
G -a olist 'ollama list'        # Now 'olist' works instantly in your shell

# Remove a custom shortcut
G -rm olist                     # Removes alias immediately

# Saved to ~/.ghee-custom — shows up in G search immediately
# Edit ~/.ghee-custom directly for bulk additions:
# alias_name|||the actual command|||description
```

Custom aliases are **live instantly** — no need to restart your shell.

---

## 🤝 Contributing

Contributions are welcome! If you want to add new commands or modules, please follow these steps:

1. **Fork** the repository and create your branch (`git checkout -b feature/new-module`).
2. Add your aliases to an existing module in `modules/` or create a new `.sh` file if it's a completely new category.
3. Make sure you use the standard structure for your aliases and keep descriptions clear and concise.
4. **Test** the installer script (`./setup-ghee`) locally to ensure your changes don't break existing setups.
5. Submit a **Pull Request**.

---

## 🍴 Forking & Personalizing

ghee is designed to be forked. The best way to use it long-term is to maintain your own fork with your personal shortcuts, then sync upstream improvements when they land.

### Quick Fork Setup

```bash
# 1. Fork on GitHub, then clone your fork
gh repo fork juleshenry/ghee --clone
cd ghee

# 2. Install
chmod +x setup-ghee && ./setup-ghee
source ~/.zshrc

# 3. Add your own shortcuts
G -a myalias 'my-custom-command'

# 4. Or add a whole new module
cat > modules/my_team.sh << 'EOF'
#!/bin/bash
# ============================================================================
# Module: My Team
# Description: Custom shortcuts for my team's workflow.
# ============================================================================
_GG_REGISTRY["deploy-staging"]="./scripts/deploy.sh staging|||Deploy to staging"
_GG_REGISTRY["db-migrate"]="rails db:migrate|||Run database migrations"
EOF
chmod +x modules/my_team.sh
```

### Syncing Upstream Changes

```bash
# Add upstream remote (one-time)
git remote add upstream https://github.com/juleshenry/ghee.git

# Pull latest from upstream
git fetch upstream
git merge upstream/main

# Resolve any conflicts in your custom modules, then:
./setup-ghee && source ~/.zshrc
```

Your custom shortcuts in `~/.ghee-custom` are always safe — they live outside the repo and survive any update or reinstall.

---

## 🎨 Why "ghee"?

Ghee is clarified Indian butter — everything impure is removed, leaving only the richest, purest fat. That's this toolkit. No bloat, no noise — just the good stuff, clarified down to its most useful essence, making everything it touches smoother and more delicious. 🧈

---

## 📄 License

MIT — use it, fork it, spread it like butter.
