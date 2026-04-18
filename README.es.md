# 🧈 ghee

![Licencia](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

> *Como la mantequilla clarificada india — pura, rica, y lo hace todo mejor.*

**ghee** es una colección de **538+ atajos de shell** para desarrolladores, ingenieros de devops y usuarios avanzados. Se integra suavemente sobre tu shell existente, haciendo tu CLI crujiente y rápida — igual que la cosa real.

Cubre: Git, Docker, Kubernetes, AWS, GCP, Terraform, Heroku, Vercel, Fly.io, Railway, GitHub CLI, npm/yarn/pnpm, Python/pip, Rust, Go, Redis, PostgreSQL, MongoDB, Nginx, systemd, tmux, redes, ciberseguridad/reconocimiento, herramientas de IA/LLM, multimedia (ffmpeg/yt-dlp), JSON/YAML/CSV, herramientas avanzadas de macOS, y más.

---

## 📑 Tabla de Contenidos

- [✨ Características](#-características)
- [✅ Requisitos Previos](#-requisitos-previos)
- [🚀 Instalación](#-instalación)
- [🎮 Usando el Comando G](#-usando-el-comando-g)
- [📦 Estructura del Proyecto](#-estructura-del-proyecto)
- [📖 Referencia de Comandos](#-referencia-de-comandos)
- [🛠️ Agregando Atajos Personalizados](#️-agregando-atajos-personalizados)
- [🤝 Contribuyendo](#-contribuyendo)
- [🎨 ¿Por qué "ghee"?](#-por-qué-ghee)
- [📄 Licencia](#-licencia)

---

## ✨ Características

- 🔍 **`G`** — TUI interactiva en Python para búsqueda difusa de los 538+ comandos con vista previa en vivo
- ⚡ **`G 'docker logs'`** — Mejor suposición de cualquier comando de shell, copia coincidencias al portapapeles
- ➕ **`G -a <alias> <command>`** — Agrega tu propio atajo personalizado, persiste en `~/.ghee-custom`
- ➖ **`G -rm <alias>`** — Elimina un atajo personalizado
- 📦 **Modular** — 29 módulos basados en temas, auto-cargados en tu shell
- 🐍 **Impulsado por Python** — Hermosa TUI con Rich, coincidencia difusa y formato a color
- 🔌 **Plug-and-play** — `./setup-ghee` configura todo en menos de 30 segundos

---

## ✅ Requisitos Previos

- **SO:** macOS o Linux
- **Shell:** `bash` o `zsh`
- **Python:** `python3` (3.8 o superior recomendado)
- **Git:** Requerido para clonar el repositorio

---

## 🚀 Instalación

### Configuración Rápida

```bash
git clone https://github.com/juleshenry/ghee.git
cd ghee
chmod +x setup-ghee
./setup-ghee
source ~/.zshrc   # o source ~/.bashrc
```

### Configuración Manual

Agrega este bloque a tu `~/.bashrc` o `~/.zshrc`:

```bash
export PATH="/path/to/ghee/bin:/path/to/ghee/tools:$PATH"
source "/path/to/ghee/ghee-functions.sh"
for _gg_mod in "/path/to/ghee/modules"/*.sh; do
    source "$_gg_mod"
done
```

### Qué Hace el Instalador

- Detecta tu shell (bash o zsh) y crea una copia de seguridad de tu archivo RC
- Crea un virtualenv de Python (`ghee-venv`) con `rich` para la TUI interactiva
- Exporta `bin/` y `tools/` a tu `$PATH`
- Carga los 29 módulos desde `modules/*.sh` en tu shell

### Desinstalar

```bash
./setup-ghee --remove && source ~/.zshrc
```

---

## 🎮 Usando el Comando G

```bash
G                            # Buscador difuso interactivo — busca los 538+ comandos
G 'docker logs'              # Mejor suposición, copia la mejor coincidencia al portapapeles
G -a 'npm run dev' 'Iniciar servidor de desarrollo'  # Agrega un atajo personalizado (persiste)
G -rm myalias                # Elimina un atajo personalizado
```

En modo interactivo: **flechas** para navegar · **Enter** para seleccionar · **Tab** para copiar · **Esc** para salir.

---

## 📦 Estructura del Proyecto

```
ghee/
├── setup-ghee              # Instalador / desinstalador
├── ghee-functions.sh       # Núcleo: colores, envoltorio G(), declaración de registro
├── ghee.py                 # TUI Python (CLI de búsqueda difusa con Rich)
├── modules/                # 29 módulos bash, auto-cargados al iniciar shell
│   ├── git_workflow.sh       # Funciones git avanzadas (gwip, presto, gtag...)
│   ├── git_aliases.sh        # 90+ alias git estándar (gs, gco, glog...)
│   ├── docker.sh             # Docker & Compose
│   ├── kubernetes.sh         # Atajos kubectl
│   ├── aws_cli.sh            # AWS CLI
│   ├── gcp_gcloud.sh         # GCP gcloud
│   ├── terraform.sh          # Terraform
│   ├── cloud_deploy.sh       # Heroku, Vercel, Fly.io, Railway
│   ├── github_cli.sh         # gh CLI (PRs, issues, releases)
│   ├── npm_yarn_pnpm.sh      # Gestores de paquetes JS
│   ├── python_pip_venv.sh    # Python / pip / venv / pytest
│   ├── rust_go.sh            # Cargo + Go tools
│   ├── redis.sh              # Redis CLI
│   ├── postgresql.sh         # Atajos psql
│   ├── mongodb.sh            # MongoDB CLI
│   ├── nginx.sh              # Gestión Nginx
│   ├── systemd_services.sh   # systemctl / journalctl
│   ├── networking.sh         # curl, dig, DNS, velocidad
│   ├── cybersecurity_network_recon.sh  # nmap, tcpdump, ssl, ncat
│   ├── ai_llm.sh             # Ollama, OpenAI API
│   ├── media_tools.sh        # ffmpeg, yt-dlp, imagemagick
│   ├── data_tools.sh         # jq, YAML, CSV processing
│   ├── macos_power_tools.sh  # Utilidades específicas de macOS
│   ├── super_utilities.sh    # cheat, weather, UUID, timer
│   ├── tmux.sh               # Gestión de sesiones tmux
│   └── shell_file_utilities.sh  # history, extract, ports, swap...
├── bin/                    # Scripts bash independientes (agregados a PATH)
└── tools/                  # Scripts Python (agregados a PATH)
```

---

## 📖 Referencia de Comandos

> **Nota:** Los alias y comandos se mantienen en inglés para consistencia técnica. Las descripciones están en español.

### Ai Llm

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `ollama` | `ollama run MODEL` | Ejecutar un modelo LLM local vía Ollama |
| `ollmls` | `ollama list` | Listar modelos Ollama descargados localmente |
| `ollpull` | `ollama pull MODEL` | Descargar un modelo Ollama |
| `ollamaserv` | `ollama serve` | Iniciar servidor API Ollama en puerto 11434 |
| `llmchat` | `curl localhost:11434/api/generate with JSON` | Chatear con modelo Ollama local vía curl |
| `tokcount` | `python3 -c tiktoken count tokens` | Contar tokens en un string (requiere tiktoken) |
| `openai` | `curl api.openai.com/v1/chat/completions` | Enviar un prompt a OpenAI API vía curl |

### Aws Cli

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `awsid` | `aws sts get-caller-identity` | Mostrar identidad AWS actual |
| `awsls` | `aws s3 ls` | Listar buckets S3 |
| `awscp` | `aws s3 cp FILE s3://BUCKET/` | Copiar archivo a S3 |
| `awssync` | `aws s3 sync DIR s3://BUCKET/` | Sincronizar directorio a S3 |
| `awsec2` | `aws ec2 describe-instances` | Listar instancias EC2 |
| `awsecr` | `aws ecr get-login-password \| docker login` | Login ECR docker |
| `awslam` | `aws lambda list-functions` | Listar funciones Lambda |
| `awslog` | `aws logs tail LOG_GROUP --follow` | Seguir logs CloudWatch |
| `awseb` | `aws elasticbeanstalk describe-environments` | Listar entornos EB |
| `awscf` | `aws cloudformation list-stacks` | Listar stacks CloudFormation |
| `awseks` | `aws eks list-clusters` | Listar clusters EKS |
| `awsrds` | `aws rds describe-db-instances` | Listar instancias RDS |
| `awsssm` | `aws ssm start-session --target INSTANCE` | Sesión SSM a instancia |
| `awswho` | `aws iam get-user` | Mostrar usuario IAM actual |
| `awsregions` | `aws ec2 describe-regions --output table` | Listar todas las regiones AWS |

### Docker

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `dps` | `docker ps` | Listar contenedores en ejecución |
| `dpsa` | `docker ps -a` | Listar todos los contenedores |
| `di` | `docker images` | Listar imágenes |
| `drm` | `docker rm` | Eliminar un contenedor |
| `drmi` | `docker rmi` | Eliminar una imagen |
| `drmf` | `docker rm -f \$(docker ps -aq)` | Forzar eliminación de todos los contenedores |
| `drmia` | `docker rmi \$(docker images -q)` | Eliminar todas las imágenes |
| `dex` | `docker exec -it CONTAINER bash` | Ejecutar bash en contenedor |
| `dl` | `docker logs -f CONTAINER` | Seguir logs del contenedor |
| `dstop` | `docker stop \$(docker ps -aq)` | Detener todos los contenedores |
| `dprune` | `docker system prune -af` | Limpiar todo (contenedores, imágenes, redes) |
| `dc` | `docker compose` | Atajo Docker Compose |
| `dcu` | `docker compose up -d` | Compose up (desacoplado) |
| `dcd` | `docker compose down` | Compose down |
| `dcb` | `docker compose build` | Compose build |
| `dcl` | `docker compose logs -f` | Seguir logs compose |
| `dcr` | `docker compose restart` | Reiniciar servicios compose |
| `dvls` | `docker volume ls` | Listar volúmenes |
| `dnls` | `docker network ls` | Listar redes |
| `dbuild` | `docker build -t NAME .` | Construir imagen desde Dockerfile |

### Kubernetes

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `k` | `kubectl` | Atajo kubectl |
| `kgp` | `kubectl get pods` | Listar pods |
| `kgpa` | `kubectl get pods --all-namespaces` | Listar todos los pods en todos los namespaces |
| `kgs` | `kubectl get svc` | Listar servicios |
| `kgn` | `kubectl get nodes` | Listar nodos |
| `kgd` | `kubectl get deployments` | Listar deployments |
| `kgi` | `kubectl get ingress` | Listar ingresses |
| `kgns` | `kubectl get namespaces` | Listar namespaces |
| `kga` | `kubectl get all` | Listar todos los recursos |
| `kdp` | `kubectl describe pod POD` | Describir un pod |
| `kds` | `kubectl describe svc SVC` | Describir un servicio |
| `kdd` | `kubectl describe deployment DEP` | Describir un deployment |
| `kl` | `kubectl logs -f POD` | Seguir logs del pod |
| `klp` | `kubectl logs -f POD -p` | Logs anteriores del pod |
| `kex` | `kubectl exec -it POD -- bash` | Ejecutar bash en un pod |
| `kaf` | `kubectl apply -f FILE` | Aplicar un manifiesto |
| `kdf` | `kubectl delete -f FILE` | Eliminar desde manifiesto |
| `kctx` | `kubectl config get-contexts` | Mostrar contextos kube |
| `kuse` | `kubectl config use-context CTX` | Cambiar contexto kube |
| `kns` | `kubectl config set-context --current --namespace=NS` | Establecer namespace por defecto |
| `kpf` | `kubectl port-forward POD LOCAL:REMOTE` | Port-forward a un pod |
| `kscale` | `kubectl scale deployment DEP --replicas=N` | Escalar un deployment |
| `krollout` | `kubectl rollout status deployment DEP` | Verificar estado de rollout |
| `krestart` | `kubectl rollout restart deployment DEP` | Reiniciar un deployment |
| `ktop` | `kubectl top pods` | Uso de recursos de pods |
| `ktopn` | `kubectl top nodes` | Uso de recursos de nodos |

### Git Aliases

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `gs` | `git status` | Mostrar estado del árbol de trabajo |
| `gss` | `git status -s` | Estado en formato corto |
| `ga` | `git add .` | Preparar todos los cambios |
| `gaf` | `git add FILE` | Preparar un archivo específico |
| `gc` | `git commit -m MSG` | Confirmar con mensaje |
| `gca` | `git commit -a -m MSG` | Confirmar todos los cambios rastreados |
| `gcam` | `git commit --amend -m MSG` | Enmendar último mensaje de confirmación |
| `gcan` | `git commit --amend --no-edit` | Enmendar última confirmación, mantener mensaje |
| `gp` | `git push` | Empujar a origin |
| `gpf` | `git push --force` | Forzar empuje |
| `gpfl` | `git push --force-with-lease` | Forzar empuje (más seguro) |
| `gpu` | `git push -u origin BRANCH` | Empujar y establecer upstream |
| `gl` | `git pull` | Tirar desde origin |
| `glr` | `git pull --rebase` | Tirar con rebase |
| `glp` | `git pull --prune` | Tirar y podar refs muertos |
| `gb` | `git branch` | Listar ramas locales |
| `gba` | `git branch -a` | Listar todas las ramas (locales+remotas) |
| `gbd` | `git branch -d BRANCH` | Eliminar una rama |
| `gbdf` | `git branch -D BRANCH` | Forzar eliminación de rama |
| `gco` | `git checkout BRANCH` | Cambiar a una rama |
| `gcob` | `git checkout -b BRANCH` | Crear + cambiar a nueva rama |
| `gcop` | `git checkout -` | Cambiar a rama anterior |
| `gcom` | `git checkout main \|\| git checkout master` | Cambiar a main/master |
| `gsw` | `git switch BRANCH` | Cambiar a rama (moderno) |
| `gswc` | `git switch -c BRANCH` | Crear + cambiar a nueva rama |
| `gm` | `git merge BRANCH` | Fusionar una rama |
| `gmnf` | `git merge --no-ff BRANCH` | Fusionar sin avance rápido |
| `gma` | `git merge --abort` | Abortar una fusión |
| `gbm` | `git branch --merged` | Mostrar ramas fusionadas |
| `glog` | `git log --oneline --decorate --graph` | Gráfico bonito de confirmaciones |
| `gloga` | `git log --oneline --decorate --graph --all` | Gráfico bonito, todas las ramas |
| `glogd` | `git log --pretty=format:'%h %ad %s' --date=short` | Log con fechas |
| `glogs` | `git log --stat` | Log con estadísticas de archivos |
| `glogp` | `git log -p` | Log con parches |
| `glast` | `git log -1 HEAD` | Mostrar última commit |
| `gblame` | `git blame FILE` | Mostrar quién cambió cada línea |
| `gshow` | `git show` | Mostrar detalles del último commit |
| `gauthor` | `git log --author NAME` | Filtrar log por autor |
| `gsearch` | `git log --all --grep TERM` | Buscar mensajes de commit |
| `gbv` | `git branch -v` | Ramas con último commit |
| `gbvv` | `git branch -vv` | Ramas con info de rastreo |
| `grl` | `git reflog` | Mostrar reflog |
| `gd` | `git diff` | Mostrar diff sin preparar |
| `gds` | `git diff --staged` | Mostrar diff preparado |
| `gdst` | `git diff --stat` | Diff con estadísticas |
| `gdw` | `git diff --word-diff` | Diff a nivel de palabra |
| `gdc` | `git diff --color-words` | Diff de palabras en color |
| `gdfiles` | `git diff --name-only` | Listar archivos cambiados |
| `gdstat` | `git diff --name-status` | Archivos cambiados con estado |
| `gdlc` | `git diff HEAD^ HEAD` | Diff del último commit |
| `gls` | `git ls-files` | Listar archivos rastreados |
| `glsu` | `git ls-files --others` | Listar archivos sin rastrear |
| `gcontrib` | `git shortlog -sn` | Mostrar contribuidores |
| `gfh` | `git log --follow -p -- FILE` | Mostrar historial completo de archivo |
| `gst` | `git stash` | Guardar cambios temporalmente |
| `gstm` | `git stash push -m MSG` | Guardar temporalmente con mensaje |
| `gstu` | `git stash -u` | Guardar temporalmente incluyendo sin rastrear |
| `gsta` | `git stash -a` | Guardar temporalmente todo (incluyendo ignorados) |
| `gstl` | `git stash list` | Listar guardados temporales |
| `gsts` | `git stash show -p` | Mostrar contenido guardado temporal |
| `gstap` | `git stash apply` | Aplicar último guardado temporal |
| `gstpo` | `git stash pop` | Extraer último guardado temporal |
| `gstd` | `git stash drop` | Eliminar un guardado temporal |
| `gstc` | `git stash clear` | Limpiar todos los guardados temporales |
| `gr` | `git remote` | Mostrar remotos |
| `grv` | `git remote -v` | Mostrar remotos con URLs |
| `gra` | `git remote add NAME URL` | Agregar un remoto |
| `grr` | `git remote remove NAME` | Eliminar un remoto |
| `gf` | `git fetch` | Obtener desde origin |
| `gfa` | `git fetch --all` | Obtener todos los remotos |
| `gfp` | `git fetch --prune` | Obtener con poda |
| `gcl` | `git clone URL` | Clonar un repositorio |
| `gcld` | `git clone --depth 1 URL` | Clon superficial |
| `grss` | `git reset --soft HEAD~1` | Reset suave del último commit |
| `grsm` | `git reset HEAD~1` | Reset mixto del último commit |
| `grsh` | `git reset --hard HEAD~1` | Reset duro del último commit |
| `grso` | `git reset --hard origin/BRANCH` | Reset a origin |
| `gus` | `git reset HEAD` | Des-preparar todos los archivos |
| `gusf` | `git reset HEAD -- FILE` | Des-preparar un archivo específico |
| `gcn` | `git clean -n` | Simulación de limpieza |
| `gcf` | `git clean -f` | Limpiar archivos sin rastrear |
| `gcfd` | `git clean -fd` | Limpiar archivos sin rastrear + directorios |
| `gdis` | `git checkout -- FILE` | Descartar cambios en archivo |
| `gcp` | `git cherry-pick HASH` | Seleccionar un commit |
| `gcpc` | `git cherry-pick --continue` | Continuar cherry-pick |
| `gcpa` | `git cherry-pick --abort` | Abortar cherry-pick |
| `grbi` | `git rebase -i HASH` | Rebase interactivo |
| `grbc` | `git rebase --continue` | Continuar rebase |
| `grba` | `git rebase --abort` | Abortar rebase |
| `grbs` | `git rebase --skip` | Saltar paso de rebase |
| `gt` | `git tag` | Mostrar etiquetas |
| `gta` | `git tag -a TAG` | Crear etiqueta anotada |
| `gpt` | `git push --tags` | Empujar todas las etiquetas |

### Github Cli

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `ghpr` | `gh pr create` | Crear un pull request de GitHub |
| `ghprs` | `gh pr status` | Mostrar estado de PR para rama actual |
| `ghprl` | `gh pr list` | Listar pull requests abiertos |
| `ghprd` | `gh pr diff` | Mostrar diff de PR actual |
| `ghprm` | `gh pr merge` | Fusionar pull request actual |
| `ghprco` | `gh pr checkout NUMBER` | Extraer pull request por número |
| `ghil` | `gh issue list` | Listar issues abiertos de GitHub |
| `ghic` | `gh issue create` | Crear un nuevo issue de GitHub |
| `ghiv` | `gh issue view NUMBER` | Ver un issue específico |
| `ghrl` | `gh release list` | Listar lanzamientos de GitHub |
| `ghrc` | `gh release create` | Crear un nuevo lanzamiento de GitHub |
| `ghrepo` | `gh repo view --web` | Abrir repositorio actual en navegador |
| `ghrun` | `gh run list` | Listar ejecuciones recientes de GitHub Actions |
| `ghrw` | `gh run watch` | Ver ejecución de GitHub Actions en vivo |
| `ghssh` | `gh auth refresh -h github.com -s admin:public_key` | Agregar clave SSH a GitHub |
| `ghclone` | `gh repo clone OWNER/REPO` | Clonar repositorio usando gh (auto SSH) |
| `ghfork` | `gh repo fork --clone` | Bifurcar y clonar un repositorio de GitHub |

### Cybersecurity Network Recon

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `tn` | `telnet HOST` | Telnet a un host |
| `tnp` | `telnet HOST PORT` | Telnet a host:puerto |
| `nsa` | `netstat -an` | Netstat todas las conexiones |
| `nstcp` | `netstat -tlnp` | Netstat puertos TCP escuchando |
| `nsudp` | `netstat -ulnp` | Netstat puertos UDP escuchando |
| `nsproc` | `netstat -tulnp` | Netstat con info de procesos |
| `nsest` | `netstat -an \| grep ESTABLISHED` | Netstat conexiones establecidas |
| `nquick` | `nmap -F HOST` | Escaneo rápido Nmap (top 100 puertos) |
| `nfull` | `nmap -p- HOST` | Escaneo completo de puertos TCP |
| `nsvc` | `nmap -sV HOST` | Detección de versión de servicio Nmap |
| `nos` | `sudo nmap -O HOST` | Detección de SO Nmap |
| `nagg` | `sudo nmap -A HOST` | Escaneo agresivo Nmap (SO+ver+scripts) |
| `nsyn` | `sudo nmap -sS HOST` | Escaneo sigiloso SYN Nmap |
| `nudp` | `sudo nmap -sU HOST` | Escaneo UDP Nmap |
| `nsweep` | `nmap -sn SUBNET` | Barrido ping Nmap (descubrir hosts) |
| `nvuln` | `nmap --script vuln HOST` | Escaneo de vulnerabilidades Nmap |
| `nports` | `nmap -p PORTS HOST` | Escaneo de puertos específicos Nmap |
| `nscript` | `nmap -sC HOST` | Escaneo Nmap con scripts por defecto |
| `nmapxml` | `nmap -oX output.xml HOST` | Salida XML Nmap para análisis |
| `ncl` | `nc -lvp PORT` | Netcat escuchar en puerto |
| `ncs` | `nc HOST PORT` | Netcat conectar a host:puerto |
| `ncscan` | `nc -zv HOST START-END` | Escaneo de puertos con netcat |
| `sslcheck` | `openssl s_client + x509 DOMAIN` | Verificar info de certificado SSL |
| `sslchain` | `openssl s_client -showcerts DOMAIN` | Mostrar cadena completa de certificados SSL |
| `sslciphers` | `nmap ssl-enum-ciphers -p 443 DOMAIN` | Enumerar cifrados SSL |
| `bannergrab` | `nc -w 3 HOST PORT` | Capturar banner vía netcat |
| `myports` | `lsof -i -P -n \| grep LISTEN` | Mostrar puertos abiertos en este host |
| `arptable` | `arp -a` | Mostrar tabla ARP |
| `routes` | `netstat -rn / ip route show` | Mostrar tabla de enrutamiento |
| `fwrules` | `sudo iptables -L / pfctl -sr` | Mostrar reglas de firewall |
| `sniff` | `sudo tcpdump -i any -nn` | Captura de paquetes (tcpdump) |
| `tcapt` | `sudo tcpdump -w capture.pcap` | Capturar paquetes a archivo |
| `tcport` | `sudo tcpdump port PORT` | tcpdump filtrar por puerto |
| `tchost` | `sudo tcpdump host HOST` | tcpdump filtrar por host |
| `secheaders` | `curl -sI URL \| grep security headers` | Verificar encabezados de seguridad HTTP |
| `hashpw` | `echo -n PW \| openssl dgst -sha512` | Hashear una contraseña (SHA-512) |
| `genpw` | `tr -dc A-Za-z0-9... < /dev/urandom` | Generar contraseña aleatoria |
| `worldwrite` | `find / -perm -0002` | Encontrar archivos con permisos mundiales |
| `findsuid` | `find / -perm -4000` | Encontrar binarios SUID |
| `whoson` | `who -a / w` | Mostrar todos los usuarios conectados |
| `b64e` | `echo -n STR \| base64` | Codificar string en Base64 |
| `b64d` | `echo -n STR \| base64 --decode` | Decodificar string Base64 |
| `jwtdecode` | `jq -R 'split(\".\") \| .[0],.[1] \| @base64d \| fromjson'` | Decodificar token JWT |
| `shodanip` | `curl -s https://internetdb.shodan.io/IP` | Búsqueda rápida Shodan IP |
| `sshkey` | `ssh-keygen -t ed25519 -C EMAIL` | Generar clave SSH segura moderna |

### Data Tools

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `jqpp` | `cat file.json \| jq .` | Imprimir JSON bonito |
| `jqkeys` | `jq 'keys'` | Listar claves JSON de nivel superior |
| `jqlen` | `jq 'length'` | Obtener longitud de array u objeto JSON |
| `jqm` | `jq 'map(.FIELD)'` | Mapear/extraer un campo de array JSON |
| `jqsel` | `jq '.[] \| select(.key==val)'` | Filtrar array JSON por valor de campo |
| `yamlcheck` | `python3 -c yaml.safe_load` | Validar sintaxis de archivo YAML |
| `yaml2json` | `python3 yaml to json` | Convertir archivo YAML a JSON |
| `json2yaml` | `python3 json to yaml` | Convertir archivo JSON a YAML |
| `csvhead` | `head -1 FILE.csv \| tr ',' '\n'` | Mostrar encabezados de CSV |
| `csvcol` | `cut -d, -f N FILE.csv` | Extraer columna N de CSV |
| `sortjson` | `jq 'sort_by(.KEY)'` | Ordenar array JSON por una clave |

### Cloud Deploy

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `vdeploy` | `vercel --prod` | Desplegar a producción Vercel |
| `vdev` | `vercel dev` | Iniciar servidor de desarrollo local Vercel |
| `venv` | `vercel env pull .env.local` | Extraer variables de entorno Vercel a local |
| `hdeploy` | `git push heroku main` | Desplegar a Heroku vía git |
| `hlogs` | `heroku logs --tail` | Seguir logs de app Heroku |
| `hbash` | `heroku run bash` | Abrir shell en dyno Heroku |
| `hrestart` | `heroku restart` | Reiniciar todos los dynos Heroku |
| `rdeploy` | `railway up` | Desplegar a Railway |
| `rlogs` | `railway logs` | Mostrar logs de despliegue Railway |
| `fldeploy` | `fly deploy` | Desplegar a Fly.io |
| `fllogs` | `fly logs` | Mostrar logs Fly.io |
| `flssh` | `fly ssh console` | SSH a máquina Fly.io |
| `flscale` | `fly scale count N` | Escalar conteo de instancias Fly.io |

### Gcp Gcloud

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `gcpid` | `gcloud config get-value project` | Mostrar proyecto GCP actual |
| `gcpset` | `gcloud config set project PROJECT` | Establecer proyecto GCP |
| `gcpls` | `gcloud compute instances list` | Listar instancias GCE |
| `gcpssh` | `gcloud compute ssh INSTANCE` | SSH a instancia GCE |
| `gcpgke` | `gcloud container clusters list` | Listar clusters GKE |
| `gcpgkecreds` | `gcloud container clusters get-credentials CLUSTER` | Obtener credenciales GKE kubeconfig |
| `gcpbq` | `bq ls` | Listar datasets BigQuery |
| `gcpgsutil` | `gsutil ls` | Listar buckets GCS |
| `gcpcp` | `gsutil cp FILE gs://BUCKET/` | Copiar archivo a GCS |
| `gcpsync` | `gsutil -m rsync -r DIR gs://BUCKET/` | Sincronizar directorio a GCS |
| `gcprun` | `gcloud run services list` | Listar servicios Cloud Run |
| `gcpfn` | `gcloud functions list` | Listar Cloud Functions |
| `gcpsql` | `gcloud sql instances list` | Listar instancias Cloud SQL |
| `gcplog` | `gcloud logging read FILTER --limit=50` | Leer logs GCP |
| `gcpauth` | `gcloud auth login` | Autenticar con GCP |

### Git Workflow

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `gg` | `git add . && git commit -m MSG && git push` | Agregar todo, confirmar, empujar en uno |
| `gclo` | `git clone https://github.com/USER/REPO` | Clonar un repositorio GitHub |
| `jclo` | `git clone https://github.com/juleshenry/REPO` | Clonar un repo de juleshenry |
| `presto` | `git checkout --orphan && force-push` | DESTRUCTIVO: borrar todo el historial git |
| `gwip` | `git add . && git commit -m 'wip: TIME'` | Commit rápido de trabajo en progreso (sin push) |
| `gunwip` | `git reset --soft HEAD~1` | Deshacer último commit WIP, mantener cambios preparados |
| `gpristine` | `git reset --hard origin/BRANCH && git clean -fd` | Reset duro para coincidir exactamente con remoto |
| `gtag` | `git tag -a TAG -m MSG && git push origin TAG` | Crear y empujar una etiqueta git |
| `gpr` | `gh pr create --title TITLE --fill` | Crear un PR de GitHub vía gh CLI |
| `gdiff-fancy` | `git diff --stat + git diff --shortstat` | Resumen bonito de diff con estadísticas |
| `gacp` | `git add . && git commit -m MSG && git push` | Agregar, confirmar, empujar (igual que gg) |
| `ginit` | `git init && git add . && git commit -m 'Initial commit'` | Inicializar repo con primer commit |
| `ghcl` | `git clone https://github.com/USER/REPO` | Clonar desde GitHub |
| `gbc` | `git checkout -b BRANCH` | Crear y cambiar a nueva rama |
| `gbdall` | `git branch -d B && git push origin --delete B` | Eliminar rama localmente + remotamente |
| `gundo` | `git reset --soft HEAD~1` | Deshacer último commit, mantener cambios preparados |
| `gbs` | `git for-each-ref --sort=-committerdate` | Mostrar ramas ordenadas por último modificado |
| `gquick` | `git add . && git commit -m 'Quick update: TIME' && git push` | Commit+push con marca de tiempo automática |
| `gchanged` | `git diff --name-only HEAD~N..HEAD` | Mostrar archivos cambiados en últimos N commits |
| `gsearchtext` | `git log -S TEXT` | Buscar texto a través del historial git |
| `gnew` | `git fetch origin && git checkout -b B origin/main` | Crear rama desde origin/main |
| `gupdateall` | `git fetch --all && git pull` | Obtener todos los remotos y tirar |
| `greposize` | `git count-objects -vH` | Mostrar tamaño de almacenamiento de objetos del repo |
| `gfilesize` | `git ls-tree -r -t -l --full-name HEAD \| sort` | Listar archivos por tamaño en repo |
| `glarge` | `git rev-list --objects --all \| ...` | Encontrar N blobs más grandes en historial |
| `gsyncfork` | `git fetch upstream && merge upstream/main` | Sincronizar fork con upstream/main |
| `gsquash` | `git reset --soft HEAD~N && git commit -m MSG` | Aplastar últimos N commits |
| `gstats` | `git shortlog -sn --all --no-merges` | Conteo de commits por autor |
| `garchive` | `git tag archive/B && delete branch` | Archivar una rama como etiqueta |
| `galias` | `alias \| grep '^g'` | Listar todos los alias g* |
| `ginfo` | `repo name, branch, remote, last commit` | Mostrar resumen de info del repo |
| `gbackup` | `tar -czf backup.tar.gz .` | Copia de seguridad tar.gz del repo actual |

### Macos Power Tools

| Alias | Ejecuta | Descripción |
|-------|------|-------------|
| `caffeinate` | `caffeinate -d` | Prevenir que Mac entre en reposo |
| `hidefiles` | `defaults write com.apple.finder ... [truncado]
