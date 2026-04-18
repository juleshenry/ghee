# 🧈 ghee

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

> *인도 정제 버터처럼 — 순수하고 풍부하며 모든 것을 더 좋게 만듭니다.*

**ghee**는 개발자, 데브옵스 엔지니어, 파워 유저를 위한 **538개 이상의 셸 단축키** 모음입니다. 기존 셸 위에 매끄럽게 얹혀져 CLI를 빠르고 효율적으로 만들어 줍니다 — 진짜 ghee처럼요.

포함: Git, Docker, Kubernetes, AWS, GCP, Terraform, Heroku, Vercel, Fly.io, Railway, GitHub CLI, npm/yarn/pnpm, Python/pip, Rust, Go, Redis, PostgreSQL, MongoDB, Nginx, systemd, tmux, 네트워킹, 사이버보안/정찰, AI/LLM 도구, 미디어(ffmpeg/yt-dlp), JSON/YAML/CSV, macOS 파워 도구 등.

---

## 📑 목차

- [✨ 기능](#-기능)
- [✅ 요구 사항](#-요구-사항)
- [🚀 설치](#-설치)
- [🎮 G 명령 사용](#-g-명령-사용)
- [📦 프로젝트 구조](#-프로젝트-구조)
- [📖 명령 참조](#-명령-참조)
- [🛠️ 사용자 지정 단축키 추가](#️-사용자-지정-단축키-추가)
- [🤝 기여](#-기여)
- [🎨 왜 "ghee"?](#-왜-ghee)
- [📄 라이선스](#-라이선스)

---

## ✨ 기능

- 🔍 **`G`** — 실시간 미리보기로 538개 명령을 퍼지 검색할 수 있는 인터랙티브 Python TUI
- ⚡ **`G 'docker logs'`** — 셸 명령 최적 매칭, 클립보드로 복사
- ➕ **`G -a <alias> <command>`** — 사용자 지정 단축키 추가, `~/.ghee-custom`에 저장
- ➖ **`G -rm <alias>`** — 사용자 지정 단축키 제거
- 📦 **모듈식** — 29개 주제별 모듈, 셸에 자동 로드
- 🐍 **Python 기반** — 아름다운 Rich TUI, 퍼지 매칭 및 컬러 포매팅
- 🔌 **플러그 앤 플레이** — `./setup-ghee` 30초 이내에 전체 설정 완료

---

## ✅ 요구 사항

- **OS:** macOS 또는 Linux
- **Shell:** `bash` 또는 `zsh`
- **Python:** `python3` (3.8 이상 권장)
- **Git:** 저장소 복제에 필요

---

## 🚀 설치

### 빠른 설정

```bash
git clone https://github.com/juleshenry/ghee.git
cd ghee
chmod +x setup-ghee
./setup-ghee
source ~/.zshrc   # 또는 source ~/.bashrc
```

### 수동 설정

이 블록을 `~/.bashrc` 또는 `~/.zshrc`에 추가:

```bash
export PATH="/path/to/ghee/bin:/path/to/ghee/tools:$PATH"
source "/path/to/ghee/ghee-functions.sh"
for _gg_mod in "/path/to/ghee/modules"/*.sh; do
    source "$_gg_mod"
done
```

### 설치 프로그램이 하는 일

- 셸(bash 또는 zsh)을 감지하고 RC 파일 백업
- 인터랙티브 TUI를 위해 `rich`와 함께 Python 가상환경(`ghee-venv`) 생성
- `bin/`과 `tools/`를 `$PATH`에 내보냄
- `modules/*.sh`에서 29개 모듈을 셸에 로드

### 제거

```bash
./setup-ghee --remove && source ~/.zshrc
```

---

## 🎮 G 명령 사용

```bash
G                            # 인터랙티브 퍼지 파인더 — 538개 명령 검색
G 'docker logs'              # 최적 매칭, 클립보드로 복사
G -a 'npm run dev' '개발 서버 시작'  # 사용자 지정 단축키 추가 (저장됨)
G -rm myalias                # 사용자 지정 단축키 제거
```

인터랙티브 모드: **화살표** 탐색 · **Enter** 선택 · **Tab** 복사 · **Esc** 종료.

---

## 📦 프로젝트 구조

```
ghee/
├── setup-ghee              # 설치 / 제거 프로그램
├── ghee-functions.sh       # 코어 초기화: 색상, G() 래퍼, 레지스트리 선언
├── ghee.py                 # Python TUI (Rich 기반 퍼지 검색 CLI)
├── modules/                # 29개 bash 모듈, 셸 시작 시 자동 로드
│   ├── git_workflow.sh       # 고급 git 함수 (gwip, presto, gtag...)
│   ├── git_aliases.sh        # 90개 이상 표준 git 별칭 (gs, gco, glog...)
│   ├── docker.sh             # Docker & Compose
│   ├── kubernetes.sh         # kubectl 단축키
│   ├── aws_cli.sh            # AWS CLI
│   ├── gcp_gcloud.sh         # GCP gcloud
│   ├── terraform.sh          # Terraform
│   ├── cloud_deploy.sh       # Heroku, Vercel, Fly.io, Railway
│   ├── github_cli.sh         # gh CLI (PR, 이슈, 릴리스)
│   ├── npm_yarn_pnpm.sh      # JS 패키지 관리자
│   ├── python_pip_venv.sh    # Python / pip / venv / pytest
│   ├── rust_go.sh            # Cargo + Go 도구
│   ├── redis.sh              # Redis CLI
│   ├── postgresql.sh         # psql 단축키
│   ├── mongodb.sh            # MongoDB CLI
│   ├── nginx.sh              # Nginx 관리
│   ├── systemd_services.sh   # systemctl / journalctl
│   ├── networking.sh         # curl, dig, DNS, 속도
│   ├── cybersecurity_network_recon.sh  # nmap, tcpdump, ssl, ncat
│   ├── ai_llm.sh             # Ollama, OpenAI API
│   ├── media_tools.sh        # ffmpeg, yt-dlp, imagemagick
│   ├── data_tools.sh         # jq, YAML, CSV 처리
│   ├── macos_power_tools.sh  # macOS 전용 도구
│   ├── super_utilities.sh    # cheat, weather, UUID, timer
│   ├── tmux.sh               # tmux 세션 관리
│   └── shell_file_utilities.sh  # history, extract, ports, swap...
├── bin/                    # 독립 bash 스크립트 (PATH에 추가)
└── tools/                  # Python 스크립트 (PATH에 추가)
```

---

## 📖 명령 참조

> **참고:** 별칭과 명령은 기술적 일관성을 위해 영어로 유지됩니다. 설명은 한국어로 번역되었습니다.

### Ai Llm

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `ollama` | `ollama run MODEL` | Ollama로 로컬 LLM 모델 실행 |
| `ollmls` | `ollama list` | 로컬에 다운로드된 Ollama 모델 목록 |
| `ollpull` | `ollama pull MODEL` | Ollama 모델 다운로드 |
| `ollamaserv` | `ollama serve` | 포트 11434에서 Ollama API 서버 시작 |
| `llmchat` | `curl localhost:11434/api/generate with JSON` | curl로 로컬 Ollama 모델과 채팅 |
| `tokcount` | `python3 -c tiktoken count tokens` | 문자열에서 토큰 수 세기 (tiktoken 필요) |
| `openai` | `curl api.openai.com/v1/chat/completions` | curl로 OpenAI API에 프롬프트 전송 |

### Docker

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `dps` | `docker ps` | 실행 중인 컨테이너 목록 |
| `dpsa` | `docker ps -a` | 모든 컨테이너 목록 |
| `di` | `docker images` | 이미지 목록 |
| `drm` | `docker rm` | 컨테이너 제거 |
| `drmi` | `docker rmi` | 이미지 제거 |
| `drmf` | `docker rm -f \$(docker ps -aq)` | 모든 컨테이너 강제 제거 |
| `drmia` | `docker rmi \$(docker images -q)` | 모든 이미지 제거 |
| `dex` | `docker exec -it CONTAINER bash` | 컨테이너에서 실행 |
| `dl` | `docker logs -f CONTAINER` | 컨테이너 로그 따라보기 |
| `dstop` | `docker stop \$(docker ps -aq)` | 모든 컨테이너 중지 |
| `dprune` | `docker system prune -af` | 모든 것 정리 (컨테이너, 이미지, 네트워크) |
| `dc` | `docker compose` | Docker Compose 단축키 |
| `dcu` | `docker compose up -d` | Compose 시작 (백그라운드) |
| `dcd` | `docker compose down` | Compose 중지 |
| `dcb` | `docker compose build` | Compose 빌드 |
| `dcl` | `docker compose logs -f` | Compose 로그 따라보기 |
| `dcr` | `docker compose restart` | Compose 서비스 재시작 |
| `dvls` | `docker volume ls` | 볼륨 목록 |
| `dnls` | `docker network ls` | 네트워크 목록 |
| `dbuild` | `docker build -t NAME .` | Dockerfile에서 이미지 빌드 |

### Kubernetes

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `k` | `kubectl` | kubectl 단축키 |
| `kgp` | `kubectl get pods` | Pod 목록 |
| `kgpa` | `kubectl get pods --all-namespaces` | 모든 네임스페이스의 Pod |
| `kgs` | `kubectl get svc` | 서비스 목록 |
| `kgn` | `kubectl get nodes` | 노드 목록 |
| `kgd` | `kubectl get deployments` | 디플로이먼트 목록 |
| `kgi` | `kubectl get ingress` | 인그레스 목록 |
| `kgns` | `kubectl get namespaces` | 네임스페이스 목록 |
| `kga` | `kubectl get all` | 모든 리소스 목록 |
| `kdp` | `kubectl describe pod POD` | Pod 설명 |
| `kds` | `kubectl describe svc SVC` | 서비스 설명 |
| `kdd` | `kubectl describe deployment DEP` | 디플로이먼트 설명 |
| `kl` | `kubectl logs -f POD` | Pod 로그 따라보기 |
| `klp` | `kubectl logs -f POD -p` | 이전 Pod 로그 |
| `kex` | `kubectl exec -it POD -- bash` | Pod에서 실행 |
| `kaf` | `kubectl apply -f FILE` | 매니페스트 적용 |
| `kdf` | `kubectl delete -f FILE` | 매니페스트에서 삭제 |
| `kctx` | `kubectl config get-contexts` | kube 컨텍스트 표시 |
| `kuse` | `kubectl config use-context CTX` | kube 컨텍스트 전환 |
| `kns` | `kubectl config set-context --current --namespace=NS` | 기본 네임스페이스 설정 |
| `kpf` | `kubectl port-forward POD LOCAL:REMOTE` | Pod에 포트 포워딩 |
| `kscale` | `kubectl scale deployment DEP --replicas=N` | 디플로이먼트 스케일 |
| `krollout` | `kubectl rollout status deployment DEP` | 롤아웃 상태 확인 |
| `krestart` | `kubectl rollout restart deployment DEP` | 디플로이먼트 재시작 |
| `ktop` | `kubectl top pods` | Pod 리소스 사용량 |
| `ktopn` | `kubectl top nodes` | 노드 리소스 사용량 |

### Git Aliases

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `gs` | `git status` | 작업 트리 상태 표시 |
| `gss` | `git status -s` | 짧은 형식 상태 |
| `ga` | `git add .` | 모든 변경 스테이징 |
| `gaf` | `git add FILE` | 특정 파일 스테이징 |
| `gc` | `git commit -m MSG` | 메시지 포함 커밋 |
| `gca` | `git commit -a -m MSG` | 모든 추적 파일 커밋 |
| `gcam` | `git commit --amend -m MSG` | 마지막 커밋 메시지 수정 |
| `gcan` | `git commit --amend --no-edit` | 마지막 커밋 수정, 메시지 유지 |
| `gp` | `git push` | origin에 푸시 |
| `gpf` | `git push --force` | 강제 푸시 |
| `gpfl` | `git push --force-with-lease` | 강제 푸시 (더 안전) |
| `gpu` | `git push -u origin BRANCH` | 푸시 및 업스트림 설정 |
| `gl` | `git pull` | origin에서 풀 |
| `glr` | `git pull --rebase` | 리베이스와 함께 풀 |
| `glp` | `git pull --prune` | 풀 및 죽은 참조 정리 |
| `gb` | `git branch` | 로컬 브랜치 목록 |
| `gba` | `git branch -a` | 모든 브랜치 목록 (로컬+원격) |
| `gbd` | `git branch -d BRANCH` | 브랜치 삭제 |
| `gbdf` | `git branch -D BRANCH` | 브랜치 강제 삭제 |
| `gco` | `git checkout BRANCH` | 브랜치 체크아웃 |
| `gcob` | `git checkout -b BRANCH` | 새 브랜치 생성 + 체크아웃 |
| `gcop` | `git checkout -` | 이전 브랜치 체크아웃 |
| `gcom` | `git checkout main \|\| git checkout master` | main/master 체크아웃 |
| `gsw` | `git switch BRANCH` | 브랜치 전환 (최신) |
| `gswc` | `git switch -c BRANCH` | 새 브랜치 생성 + 전환 |
| `gm` | `git merge BRANCH` | 브랜치 병합 |
| `gmnf` | `git merge --no-ff BRANCH` | 비패스트포워드 병합 |
| `gma` | `git merge --abort` | 병합 중단 |
| `gbm` | `git branch --merged` | 병합된 브랜치 표시 |
| `glog` | `git log --oneline --decorate --graph` | 예쁜 커밋 그래프 |
| `gloga` | `git log --oneline --decorate --graph --all` | 예쁜 그래프, 모든 브랜치 |
| `glogd` | `git log --pretty=format:'%h %ad %s' --date=short` | 날짜 포함 로그 |
| `glogs` | `git log --stat` | 파일 통계 포함 로그 |
| `glogp` | `git log -p` | 패치 포함 로그 |
| `glast` | `git log -1 HEAD` | 마지막 커밋 표시 |
| `gblame` | `git blame FILE` | 각 줄을 누가 변경했는지 표시 |
| `gshow` | `git show` | 마지막 커밋 상세 |
| `gauthor` | `git log --author NAME` | 작성자별 로그 필터 |
| `gsearch` | `git log --all --grep TERM` | 커밋 메시지 검색 |
| `gbv` | `git branch -v` | 마지막 커밋 포함 브랜치 |
| `gbvv` | `git branch -vv` | 추적 정보 포함 브랜치 |
| `grl` | `git reflog` | reflog 표시 |
| `gd` | `git diff` | 스테이징되지 않은 차이 표시 |
| `gds` | `git diff --staged` | 스테이징된 차이 표시 |
| `gdst` | `git diff --stat` | 통계 포함 차이 |
| `gdw` | `git diff --word-diff` | 단어 단위 차이 |
| `gdc` | `git diff --color-words` | 컬러 단어 차이 |
| `gdfiles` | `git diff --name-only` | 변경된 파일명 목록 |
| `gdstat` | `git diff --name-status` | 상태 포함 변경 파일 |
| `gdlc` | `git diff HEAD^ HEAD` | 마지막 커밋 차이 |
| `gls` | `git ls-files` | 추적 파일 목록 |
| `glsu` | `git ls-files --others` | 추적되지 않은 파일 목록 |
| `gcontrib` | `git shortlog -sn` | 기여자 표시 |
| `gfh` | `git log --follow -p -- FILE` | 파일 전체 이력 표시 |
| `gst` | `git stash` | 변경 임시 저장 |
| `gstm` | `git stash push -m MSG` | 메시지 포함 임시 저장 |
| `gstu` | `git stash -u` | 추적되지 않은 파일 포함 임시 저장 |
| `gsta` | `git stash -a` | 모두 임시 저장 (무시된 파일 포함) |
| `gstl` | `git stash list` | 임시 저장 목록 |
| `gsts` | `git stash show -p` | 임시 저장 내용 표시 |
| `gstap` | `git stash apply` | 마지막 임시 저장 적용 |
| `gstpo` | `git stash pop` | 마지막 임시 저장 팝 |
| `gstd` | `git stash drop` | 임시 저장 삭제 |
| `gstc` | `git stash clear` | 모든 임시 저장 지우기 |
| `gr` | `git remote` | 원격 저장소 표시 |
| `grv` | `git remote -v` | URL 포함 원격 저장소 |
| `gra` | `git remote add NAME URL` | 원격 저장소 추가 |
| `grr` | `git remote remove NAME` | 원격 저장소 제거 |
| `gf` | `git fetch` | origin에서 페치 |
| `gfa` | `git fetch --all` | 모든 원격 페치 |
| `gfp` | `git fetch --prune` | 정리 포함 페치 |
| `gcl` | `git clone URL` | 저장소 복제 |
| `gcld` | `git clone --depth 1 URL` | 얕은 복제 |
| `grss` | `git reset --soft HEAD~1` | 마지막 커밋 소프트 리셋 |
| `grsm` | `git reset HEAD~1` | 마지막 커밋 믹스드 리셋 |
| `grsh` | `git reset --hard HEAD~1` | 마지막 커밋 하드 리셋 |
| `grso` | `git reset --hard origin/BRANCH` | origin으로 리셋 |
| `gus` | `git reset HEAD` | 모든 파일 스테이징 취소 |
| `gusf` | `git reset HEAD -- FILE` | 특정 파일 스테이징 취소 |
| `gcn` | `git clean -n` | 정리 미리보기 |
| `gcf` | `git clean -f` | 추적되지 않은 파일 정리 |
| `gcfd` | `git clean -fd` | 추적되지 않은 파일 + 디렉터리 정리 |
| `gdis` | `git checkout -- FILE` | 파일 변경 버리기 |
| `gcp` | `git cherry-pick HASH` | 커밋 체리픽 |
| `gcpc` | `git cherry-pick --continue` | 체리픽 계속 |
| `gcpa` | `git cherry-pick --abort` | 체리픽 중단 |
| `grbi` | `git rebase -i HASH` | 인터랙티브 리베이스 |
| `grbc` | `git rebase --continue` | 리베이스 계속 |
| `grba` | `git rebase --abort` | 리베이스 중단 |
| `grbs` | `git rebase --skip` | 리베이스 단계 건너뛰기 |
| `gt` | `git tag` | 태그 표시 |
| `gta` | `git tag -a TAG` | 주석 태그 생성 |
| `gpt` | `git push --tags` | 모든 태그 푸시 |

### Github Cli

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `ghpr` | `gh pr create` | GitHub 풀 리퀘스트 생성 |
| `ghprs` | `gh pr status` | 현재 브랜치의 PR 상태 |
| `ghprl` | `gh pr list` | 열린 풀 리퀘스트 목록 |
| `ghprd` | `gh pr diff` | 현재 PR 차이 |
| `ghprm` | `gh pr merge` | 현재 풀 리퀘스트 병합 |
| `ghprco` | `gh pr checkout NUMBER` | 번호로 풀 리퀘스트 체크아웃 |
| `ghil` | `gh issue list` | 열린 GitHub 이슈 목록 |
| `ghic` | `gh issue create` | 새 GitHub 이슈 생성 |
| `ghiv` | `gh issue view NUMBER` | 특정 이슈 보기 |
| `ghrl` | `gh release list` | GitHub 릴리스 목록 |
| `ghrc` | `gh release create` | 새 GitHub 릴리스 생성 |
| `ghrepo` | `gh repo view --web` | 브라우저에서 현재 저장소 열기 |
| `ghrun` | `gh run list` | 최근 GitHub Actions 워크플로우 |
| `ghrw` | `gh run watch` | GitHub Actions 실시간 시청 |
| `ghssh` | `gh auth refresh -h github.com -s admin:public_key` | GitHub에 SSH 키 추가 |
| `ghclone` | `gh repo clone OWNER/REPO` | gh로 저장소 복제 (자동 SSH) |
| `ghfork` | `gh repo fork --clone` | GitHub 저장소 포크 + 복제 |

### Cybersecurity Network Recon

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `tn` | `telnet HOST` | 호스트에 텔넷 |
| `tnp` | `telnet HOST PORT` | 호스트:포트에 텔넷 |
| `nsa` | `netstat -an` | 모든 연결 |
| `nstcp` | `netstat -tlnp` | 수신 TCP 포트 |
| `nsudp` | `netstat -ulnp` | 수신 UDP 포트 |
| `nsproc` | `netstat -tulnp` | 프로세스 정보 포함 |
| `nsest` | `netstat -an \| grep ESTABLISHED` |確立된 연결 |
| `nquick` | `nmap -F HOST` | 빠른 스캔 (상위 100 포트) |
| `nfull` | `nmap -p- HOST` | 전체 TCP 포트 스캔 |
| `nsvc` | `nmap -sV HOST` | 서비스 버전 감지 |
| `nos` | `sudo nmap -O HOST` | OS 감지 |
| `nagg` | `sudo nmap -A HOST` | 적극적 스캔 |
| `nsyn` | `sudo nmap -sS HOST` | 스텔스 SYN 스캔 |
| `nudp` | `sudo nmap -sU HOST` | UDP 스캔 |
| `nsweep` | `nmap -sn SUBNET` | 호스트 발견 |
| `nvuln` | `nmap --script vuln HOST` | 취약점 스캔 |
| `nports` | `nmap -p PORTS HOST` | 특정 포트 스캔 |
| `nscript` | `nmap -sC HOST` | 기본 스크립트 스캔 |
| `nmapxml` | `nmap -oX output.xml HOST` | XML 출력 |
| `ncl` | `nc -lvp PORT` | Netcat 포트 수신 |
| `ncs` | `nc HOST PORT` | Netcat 호스트 연결 |
| `ncscan` | `nc -zv HOST START-END` | Netcat 포트 스캔 |
| `sslcheck` | `openssl s_client + x509 DOMAIN` | SSL 인증서 정보 |
| `sslchain` | `openssl s_client -showcerts DOMAIN` | 전체 SSL 체인 |
| `sslciphers` | `nmap ssl-enum-ciphers -p 443 DOMAIN` | SSL 암호 목록 |
| `bannergrab` | `nc -w 3 HOST PORT` | Netcat 배너 획득 |
| `myports` | `lsof -i -P -n \| grep LISTEN` | 열린 포트 |
| `arptable` | `arp -a` | ARP 테이블 |
| `routes` | `netstat -rn / ip route show` | 라우팅 테이블 |
| `fwrules` | `sudo iptables -L / pfctl -sr` | 방화벽 규칙 |
| `sniff` | `sudo tcpdump -i any -nn` | 패킷 캡처 |
| `tcapt` | `sudo tcpdump -w capture.pcap` | 파일에 캡처 |
| `tcport` | `sudo tcpdump port PORT` | 포트 필터 |
| `tchost` | `sudo tcpdump host HOST` | 호스트 필터 |
| `secheaders` | `curl -sI URL \| grep security headers` | HTTP 보안 헤더 |
| `hashpw` | `echo -n PW \| openssl dgst -sha512` | 비밀번호 해시 |
| `genpw` | `tr -dc A-Za-z0-9... < /dev/urandom` | 랜덤 비밀번호 |
| `worldwrite` | `find / -perm -0002` | 전체 쓰기 가능 파일 |
| `findsuid` | `find / -perm -4000` | SUID 바이너리 |
| `whoson` | `who -a / w` | 로그인 사용자 |
| `b64e` | `echo -n STR \| base64` | Base64 인코딩 |
| `b64d` | `echo -n STR \| base64 --decode` | Base64 디코딩 |
| `jwtdecode` | `jq -R 'split(\".\") \| .[0],.[1] \| @base64d \| fromjson'` | JWT 디코딩 |
| `shodanip` | `curl -s https://internetdb.shodan.io/IP` | Shodan IP 조회 |
| `sshkey` | `ssh-keygen -t ed25519 -C EMAIL` | 최신 보안 SSH 키 |

### Data Tools

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `jqpp` | `cat file.json \| jq .` | JSON 예쁘게 출력 |
| `jqkeys` | `jq 'keys'` | JSON 상위 키 |
| `jqlen` | `jq 'length'` | JSON 길이 |
| `jqm` | `jq 'map(.FIELD)'` | JSON 필드 매핑 |
| `jqsel` | `jq '.[] \| select(.key==val)'` | JSON 필드 필터 |
| `yamlcheck` | `python3 -c yaml.safe_load` | YAML 유효성 검사 |
| `yaml2json` | `python3 yaml to json` | YAML → JSON |
| `json2yaml` | `python3 json to yaml` | JSON → YAML |
| `csvhead` | `head -1 FILE.csv \| tr ',' '\n'` | CSV 헤더 |
| `csvcol` | `cut -d, -f N FILE.csv` | CSV 열 추출 |
| `sortjson` | `jq 'sort_by(.KEY)'` | JSON 정렬 |

### Cloud Deploy

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `vdeploy` | `vercel --prod` | Vercel 프로덕션 배포 |
| `vdev` | `vercel dev` | Vercel 로컬 개발 |
| `venv` | `vercel env pull .env.local` | Vercel 환경 변수 풀 |
| `hdeploy` | `git push heroku main` | Heroku 배포 |
| `hlogs` | `heroku logs --tail` | Heroku 로그 |
| `hbash` | `heroku run bash` | Heroku 셸 |
| `hrestart` | `heroku restart` | Heroku 재시작 |
| `rdeploy` | `railway up` | Railway 배포 |
| `rlogs` | `railway logs` | Railway 로그 |
| `fldeploy` | `fly deploy` | Fly.io 배포 |
| `fllogs` | `fly logs` | Fly.io 로그 |
| `flssh` | `fly ssh console` | Fly.io SSH |
| `flscale` | `fly scale count N` | Fly.io 스케일 |

### Gcp Gcloud

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `gcpid` | `gcloud config get-value project` | 현재 GCP 프로젝트 |
| `gcpset` | `gcloud config set project PROJECT` | GCP 프로젝트 설정 |
| `gcpls` | `gcloud compute instances list` | GCE 인스턴스 |
| `gcpssh` | `gcloud compute ssh INSTANCE` | GCE SSH |
| `gcpgke` | `gcloud container clusters list` | GKE 클러스터 |
| `gcpgkecreds` | `gcloud container clusters get-credentials CLUSTER` | GKE 자격증명 |
| `gcpbq` | `bq ls` | BigQuery 데이터세트 |
| `gcpgsutil` | `gsutil ls` | GCS 버킷 |
| `gcpcp` | `gsutil cp FILE gs://BUCKET/` | GCS 복사 |
| `gcpsync` | `gsutil -m rsync -r DIR gs://BUCKET/` | GCS 동기화 |
| `gcprun` | `gcloud run services list` | Cloud Run 서비스 |
| `gcpfn` | `gcloud functions list` | Cloud Functions |
| `gcpsql` | `gcloud sql instances list` | Cloud SQL |
| `gcplog` | `gcloud logging read FILTER --limit=50` | GCP 로그 |
| `gcpauth` | `gcloud auth login` | GCP 인증 |

### Git Workflow

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `gg` | `git add . && git commit -m MSG && git push` | 한 번에 추가, 커밋, 푸시 |
| `gclo` | `git clone https://github.com/USER/REPO` | GitHub 복제 |
| `jclo` | `git clone https://github.com/juleshenry/REPO` | juleshenry 복제 |
| `presto` | `git checkout --orphan && force-push` | 파괴적: 전체 이력 삭제 |
| `gwip` | `git add . && git commit -m 'wip: TIME'` | 빠른 작업 커밋 (푸시 없음) |
| `gunwip` | `git reset --soft HEAD~1` | WIP 커밋 취소 |
| `gpristine` | `git reset --hard origin/BRANCH && git clean -fd` | 원격과 완전히 일치 |
| `gtag` | `git tag -a TAG -m MSG && git push origin TAG` | 태그 생성 + 푸시 |
| `gpr` | `gh pr create --title TITLE --fill` | gh로 PR 생성 |
| `gdiff-fancy` | `git diff --stat + git diff --shortstat` | 예쁜 차이 요약 |
| `gacp` | `git add . && git commit -m MSG && git push` | 추가, 커밋, 푸시 (gg와 동일) |
| `ginit` | `git init && git add . && git commit -m 'Initial commit'` | 저장소 초기화 |
| `ghcl` | `git clone https://github.com/USER/REPO` | GitHub에서 복제 |
| `gbc` | `git checkout -b BRANCH` | 브랜치 생성 + 전환 |
| `gbdall` | `git branch -d B && git push origin --delete B` | 로컬 + 원격 삭제 |
| `gundo` | `git reset --soft HEAD~1` | 커밋 취소 |
| `gbs` | `git for-each-ref --sort=-committerdate` | 최근 수정 기준 브랜치 |
| `gquick` | `git add . && git commit -m 'Quick update: TIME' && git push` | 자동 타임스탬프 커밋 |
| `gchanged` | `git diff --name-only HEAD~N..HEAD` | 변경된 파일 |
| `gsearchtext` | `git log -S TEXT` | 텍스트 검색 |
| `gnew` | `git fetch origin && git checkout -b B origin/main` | origin/main에서 브랜치 |
| `gupdateall` | `git fetch --all && git pull` | 전체 페치 + 풀 |
| `greposize` | `git count-objects -vH` | 저장소 크기 |
| `gfilesize` | `git ls-tree -r -t -l --full-name HEAD \| sort` | 파일 크기 |
| `glarge` | `git rev-list --objects --all \| ...` | 가장 큰 blob |
| `gsyncfork` | `git fetch upstream && merge upstream/main` | 포크 동기화 |
| `gsquash` | `git reset --soft HEAD~N && git commit -m MSG` | N개 커밋 스쿼시 |
| `gstats` | `git shortlog -sn --all --no-merges` | 커밋 수 |
| `garchive` | `git tag archive/B && delete branch` | 브랜치 태그로 보관 |
| `galias` | `alias \| grep '^g'` | 모든 g 별칭 |
| `ginfo` | `repo name, branch, remote, last commit` | 저장소 정보 |
| `gbackup` | `tar -czf backup.tar.gz .` | 백업 |

### Macos Power Tools

| 별칭 | 실행 | 설명 |
|-------|------|-------------|
| `caffeinate` | `caffeinate -d` | Mac 절전 방지 |
| `hidefiles` | `defaults write com.apple.finder ... [잘림]
