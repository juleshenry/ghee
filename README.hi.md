# 🧈 ghee

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

> *भारतीय घी की तरह — शुद्ध, समृद्ध, और सब कुछ बेहतर बनाता है।*

**ghee** डेवलपर्स, DevOps इंजीनियरों और पावर यूज़र्स के लिए **538+ शॉर्टकट** का संग्रह है। यह आपके मौजूदा शेल के ऊपर सहजता से काम करता है, आपके CLI को तेज़ और कुशल बनाता है — बिल्कुल असली घी की तरह।

कवर करता है: Git, Docker, Kubernetes, AWS, GCP, Terraform, Heroku, Vercel, Fly.io, Railway, GitHub CLI, npm/yarn/pnpm, Python/pip, Rust, Go, Redis, PostgreSQL, MongoDB, Nginx, systemd, tmux, नेटवर्किंग, साइबरसिक्योरिटी/रिकॉन, AI/LLM टूल्स, मीडिया (ffmpeg/yt-dlp), JSON/YAML/CSV, macOS पावर टूल्स, और बहुत कुछ।

---

## 📑 विषय सूची

- [✨ विशेषताएं](#-विशेषताएं)
- [✅ आवश्यकताएं](#-आवश्यकताएं)
- [🚀 इंस्टॉलेशन](#-इंस्टॉलेशन)
- [🎮 G कमांड का उपयोग](#-g-कमांड-का-उपयोग)
- [📦 प्रोजेक्ट संरचना](#-प्रोजेक्ट-संरचना)
- [📖 कमांड संदर्भ](#-कमांड-संदर्भ)
- [🛠️ कस्टम शॉर्टकट जोड़ना](#️-कस्टम-शॉर्टकट-जोड़ना)
- [🤝 योगदान](#-योगदान)
- [🎨 "ghee" क्यों?](#-ghee-क्यों)
- [📄 लाइसेंस](#-लाइसेंस)

---

## ✨ विशेषताएं

- 🔍 **`G`** — इंटरएक्टिव Python TUI, 538+ कमांड्स को फज़ी-सर्च करें लाइव पूर्वावलोकन के साथ
- ⚡ **`G 'docker logs'`** — किसी भी शेल कमांड का सबसे अच्छा अनुमान, क्लिपबोर्ड पर कॉपी करें
- ➕ **`G -a <alias> <command>`** — अपना कस्टम शॉर्टकट जोड़ें, `~/.ghee-custom` में सेव होता है
- ➖ **`G -rm <alias>`** — कस्टम शॉर्टकट हटाएं
- 📦 **मॉड्यूलर** — 29 विषय-आधारित मॉड्यूल, आपके शेल में ऑटो-सोर्स किए जाते हैं
- 🐍 **Python-संचालित** — सुंदर Rich TUI फज़ी मैचिंग और कलर फॉर्मेटिंग के साथ
- 🔌 **प्लग-एंड-प्ले** — `./setup-ghee` 30 सेकंड से कम में सब कुछ सेटअप करता है

---

## ✅ आवश्यकताएं

- **OS:** macOS या Linux
- **Shell:** `bash` या `zsh`
- **Python:** `python3` (3.8 या नया संस्करण अनुशंसित)
- **Git:** रिपॉजिटरी क्लोन करने के लिए आवश्यक

---

## 🚀 इंस्टॉलेशन

### त्वरित सेटअप

```bash
git clone https://github.com/juleshenry/ghee.git
cd ghee
chmod +x setup-ghee
./setup-ghee
source ~/.zshrc   # या source ~/.bashrc
```

### मैन्युअल सेटअप

इस ब्लॉक को अपने `~/.bashrc` या `~/.zshrc` में जोड़ें:

```bash
export PATH="/path/to/ghee/bin:/path/to/ghee/tools:$PATH"
source "/path/to/ghee/ghee-functions.sh"
for _gg_mod in "/path/to/ghee/modules"/*.sh; do
    source "$_gg_mod"
done
```

### इंस्टॉलर क्या करता है

- आपके शेल (bash या zsh) का पता लगाता है और RC फ़ाइल का बैकअप लेता है
- इंटरएक्टिव TUI के लिए `rich` के साथ Python वर्चुअलएन (`ghee-venv`) बनाता है
- `bin/` और `tools/` को आपके `$PATH` में एक्सपोर्ट करता है
- `modules/*.sh` से सभी 29 मॉड्यूल को आपके शेल में सोर्स करता है

### अनइंस्टॉल

```bash
./setup-ghee --remove && source ~/.zshrc
```

---

## 🎮 G कमांड का उपयोग

```bash
G                            # इंटरएक्टिव फ़ज़ी फ़ाइंडर — सभी 538+ कमांड्स खोजें
G 'docker logs'              # सबसे अच्छा अनुमान, सर्वोत्तम मैच को क्लिपबोर्ड पर कॉपी करें
G -a 'npm run dev' 'Dev server चालू करें'  # कस्टम शॉर्टकट जोड़ें (स्थायी)
G -rm myalias                # कस्टम शॉर्टकट हटाएं
```

इंटरएक्टिव मोड में: **तीर** नेविगेट करने के लिए · **Enter** चयन के लिए · **Tab** कॉपी के लिए · **Esc** बाहर निकलने के लिए।

---

## 📦 प्रोजेक्ट संरचना

```
ghee/
├── setup-ghee              # इंस्टॉलर / अनइंस्टॉलर
├── ghee-functions.sh       # कोर init: colors, G() रैपर, रजिस्ट्री डिक्लेरेशन
├── ghee.py                 # Python TUI (Rich-संचालित फ़ज़ी सर्च CLI)
├── modules/                # 29 bash मॉड्यूल, शेल स्टार्ट पर ऑटो-सोर्स
│   ├── git_workflow.sh       # एडवांस्ड git फंक्शंस (gwip, presto, gtag...)
│   ├── git_aliases.sh        # 90+ स्टैंडर्ड git एलियास (gs, gco, glog...)
│   ├── docker.sh             # Docker & Compose
│   ├── kubernetes.sh         # kubectl शॉर्टकट
│   ├── aws_cli.sh            # AWS CLI
│   ├── gcp_gcloud.sh         # GCP gcloud
│   ├── terraform.sh          # Terraform
│   ├── cloud_deploy.sh       # Heroku, Vercel, Fly.io, Railway
│   ├── github_cli.sh         # gh CLI (PRs, issues, releases)
│   ├── npm_yarn_pnpm.sh      # JS पैकेज मैनेजर
│   ├── python_pip_venv.sh    # Python / pip / venv / pytest
│   ├── rust_go.sh            # Cargo + Go टूल्स
│   ├── redis.sh              # Redis CLI
│   ├── postgresql.sh         # psql शॉर्टकट
│   ├── mongodb.sh            # MongoDB CLI
│   ├── nginx.sh              # Nginx मैनेजमेंट
│   ├── systemd_services.sh   # systemctl / journalctl
│   ├── networking.sh         # curl, dig, DNS, स्पीड
│   ├── cybersecurity_network_recon.sh  # nmap, tcpdump, ssl, ncat
│   ├── ai_llm.sh             # Ollama, OpenAI API
│   ├── media_tools.sh        # ffmpeg, yt-dlp, imagemagick
│   ├── data_tools.sh         # jq, YAML, CSV प्रोसेसिंग
│   ├── macos_power_tools.sh  # macOS-विशिष्ट यूटिलिटीज़
│   ├── super_utilities.sh    # cheat, weather, UUID, timer
│   ├── tmux.sh               # tmux सेशन मैनेजमेंट
│   └── shell_file_utilities.sh  # history, extract, ports, swap...
├── bin/                    # स्टैंडअलोन bash स्क्रिप्ट (PATH में जोड़ा गया)
└── tools/                  # Python स्क्रिप्ट (PATH में जोड़ा गया)
```

---

## 📖 कमांड संदर्भ

> **नोट:** एलियास और कमांड तकनीकी स्थिरता के लिए अंग्रेज़ी में रखे गए हैं। विवरण हिंदी में अनुवादित हैं।

### Ai Llm

| एलियास | रन | विवरण |
|-------|------|-------------|
| `ollama` | `ollama run MODEL` | Ollama के माध्यम से लोकल LLM मॉडल चलाएं |
| `ollmls` | `ollama list` | लोकल डाउनलोड किए गए Ollama मॉडल्स की सूची |
| `ollpull` | `ollama pull MODEL` | Ollama मॉडल डाउनलोड करें |
| `ollamaserv` | `ollama serve` | पोर्ट 11434 पर Ollama API सर्वर शुरू करें |
| `llmchat` | `curl localhost:11434/api/generate with JSON` | curl के माध्यम से लोकल Ollama मॉडल से चैट करें |
| `tokcount` | `python3 -c tiktoken count tokens` | स्ट्रिंग में टोकन गिनें (tiktoken आवश्यक) |
| `openai` | `curl api.openai.com/v1/chat/completions` | curl के माध्यम से OpenAI API को प्रॉम्प्ट भेजें |

### Docker

| एलियास | रन | विवरण |
|-------|------|-------------|
| `dps` | `docker ps` | चल रहे कंटेनरों की सूची |
| `dpsa` | `docker ps -a` | सभी कंटेनरों की सूची |
| `di` | `docker images` | इमेज की सूची |
| `drm` | `docker rm` | कंटेनर हटाएं |
| `drmi` | `docker rmi` | इमेज हटाएं |
| `drmf` | `docker rm -f \$(docker ps -aq)` | सभी कंटेनर फोर्स रिमूव |
| `drmia` | `docker rmi \$(docker images -q)` | सभी इमेज हटाएं |
| `dex` | `docker exec -it CONTAINER bash` | कंटेनर में एक्जीक्यूट |
| `dl` | `docker logs -f CONTAINER` | कंटेनर लॉग फ़ॉलो करें |
| `dstop` | `docker stop \$(docker ps -aq)` | सभी कंटेनर बंद करें |
| `dprune` | `docker system prune -af` | सब कुछ प्रून करें (कंटेनर, इमेज, नेटवर्क) |
| `dc` | `docker compose` | Docker Compose शॉर्टकट |
| `dcu` | `docker compose up -d` | Compose अप (डिटैच्ड) |
| `dcd` | `docker compose down` | Compose डाउन |
| `dcb` | `docker compose build` | Compose बिल्ड |
| `dcl` | `docker compose logs -f` | Compose लॉग फ़ॉलो करें |
| `dcr` | `docker compose restart` | Compose सर्विस रीस्टार्ट |
| `dvls` | `docker volume ls` | वॉल्यूम की सूची |
| `dnls` | `docker network ls` | नेटवर्क की सूची |
| `dbuild` | `docker build -t NAME .` | Dockerfile से इमेज बिल्ड करें |

### Kubernetes

| एलियास | रन | विवरण |
|-------|------|-------------|
| `k` | `kubectl` | kubectl शॉर्टकट |
| `kgp` | `kubectl get pods` | पॉड्स की सूची |
| `kgpa` | `kubectl get pods --all-namespaces` | सभी नेमस्पेस में पॉड्स की सूची |
| `kgs` | `kubectl get svc` | सर्विसेस की सूची |
| `kgn` | `kubectl get nodes` | नोड्स की सूची |
| `kgd` | `kubectl get deployments` | डिप्लॉयमेंट की सूची |
| `kgi` | `kubectl get ingress` | इंग्रेस की सूची |
| `kgns` | `kubectl get namespaces` | नेमस्पेस की सूची |
| `kga` | `kubectl get all` | सभी रिसोर्सेस की सूची |
| `kdp` | `kubectl describe pod POD` | पॉड डिस्क्राइब |
| `kds` | `kubectl describe svc SVC` | सर्विस डिस्क्राइब |
| `kdd` | `kubectl describe deployment DEP` | डिप्लॉयमेंट डिस्क्राइब |
| `kl` | `kubectl logs -f POD` | पॉड लॉग फ़ॉलो करें |
| `klp` | `kubectl logs -f POD -p` | पिछला पॉड लॉग |
| `kex` | `kubectl exec -it POD -- bash` | पॉड में एक्जीक्यूट |
| `kaf` | `kubectl apply -f FILE` | मैनिफेस्ट अप्लाई करें |
| `kdf` | `kubectl delete -f FILE` | मैनिफेस्ट से डिलीट करें |
| `kctx` | `kubectl config get-contexts` | kube कॉन्टेक्स्ट दिखाएं |
| `kuse` | `kubectl config use-context CTX` | kube कॉन्टेक्स्ट स्विच करें |
| `kns` | `kubectl config set-context --current --namespace=NS` | डिफ़ॉल्ट नेमस्पेस सेट करें |
| `kpf` | `kubectl port-forward POD LOCAL:REMOTE` | पॉड में पोर्ट-फॉरवर्ड |
| `kscale` | `kubectl scale deployment DEP --replicas=N` | डिप्लॉयमेंट स्केल करें |
| `krollout` | `kubectl rollout status deployment DEP` | रोलआउट स्टेटस चेक करें |
| `krestart` | `kubectl rollout restart deployment DEP` | डिप्लॉयमेंट रीस्टार्ट |
| `ktop` | `kubectl top pods` | पॉड रिसोर्स यूसेज |
| `ktopn` | `kubectl top nodes` | नोड रिसोर्स यूसेज |

### Git Aliases

| एलियास | रन | विवरण |
|-------|------|-------------|
| `gs` | `git status` | वर्किंग ट्री स्टेटस दिखाएं |
| `gss` | `git status -s` | शॉर्ट फॉर्मेट स्टेटस |
| `ga` | `git add .` | सभी बदलाव स्टेज करें |
| `gaf` | `git add FILE` | विशिष्ट फ़ाइल स्टेज करें |
| `gc` | `git commit -m MSG` | मैसेज के साथ कमिट |
| `gca` | `git commit -a -m MSG` | सभी ट्रैक्ड फ़ाइल्स कमिट |
| `gcam` | `git commit --amend -m MSG` | आखिरी कमिट मैसेज संशोधित करें |
| `gcan` | `git commit --amend --no-edit` | आखिरी कमिट संशोधित करें, मैसेज रखें |
| `gp` | `git push` | origin पर पुश |
| `gpf` | `git push --force` | फोर्स पुश |
| `gpfl` | `git push --force-with-lease` | फोर्स पुश (सुरक्षित) |
| `gpu` | `git push -u origin BRANCH` | पुश और अपस्ट्रीम सेट करें |
| `gl` | `git pull` | origin से पुल |
| `glr` | `git pull --rebase` | रीबेस के साथ पुल |
| `glp` | `git pull --prune` | पुल और डेड रेफ प्रून |
| `gb` | `git branch` | लोकल ब्रांच की सूची |
| `gba` | `git branch -a` | सभी ब्रांच की सूची (लोकल+रिमोट) |
| `gbd` | `git branch -d BRANCH` | ब्रांच डिलीट |
| `gbdf` | `git branch -D BRANCH` | ब्रांच फोर्स डिलीट |
| `gco` | `git checkout BRANCH` | ब्रांच चेकआउट |
| `gcob` | `git checkout -b BRANCH` | नई ब्रांच बनाएं + चेकआउट |
| `gcop` | `git checkout -` | पिछली ब्रांच चेकआउट |
| `gcom` | `git checkout main \|\| git checkout master` | main/master चेकआउट |
| `gsw` | `git switch BRANCH` | ब्रांच स्विच करें (मॉडर्न) |
| `gswc` | `git switch -c BRANCH` | नई ब्रांच बनाएं + स्विच करें |
| `gm` | `git merge BRANCH` | ब्रांच मर्ज |
| `gmnf` | `git merge --no-ff BRANCH` | नो फास्ट-फॉरवर्ड मर्ज |
| `gma` | `git merge --abort` | मर्ज एबॉर्ट |
| `gbm` | `git branch --merged` | मर्ज की गई ब्रांच दिखाएं |
| `glog` | `git log --oneline --decorate --graph` | सुंदर कमिट ग्राफ |
| `gloga` | `git log --oneline --decorate --graph --all` | सुंदर ग्राफ, सभी ब्रांच |
| `glogd` | `git log --pretty=format:'%h %ad %s' --date=short` | तारीख के साथ लॉग |
| `glogs` | `git log --stat` | फ़ाइल स्टैट्स के साथ लॉग |
| `glogp` | `git log -p` | पैच के साथ लॉग |
| `glast` | `git log -1 HEAD` | आखिरी कमिट दिखाएं |
| `gblame` | `git blame FILE` | दिखाएं कि किसने हर लाइन बदली |
| `gshow` | `git show` | आखिरी कमिट डिटेल |
| `gauthor` | `git log --author NAME` | लेखक के अनुसार लॉग फ़िल्टर |
| `gsearch` | `git log --all --grep TERM` | कमिट मैसेज खोजें |
| `gbv` | `git branch -v` | ब्रांच आखिरी कमिट के साथ |
| `gbvv` | `git branch -vv` | ब्रांच ट्रैकिंग जानकारी के साथ |
| `grl` | `git reflog` | रेफलॉग दिखाएं |
| `gd` | `git diff` | अनस्टेज्ड डिफ दिखाएं |
| `gds` | `git diff --staged` | स्टेज्ड डिफ दिखाएं |
| `gdst` | `git diff --stat` | स्टैट्स के साथ डिफ |
| `gdw` | `git diff --word-diff` | वर्ड-लेवल डिफ |
| `gdc` | `git diff --color-words` | कलर्ड वर्ड डिफ |
| `gdfiles` | `git diff --name-only` | बदली गई फ़ाइलों की सूची |
| `gdstat` | `git diff --name-status` | स्टेटस के साथ बदली गई फ़ाइलें |
| `gdlc` | `git diff HEAD^ HEAD` | आखिरी कमिट का डिफ |
| `gls` | `git ls-files` | ट्रैक्ड फ़ाइलों की सूची |
| `glsu` | `git ls-files --others` | अनट्रैक्ड फ़ाइलों की सूची |
| `gcontrib` | `git shortlog -sn` | योगदानकर्ता दिखाएं |
| `gfh` | `git log --follow -p -- FILE` | फ़ाइल का पूरा इतिहास |
| `gst` | `git stash` | बदलाव स्टैश |
| `gstm` | `git stash push -m MSG` | मैसेज के साथ स्टैश |
| `gstu` | `git stash -u` | अनट्रैक्ड सहित स्टैश |
| `gsta` | `git stash -a` | सभी स्टैश (इग्नोर्ड सहित) |
| `gstl` | `git stash list` | स्टैश की सूची |
| `gsts` | `git stash show -p` | स्टैश कंटेंट दिखाएं |
| `gstap` | `git stash apply` | आखिरी स्टैश अप्लाई |
| `gstpo` | `git stash pop` | आखिरी स्टैश पॉप |
| `gstd` | `git stash drop` | स्टैश ड्रॉप |
| `gstc` | `git stash clear` | सभी स्टैश क्लियर |
| `gr` | `git remote` | रिमोट दिखाएं |
| `grv` | `git remote -v` | URL के साथ रिमोट |
| `gra` | `git remote add NAME URL` | रिमोट जोड़ें |
| `grr` | `git remote remove NAME` | रिमोट हटाएं |
| `gf` | `git fetch` | origin से फेच |
| `gfa` | `git fetch --all` | सभी रिमोट फेच |
| `gfp` | `git fetch --prune` | प्रून के साथ फेच |
| `gcl` | `git clone URL` | रिपॉजिटरी क्लोन |
| `gcld` | `git clone --depth 1 URL` | शैलो क्लोन |
| `grss` | `git reset --soft HEAD~1` | आखिरी कमिट सॉफ्ट रीसेट |
| `grsm` | `git reset HEAD~1` | आखिरी कमिट मिक्स्ड रीसेट |
| `grsh` | `git reset --hard HEAD~1` | आखिरी कमिट हार्ड रीसेट |
| `grso` | `git reset --hard origin/BRANCH` | origin पर रीसेट |
| `gus` | `git reset HEAD` | सभी फ़ाइलें अनस्टेज |
| `gusf` | `git reset HEAD -- FILE` | विशिष्ट फ़ाइल अनस्टेज |
| `gcn` | `git clean -n` | क्लीन ड्राई रन |
| `gcf` | `git clean -f` | अनट्रैक्ड फ़ाइलें क्लीन |
| `gcfd` | `git clean -fd` | अनट्रैक्ड फ़ाइलें + डायरेक्टरी क्लीन |
| `gdis` | `git checkout -- FILE` | फ़ाइल में बदलाव खारिज |
| `gcp` | `git cherry-pick HASH` | कमिट चुनें |
| `gcpc` | `git cherry-pick --continue` | चेरी-पिक जारी रखें |
| `gcpa` | `git cherry-pick --abort` | चेरी-पिक एबॉर्ट |
| `grbi` | `git rebase -i HASH` | इंटरएक्टिव रीबेस |
| `grbc` | `git rebase --continue` | रीबेस जारी रखें |
| `grba` | `git rebase --abort` | रीबेस एबॉर्ट |
| `grbs` | `git rebase --skip` | रीबेस स्टेप स्किप |
| `gt` | `git tag` | टैग दिखाएं |
| `gta` | `git tag -a TAG` | एनोटेटेड टैग बनाएं |
| `gpt` | `git push --tags` | सभी टैग पुश |

### Github Cli

| एलियास | रन | विवरण |
|-------|------|-------------|
| `ghpr` | `gh pr create` | GitHub पुल रिक्वेस्ट बनाएं |
| `ghprs` | `gh pr status` | मौजूदा ब्रांच का PR स्टेटस |
| `ghprl` | `gh pr list` | खुली पुल रिक्वेस्ट की सूची |
| `ghprd` | `gh pr diff` | मौजूदा PR का डिफ |
| `ghprm` | `gh pr merge` | मौजूदा पुल रिक्वेस्ट मर्ज |
| `ghprco` | `gh pr checkout NUMBER` | नंबर से पुल रिक्वेस्ट चेकआउट |
| `ghil` | `gh issue list` | खुले GitHub इशू की सूची |
| `ghic` | `gh issue create` | नया GitHub इशू बनाएं |
| `ghiv` | `gh issue view NUMBER` | विशिष्ट इशू देखें |
| `ghrl` | `gh release list` | GitHub रिलीज़ की सूची |
| `ghrc` | `gh release create` | नई GitHub रिलीज़ बनाएं |
| `ghrepo` | `gh repo view --web` | मौजूदा रिपॉ ब्राउज़र में खोलें |
| `ghrun` | `gh run list` | हाल के GitHub Actions वर्कफ़्लो रन |
| `ghrw` | `gh run watch` | GitHub Actions रन लाइव देखें |
| `ghssh` | `gh auth refresh -h github.com -s admin:public_key` | GitHub में SSH कुंजी जोड़ें |
| `ghclone` | `gh repo clone OWNER/REPO` | gh से रिपॉ क्लोन (ऑटो SSH) |
| `ghfork` | `gh repo fork --clone` | GitHub रिपॉ फोर्क और क्लोन |

### Cybersecurity Network Recon

| एलियास | रन | विवरण |
|-------|------|-------------|
| `tn` | `telnet HOST` | होस्ट पर टेलनेट |
| `tnp` | `telnet HOST PORT` | होस्ट:पोर्ट पर टेलनेट |
| `nsa` | `netstat -an` | सभी कनेक्शन |
| `nstcp` | `netstat -tlnp` | सुन रहे TCP पोर्ट |
| `nsudp` | `netstat -ulnp` | सुन रहे UDP पोर्ट |
| `nsproc` | `netstat -tulnp` | प्रोसेस जानकारी के साथ |
| `nsest` | `netstat -an \| grep ESTABLISHED` | स्थापित कनेक्शन |
| `nquick` | `nmap -F HOST` | Nmap क्विक स्कैन (शीर्ष 100 पोर्ट) |
| `nfull` | `nmap -p- HOST` | Nmap फुल TCP पोर्ट स्कैन |
| `nsvc` | `nmap -sV HOST` | Nmap सर्विस वर्जन डिटेक्शन |
| `nos` | `sudo nmap -O HOST` | Nmap OS डिटेक्शन |
| `nagg` | `sudo nmap -A HOST` | Nmap एग्रेसिव स्कैन |
| `nsyn` | `sudo nmap -sS HOST` | Nmap स्टील्थ SYN स्कैन |
| `nudp` | `sudo nmap -sU HOST` | Nmap UDP स्कैन |
| `nsweep` | `nmap -sn SUBNET` | Nmap पिंग स्वीप |
| `nvuln` | `nmap --script vuln HOST` | Nmap कमज़ोरी स्कैन |
| `nports` | `nmap -p PORTS HOST` | Nmap विशिष्ट पोर्ट स्कैन |
| `nscript` | `nmap -sC HOST` | Nmap डिफ़ॉल्ट स्क्रिप्ट स्कैन |
| `nmapxml` | `nmap -oX output.xml HOST` | Nmap XML आउटपुट |
| `ncl` | `nc -lvp PORT` | Netcat पोर्ट पर सुनें |
| `ncs` | `nc HOST PORT` | Netcat होस्ट:पोर्ट से कनेक्ट |
| `ncscan` | `nc -zv HOST START-END` | Netcat पोर्ट स्कैन |
| `sslcheck` | `openssl s_client + x509 DOMAIN` | SSL सर्टिफिकेट जानकारी |
| `sslchain` | `openssl s_client -showcerts DOMAIN` | पूर्ण SSL चेन |
| `sslciphers` | `nmap ssl-enum-ciphers -p 443 DOMAIN` | SSL साइफर एन्यूमरेट |
| `bannergrab` | `nc -w 3 HOST PORT` | Netcat बैनर ग्रैब |
| `myports` | `lsof -i -P -n \| grep LISTEN` | खुले पोर्ट दिखाएं |
| `arptable` | `arp -a` | ARP टेबल |
| `routes` | `netstat -rn / ip route show` | राउटिंग टेबल |
| `fwrules` | `sudo iptables -L / pfctl -sr` | फायरवॉल नियम |
| `sniff` | `sudo tcpdump -i any -nn` | पैकेट स्निफिंग |
| `tcapt` | `sudo tcpdump -w capture.pcap` | फ़ाइल में कैप्चर |
| `tcport` | `sudo tcpdump port PORT` | पोर्ट से फ़िल्टर |
| `tchost` | `sudo tcpdump host HOST` | होस्ट से फ़िल्टर |
| `secheaders` | `curl -sI URL \| grep security headers` | HTTP सुरक्षा हैडर |
| `hashpw` | `echo -n PW \| openssl dgst -sha512` | पासवर्ड हैश |
| `genpw` | `tr -dc A-Za-z0-9... < /dev/urandom` | यादृच्छिक पासवर्ड |
| `worldwrite` | `find / -perm -0002` | वर्ल्ड-राइटेबल फ़ाइलें |
| `findsuid` | `find / -perm -4000` | SUID बाइनरी |
| `whoson` | `who -a / w` | लॉगिन उपयोगकर्ता |
| `b64e` | `echo -n STR \| base64` | Base64 एन्कोड |
| `b64d` | `echo -n STR \| base64 --decode` | Base64 डिकोड |
| `jwtdecode` | `jq -R 'split(\".\") \| .[0],.[1] \| @base64d \| fromjson'` | JWT डिकोड |
| `shodanip` | `curl -s https://internetdb.shodan.io/IP` | Shodan IP लुकअप |
| `sshkey` | `ssh-keygen -t ed25519 -C EMAIL` | आधुनिक SSH कुंजी |

### Data Tools

| एलियास | रन | विवरण |
|-------|------|-------------|
| `jqpp` | `cat file.json \| jq .` | JSON सुंदर प्रिंट |
| `jqkeys` | `jq 'keys'` | शीर्ष JSON कुंजियां |
| `jqlen` | `jq 'length'` | JSON लंबाई |
| `jqm` | `jq 'map(.FIELD)'` | JSON फ़ील्ड मैप |
| `jqsel` | `jq '.[] \| select(.key==val)'` | JSON फ़ील्ड फ़िल्टर |
| `yamlcheck` | `python3 -c yaml.safe_load` | YAML सत्यापित |
| `yaml2json` | `python3 yaml to json` | YAML से JSON |
| `json2yaml` | `python3 json to yaml` | JSON से YAML |
| `csvhead` | `head -1 FILE.csv \| tr ',' '\n'` | CSV हेडर |
| `csvcol` | `cut -d, -f N FILE.csv` | CSV कॉलम |
| `sortjson` | `jq 'sort_by(.KEY)'` | JSON सॉर्ट |

### Cloud Deploy

| एलियास | रन | विवरण |
|-------|------|-------------|
| `vdeploy` | `vercel --prod` | Vercel प्रोड डिप्लॉय |
| `vdev` | `vercel dev` | Vercel लोकल डेव |
| `venv` | `vercel env pull .env.local` | Vercel env लोकल पुल |
| `hdeploy` | `git push heroku main` | Heroku डिप्लॉय |
| `hlogs` | `heroku logs --tail` | Heroku लॉग |
| `hbash` | `heroku run bash` | Heroku bash |
| `hrestart` | `heroku restart` | Heroku रीस्टार्ट |
| `rdeploy` | `railway up` | Railway डिप्लॉय |
| `rlogs` | `railway logs` | Railway लॉग |
| `fldeploy` | `fly deploy` | Fly.io डिप्लॉय |
| `fllogs` | `fly logs` | Fly.io लॉग |
| `flssh` | `fly ssh console` | Fly.io SSH |
| `flscale` | `fly scale count N` | Fly.io स्केल |

### Gcp Gcloud

| एलियास | रन | विवरण |
|-------|------|-------------|
| `gcpid` | `gcloud config get-value project` | मौजूदा GCP प्रोजेक्ट |
| `gcpset` | `gcloud config set project PROJECT` | GCP प्रोजेक्ट सेट |
| `gcpls` | `gcloud compute instances list` | GCE इंस्टेंस |
| `gcpssh` | `gcloud compute ssh INSTANCE` | GCE SSH |
| `gcpgke` | `gcloud container clusters list` | GKE क्लस्टर्स |
| `gcpgkecreds` | `gcloud container clusters get-credentials CLUSTER` | GKE क्रेडेंशियल |
| `gcpbq` | `bq ls` | BigQuery डेटासेट |
| `gcpgsutil` | `gsutil ls` | GCS बकेट |
| `gcpcp` | `gsutil cp FILE gs://BUCKET/` | GCS कॉपी |
| `gcpsync` | `gsutil -m rsync -r DIR gs://BUCKET/` | GCS सिंक |
| `gcprun` | `gcloud run services list` | Cloud Run सर्विस |
| `gcpfn` | `gcloud functions list` | Cloud Functions |
| `gcpsql` | `gcloud sql instances list` | Cloud SQL |
| `gcplog` | `gcloud logging read FILTER --limit=50` | GCP लॉग |
| `gcpauth` | `gcloud auth login` | GCP ऑथ |

### Git Workflow

| एलियास | रन | विवरण |
|-------|------|-------------|
| `gg` | `git add . && git commit -m MSG && git push` | एक कमांड में ऐड, कमिट, पुश |
| `gclo` | `git clone https://github.com/USER/REPO` | GitHub रिपॉ क्लोन |
| `jclo` | `git clone https://github.com/juleshenry/REPO` | juleshenry रिपॉ क्लोन |
| `presto` | `git checkout --orphan && force-push` | विनाशकारी: पूरा इतिहास मिटाएं |
| `gwip` | `git add . && git commit -m 'wip: TIME'` | त्वरित WIP कमिट (पुश नहीं) |
| `gunwip` | `git reset --soft HEAD~1` | WIP कमिट पूर्ववत |
| `gpristine` | `git reset --hard origin/BRANCH && git clean -fd` | रिमोट से पूर्ण मेल |
| `gtag` | `git tag -a TAG -m MSG && git push origin TAG` | टैग बनाएं और पुश |
| `gpr` | `gh pr create --title TITLE --fill` | GitHub PR बनाएं |
| `gdiff-fancy` | `git diff --stat + git diff --shortstat` | सुंदर डिफ सारांश |
| `gacp` | `git add . && git commit -m MSG && git push` | ऐड, कमिट, पुश (gg समान) |
| `ginit` | `git init && git add . && git commit -m 'Initial commit'` | रिपॉ इनिशियलाइज़ |
| `ghcl` | `git clone https://github.com/USER/REPO` | GitHub से क्लोन |
| `gbc` | `git checkout -b BRANCH` | ब्रांच बनाएं और स्विच |
| `gbdall` | `git branch -d B && git push origin --delete B` | लोकल + रिमोट डिलीट |
| `gundo` | `git reset --soft HEAD~1` | कमिट पूर्ववत |
| `gbs` | `git for-each-ref --sort=-committerdate` | ब्रांच आखिरी модификаई से |
| `gquick` | `git add . && git commit -m 'Quick update: TIME' && git push` | ऑटो-टाइमस्टैप कमिट |
| `gchanged` | `git diff --name-only HEAD~N..HEAD` | बदली गई फ़ाइलें |
| `gsearchtext` | `git log -S TEXT` | टेक्स्ट खोजें |
| `gnew` | `git fetch origin && git checkout -b B origin/main` | origin/main से ब्रांच |
| `gupdateall` | `git fetch --all && git pull` | सभी फेच और पुल |
| `greposize` | `git count-objects -vH` | रिपॉ साइज़ |
| `gfilesize` | `git ls-tree -r -t -l --full-name HEAD \| sort` | फ़ाइल साइज़ |
| `glarge` | `git rev-list --objects --all \| ...` | सबसे बड़े ब्लॉब |
| `gsyncfork` | `git fetch upstream && merge upstream/main` | फोर्क सिंक |
| `gsquash` | `git reset --soft HEAD~N && git commit -m MSG` | N कमिट स्क्वैश |
| `gstats` | `git shortlog -sn --all --no-merges` | कमिट काउंट |
| `garchive` | `git tag archive/B && delete branch` | ब्रांच आर्काइव |
| `galias` | `alias \| grep '^g'` | सभी g* एलियास |
| `ginfo` | `repo name, branch, remote, last commit` | रिपॉ जानकारी |
| `gbackup` | `tar -czf backup.tar.gz .` | बैकअप |

### Macos Power Tools

| एलियास | रन | विवरण |
|-------|------|-------------|
| `caffeinate` | `caffeinate -d` | Mac स्लीप रोकें |
| `hidefiles` | `defaults write com.apple.finder ... [कटा हुआ]
