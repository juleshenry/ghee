<div dir="rtl">

# 🧈 ghee

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Shell](https://img.shields.io/badge/shell-bash%20%7C%20zsh-yellow)
![Python](https://img.shields.io/badge/python-3.8%2B-blue)

> *مثل السمن الهندي المصفى — نقي، غني، ويجعل كل شيء أفضل.*

**ghee** هو مجموعة من **538+ اختصار شل** للمطورين ومهندسي DevOps والمستخدمين المتقدمين. يعمل بسلاسة فوق شل الحالي، مما يجعل سطر الأوامر سريعًا وفعالًا — تمامًا مثل الشيء الحقيقي.

يغطي: Git و Docker و Kubernetes و AWS و GCP و Terraform و Heroku و Vercel و Fly.io و Railway و GitHub CLI و npm/yarn/pnpm و Python/pip و Rust و Go و Redis و PostgreSQL و MongoDB و Nginx و systemd و tmux والشبكات والأمن السيبراني/الاستطلاع وأدوات الذكاء الاصطناعي/LLM والوسائط (ffmpeg/yt-dlp) و JSON/YAML/CSV وأدوات macOS المتقدمة والمزيد.

---

## 📑 فهرس المحتويات

- [✨ الميزات](#-الميزات)
- [✅ المتطلبات](#-المتطلبات)
- [🚀 التثبيت](#-التثبيت)
- [🎮 استخدام أمر G](#-استخدام-أمر-g)
- [📦 بنية المشروع](#-بنية-المشروع)
- [📖 مرجع الأوامر](#-مرجع-الأوامر)
- [🛠️ إضافة اختصارات مخصصة](#️-إضافة-اختصارات-مخصصة)
- [🤝 المساهمة](#-المساهمة)
- [🎨 لماذا "ghee"؟](#-لماذا-ghee)
- [📄 الترخيص](#-الترخيص)

---

## ✨ الميزات

- 🔍 **`G`** — واجهة Python تفاعلية للبحث الغامض في 538+ أمر مع معاينة مباشرة
- ⚡ **`G 'docker logs'`** — أفضل تخمين لأي أمر شل، ينسخ التطابق إلى الحافظة
- ➕ **`G -a <alias> <command>`** — أضف اختصارك المخصص، يُحفظ في `~/.ghee-custom`
- ➖ **`G -rm <alias>`** — احذف اختصارًا مخصصًا
- 📦 **وحدات نمطية** — 29 وحدة موضوعية، تُحمّل تلقائيًا في شل
- 🐍 **مدعوم بـ Python** — واجهة Rich جميلة مع مطابقة غامضة وتنسيق ملون
- 🔌 **التوصيل والتشغيل** — `./setup-ghee` يهيئ كل شيء في أقل من 30 ثانية

---

## ✅ المتطلبات

- **نظام التشغيل:** macOS أو Linux
- **الشل:** `bash` أو `zsh`
- **Python:** `python3` (يوصى بـ 3.8 أو أحدث)
- **Git:** مطلوب لاستنساخ المستودع

---

## 🚀 التثبيت

### الإعداد السريع

```bash
git clone https://github.com/juleshenry/ghee.git
cd ghee
chmod +x setup-ghee
./setup-ghee
source ~/.zshrc   # أو source ~/.bashrc
```

### الإعداد اليدوي

أضف هذا الكتلة إلى `~/.bashrc` أو `~/.zshrc`:

```bash
export PATH="/path/to/ghee/bin:/path/to/ghee/tools:$PATH"
source "/path/to/ghee/ghee-functions.sh"
for _gg_mod in "/path/to/ghee/modules"/*.sh; do
    source "$_gg_mod"
done
```

### ما يفعله المثبت

- يكشف شل (bash أو zsh) وينسخ ملف RC احتياطيًا
- ينشئ بيئة Python افتراضية (`ghee-venv`) مع `rich` للواجهة التفاعلية
- يصدّر `bin/` و `tools/` إلى `$PATH`
- يحمّل جميع 29 وحدة من `modules/*.sh` في شل

### إلغاء التثبيت

```bash
./setup-ghee --remove && source ~/.zshrc
```

---

## 🎮 استخدام أمر G

```bash
G                            # باحث غامض تفاعلي — ابحث في 538+ أمر
G 'docker logs'              # أفضل تخمين، ينسخ أفضل تطابق للحافظة
G -a 'npm run dev' 'ابدأ خادم التطوير'  # أضف اختصار مخصص (يُحفظ)
G -rm myalias                # احذف اختصارًا مخصصًا
```

في الوضع التفاعلي: **الأسهم** للتنقل · **Enter** للاختيار · **Tab** للنسخ · **Esc** للخروج.

---

## 📦 بنية المشروع

```
ghee/
├── setup-ghee              # مثبت / مثبت إلغاء
├── ghee-functions.sh       # الأساس: ألوان، غلاف G()، تعريف السجل
├── ghee.py                 # واجهة Python (CLI بحث غامض بـ Rich)
├── modules/                # 29 وحدة bash، تُحمّل تلقائيًا عند بدء شل
│   ├── git_workflow.sh       # دوال git متقدمة (gwip، presto، gtag...)
│   ├── git_aliases.sh        # 90+ اسم مستعار git (gs، gco، glog...)
│   ├── docker.sh             # Docker & Compose
│   ├── kubernetes.sh         # اختصارات kubectl
│   ├── aws_cli.sh            # AWS CLI
│   ├── gcp_gcloud.sh         # GCP gcloud
│   ├── terraform.sh          # Terraform
│   ├── cloud_deploy.sh       # Heroku، Vercel، Fly.io، Railway
│   ├── github_cli.sh         # gh CLI (PRs، issues، releases)
│   ├── npm_yarn_pnpm.sh      # مديرو حزم JS
│   ├── python_pip_venv.sh    # Python / pip / venv / pytest
│   ├── rust_go.sh            # Cargo + Go أدوات
│   ├── redis.sh              # Redis CLI
│   ├── postgresql.sh         # اختصارات psql
│   ├── mongodb.sh            # MongoDB CLI
│   ├── nginx.sh              # إدارة Nginx
│   ├── systemd_services.sh   # systemctl / journalctl
│   ├── networking.sh         # curl، dig، DNS، سرعة
│   ├── cybersecurity_network_recon.sh  # nmap، tcpdump، ssl، ncat
│   ├── ai_llm.sh             # Ollama، OpenAI API
│   ├── media_tools.sh        # ffmpeg، yt-dlp، imagemagick
│   ├── data_tools.sh         # jq، YAML، CSV معالجة
│   ├── macos_power_tools.sh  # أدوات macOS خاصة
│   ├── super_utilities.sh    # cheat، weather، UUID، timer
│   ├── tmux.sh               # إدارة جلسات tmux
│   └── shell_file_utilities.sh  # history، extract، ports، swap...
├── bin/                    # نصوص bash مستقلة (تُضاف إلى PATH)
└── tools/                  # نصوص Python (تُضاف إلى PATH)
```

</div>

---

## 📖 مرجع الأوامر

> **ملاحظة:** الأسماء المستعارة والأوامر تبقى باللغة الإنجليزية للاتساق التقني. الوصف مترجم إلى العربية.

<div dir="rtl">

### Ai Llm

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `ollama` | `ollama run MODEL` | تشغيل نموذج LLM محلي عبر Ollama |
| `ollmls` | `ollama list` | سرد نماذج Ollama المحملة محليًا |
| `ollpull` | `ollama pull MODEL` | تحميل نموذج Ollama |
| `ollamaserv` | `ollama serve` | بدء خادم API Ollama على المنفذ 11434 |
| `llmchat` | `curl localhost:11434/api/generate with JSON` | الدردشة مع نموذج Ollama محلي عبر curl |
| `tokcount` | `python3 -c tiktoken count tokens` | عدد الرموز في سلسلة (يتطلب tiktoken) |
| `openai` | `curl api.openai.com/v1/chat/completions` | إرسال مطالبة إلى OpenAI API عبر curl |

### Docker

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `dps` | `docker ps` | سرد الحاويات العاملة |
| `dpsa` | `docker ps -a` | سرد جميع الحاويات |
| `di` | `docker images` | سرد الصور |
| `drm` | `docker rm` | إزالة حاوية |
| `drmi` | `docker rmi` | إزالة صورة |
| `drmf` | `docker rm -f \$(docker ps -aq)` | إزالة جميع الحاويات بالقوة |
| `drmia` | `docker rmi \$(docker images -q)` | إزالة جميع الصور |
| `dex` | `docker exec -it CONTAINER bash` | تنفيذ داخل حاوية |
| `dl` | `docker logs -f CONTAINER` | متابعة سجلات الحاوية |
| `dstop` | `docker stop \$(docker ps -aq)` | إيقاف جميع الحاويات |
| `dprune` | `docker system prune -af` | تنظيف كل شيء (حاويات، صور، شبكات) |
| `dc` | `docker compose` | اختصار Docker Compose |
| `dcu` | `docker compose up -d` | Compose تشغيل (خلفية) |
| `dcd` | `docker compose down` | Compose إيقاف |
| `dcb` | `docker compose build` | Compose بناء |
| `dcl` | `docker compose logs -f` | متابعة سجلات Compose |
| `dcr` | `docker compose restart` | إعادة تشغيل خدمات Compose |
| `dvls` | `docker volume ls` | سرد وحدات التخزين |
| `dnls` | `docker network ls` | سرد الشبكات |
| `dbuild` | `docker build -t NAME .` | بناء صورة من Dockerfile |

### Kubernetes

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `k` | `kubectl` | اختصار kubectl |
| `kgp` | `kubectl get pods` | سرد Pods |
| `kgpa` | `kubectl get pods --all-namespaces` | سرد جميع Pods عبر نطاقات الأسماء |
| `kgs` | `kubectl get svc` | سرد الخدمات |
| `kgn` | `kubectl get nodes` | سرد العقد |
| `kgd` | `kubectl get deployments` | سرد عمليات النشر |
| `kgi` | `kubectl get ingress` | سرد Ingresses |
| `kgns` | `kubectl get namespaces` | سرد نطاقات الأسماء |
| `kga` | `kubectl get all` | سرد جميع الموارد |
| `kdp` | `kubectl describe pod POD` | وصف Pod |
| `kds` | `kubectl describe svc SVC` | وصف خدمة |
| `kdd` | `kubectl describe deployment DEP` | وصف عملية نشر |
| `kl` | `kubectl logs -f POD` | متابعة سجلات Pod |
| `klp` | `kubectl logs -f POD -p` | سجلات Pod السابقة |
| `kex` | `kubectl exec -it POD -- bash` | تنفيذ داخل Pod |
| `kaf` | `kubectl apply -f FILE` | تطبيق بيان |
| `kdf` | `kubectl delete -f FILE` | حذف من بيان |
| `kctx` | `kubectl config get-contexts` | عرض سياقات kube |
| `kuse` | `kubectl config use-context CTX` | تبديل سياق kube |
| `kns` | `kubectl config set-context --current --namespace=NS` | تعيين نطاق الأسماء الافتراضي |
| `kpf` | `kubectl port-forward POD LOCAL:REMOTE` | إعادة توجيه المنفذ إلى Pod |
| `kscale` | `kubectl scale deployment DEP --replicas=N` | تحجيم عملية نشر |
| `krollout` | `kubectl rollout status deployment DEP` | التحقق من حالة النشر |
| `krestart` | `kubectl rollout restart deployment DEP` | إعادة تشغيل عملية نشر |
| `ktop` | `kubectl top pods` | استخدام موارد Pods |
| `ktopn` | `kubectl top nodes` | استخدام موارد العقد |

### Git Aliases

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `gs` | `git status` | عرض حالة شجرة العمل |
| `gss` | `git status -s` | حالة بتنسيق مختصر |
| `ga` | `git add .` | مرحلة جميع التغييرات |
| `gaf` | `git add FILE` | مرحلة ملف معين |
| `gc` | `git commit -m MSG` | تأكيد مع رسالة |
| `gca` | `git commit -a -m MSG` | تأكيد جميع الملفات المتتبعة |
| `gcam` | `git commit --amend -m MSG` | تعديل رسالة آخر تأكيد |
| `gcan` | `git commit --amend --no-edit` | تعديل آخر تأكيد، الاحتفاظ بالرسالة |
| `gp` | `git push` | دفع إلى origin |
| `gpf` | `git push --force` | دفع بالقوة |
| `gpfl` | `git push --force-with-lease` | دفع بالقوة (أكثر أمانًا) |
| `gpu` | `git push -u origin BRANCH` | دفع وتعيين upstream |
| `gl` | `git pull` | سحب من origin |
| `glr` | `git pull --rebase` | سحب مع rebase |
| `glp` | `git pull --prune` | سحب وتنظيف المراجع الميتة |
| `gb` | `git branch` | سرد الفروع المحلية |
| `gba` | `git branch -a` | سرد جميع الفروع (محلية+بعيدة) |
| `gbd` | `git branch -d BRANCH` | حذف فرع |
| `gbdf` | `git branch -D BRANCH` | حذف فرع بالقوة |
| `gco` | `git checkout BRANCH` | الانتقال إلى فرع |
| `gcob` | `git checkout -b BRANCH` | إنشاء + الانتقال إلى فرع جديد |
| `gcop` | `git checkout -` | الانتقال إلى الفرع السابق |
| `gcom` | `git checkout main \|\| git checkout master` | الانتقال إلى main/master |
| `gsw` | `git switch BRANCH` | التبديل إلى فرع (حديث) |
| `gswc` | `git switch -c BRANCH` | إنشاء + التبديل إلى فرع جديد |
| `gm` | `git merge BRANCH` | دمج فرع |
| `gmnf` | `git merge --no-ff BRANCH` | دمج بدون تمرير سريع |
| `gma` | `git merge --abort` | إلغاء دمج |
| `gbm` | `git branch --merged` | عرض الفروع المدمجة |
| `glog` | `git log --oneline --decorate --graph` | رسم جميل للتأكيدات |
| `gloga` | `git log --oneline --decorate --graph --all` | رسم جميل، جميع الفروع |
| `glogd` | `git log --pretty=format:'%h %ad %s' --date=short` | سجل مع التواريخ |
| `glogs` | `git log --stat` | سجل مع إحصائيات الملفات |
| `glogp` | `git log -p` | سجل مع التصحيحات |
| `glast` | `git log -1 HEAD` | عرض آخر تأكيد |
| `gblame` | `git blame FILE` | عرض من غيّر كل سطر |
| `gshow` | `git show` | عرض تفاصيل آخر تأكيد |
| `gauthor` | `git log --author NAME` | تصفية السجل حسب المؤلف |
| `gsearch` | `git log --all --grep TERM` | البحث في رسائل التأكيد |
| `gbv` | `git branch -v` | الفروع مع آخر تأكيد |
| `gbvv` | `git branch -vv` | الفروع مع معلومات التتبع |
| `grl` | `git reflog` | عرض reflog |
| `gd` | `git diff` | عرض الفرق غير المرحّل |
| `gds` | `git diff --staged` | عرض الفرق المرحّل |
| `gdst` | `git diff --stat` | فرق مع إحصائيات |
| `gdw` | `git diff --word-diff` | فرق على مستوى الكلمات |
| `gdc` | `git diff --color-words` | فرق كلمات ملون |
| `gdfiles` | `git diff --name-only` | سرد أسماء الملفات المتغيرة |
| `gdstat` | `git diff --name-status` | ملفات متغيرة مع الحالة |
| `gdlc` | `git diff HEAD^ HEAD` | فرق آخر تأكيد |
| `gls` | `git ls-files` | سرد الملفات المتتبعة |
| `glsu` | `git ls-files --others` | سرد الملفات غير المتتبعة |
| `gcontrib` | `git shortlog -sn` | عرض المساهمين |
| `gfh` | `git log --follow -p -- FILE` | عرض التاريخ الكامل للملف |
| `gst` | `git stash` | تخزين التغييرات مؤقتًا |
| `gstm` | `git stash push -m MSG` | تخزين مع رسالة |
| `gstu` | `git stash -u` | تخزين بما في ذلك غير المتتبعة |
| `gsta` | `git stash -a` | تخزين الكل (بما في ذلك المتجاهلة) |
| `gstl` | `git stash list` | سرد التخزينات المؤقتة |
| `gsts` | `git stash show -p` | عرض محتوى التخزين |
| `gstap` | `git stash apply` | تطبيق آخر تخزين |
| `gstpo` | `git stash pop` | إخراج آخر تخزين |
| `gstd` | `git stash drop` | حذف تخزين |
| `gstc` | `git stash clear` | مسح جميع التخزينات |
| `gr` | `git remote` | عرض المستودعات البعيدة |
| `grv` | `git remote -v` | عرض البعيدة مع عناوين URL |
| `gra` | `git remote add NAME URL` | إضافة بعيد |
| `grr` | `git remote remove NAME` | إزالة بعيد |
| `gf` | `git fetch` | جلب من origin |
| `gfa` | `git fetch --all` | جلب جميع البعيدة |
| `gfp` | `git fetch --prune` | جلب مع تنظيف |
| `gcl` | `git clone URL` | استنساخ مستودع |
| `gcld` | `git clone --depth 1 URL` | استنساخ سطحي |
| `grss` | `git reset --soft HEAD~1` | إعادة تعيين ناعمة لآخر تأكيد |
| `grsm` | `git reset HEAD~1` | إعادة تعيين مختلطة لآخر تأكيد |
| `grsh` | `git reset --hard HEAD~1` | إعادة تعيين صلبة لآخر تأكيد |
| `grso` | `git reset --hard origin/BRANCH` | إعادة تعيين إلى origin |
| `gus` | `git reset HEAD` | إلغاء مرحلة جميع الملفات |
| `gusf` | `git reset HEAD -- FILE` | إلغاء مرحلة ملف معين |
| `gcn` | `git clean -n` | تنظيف تجريبي |
| `gcf` | `git clean -f` | تنظيف الملفات غير المتتبعة |
| `gcfd` | `git clean -fd` | تنظيف الملفات غير المتتبعة + المجلدات |
| `gdis` | `git checkout -- FILE` | تجاهل التغييرات في الملف |
| `gcp` | `git cherry-pick HASH` | انتقاء تأكيد |
| `gcpc` | `git cherry-pick --continue` | متابعة انتقاء |
| `gcpa` | `git cherry-pick --abort` | إلغاء انتقاء |
| `grbi` | `git rebase -i HASH` | rebase تفاعلي |
| `grbc` | `git rebase --continue` | متابعة rebase |
| `grba` | `git rebase --abort` | إلغاء rebase |
| `grbs` | `git rebase --skip` | تخطي خطوة rebase |
| `gt` | `git tag` | عرض العلامات |
| `gta` | `git tag -a TAG` | إنشاء علامة مشروحة |
| `gpt` | `git push --tags` | دفع جميع العلامات |

### Github Cli

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `ghpr` | `gh pr create` | إنشاء طلب سحب GitHub |
| `ghprs` | `gh pr status` | عرض حالة طلب السحب للفرع الحالي |
| `ghprl` | `gh pr list` | سرد طلبات السحب المفتوحة |
| `ghprd` | `gh pr diff` | عرض الفرق لطلب السحب الحالي |
| `ghprm` | `gh pr merge` | دمج طلب السحب الحالي |
| `ghprco` | `gh pr checkout NUMBER` | الانتقال إلى طلب سحب بالرقم |
| `ghil` | `gh issue list` | سرد قضايا GitHub المفتوحة |
| `ghic` | `gh issue create` | إنشاء قضية GitHub جديدة |
| `ghiv` | `gh issue view NUMBER` | عرض قضية معينة |
| `ghrl` | `gh release list` | سرد إصدارات GitHub |
| `ghrc` | `gh release create` | إنشاء إصدار GitHub جديد |
| `ghrepo` | `gh repo view --web` | فتح المستودع الحالي في المتصفح |
| `ghrun` | `gh run list` | سرد عمليات سير عمل GitHub Actions الأخيرة |
| `ghrw` | `gh run watch` | مشاهدة عملية GitHub Actions مباشرة |
| `ghssh` | `gh auth refresh -h github.com -s admin:public_key` | إضافة مفتاح SSH إلى GitHub |
| `ghclone` | `gh repo clone OWNER/REPO` | استنساخ مستودع باستخدام gh (SSH تلقائي) |
| `ghfork` | `gh repo fork --clone` | تشعب واستنساخ مستودع GitHub |

### Cybersecurity Network Recon

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `tn` | `telnet HOST` | Telnet إلى مضيف |
| `tnp` | `telnet HOST PORT` | Telnet إلى مضيف:منفذ |
| `nsa` | `netstat -an` | جميع الاتصالات |
| `nstcp` | `netstat -tlnp` | منافذ TCP المستمعة |
| `nsudp` | `netstat -ulnp` | منافذ UDP المستمعة |
| `nsproc` | `netstat -tulnp` | مع معلومات العمليات |
| `nsest` | `netstat -an \| grep ESTABLISHED` | الاتصالات المؤسسة |
| `nquick` | `nmap -F HOST` | فحص سريع (أعلى 100 منفذ) |
| `nfull` | `nmap -p- HOST` | فحص جميع المنافذ |
| `nsvc` | `nmap -sV HOST` | اكتشاف إصدار الخدمة |
| `nos` | `sudo nmap -O HOST` | اكتشاف نظام التشغيل |
| `nagg` | `sudo nmap -A HOST` | فحص عدواني |
| `nsyn` | `sudo nmap -sS HOST` | فحص SYN خفي |
| `nudp` | `sudo nmap -sU HOST` | فحص UDP |
| `nsweep` | `nmap -sn SUBNET` | اكتشاف المضيفين |
| `nvuln` | `nmap --script vuln HOST` | فحص الثغرات |
| `nports` | `nmap -p PORTS HOST` | فحص منافذ معينة |
| `nscript` | `nmap -sC HOST` | فحص بالنصوص الافتراضية |
| `nmapxml` | `nmap -oX output.xml HOST` | إخراج XML |
| `ncl` | `nc -lvp PORT` | Netcat استماع على منفذ |
| `ncs` | `nc HOST PORT` | Netcat اتصال بمضيف |
| `ncscan` | `nc -zv HOST START-END` | فحص منافذ بـ netcat |
| `sslcheck` | `openssl s_client + x509 DOMAIN` | معلومات شهادة SSL |
| `sslchain` | `openssl s_client -showcerts DOMAIN` | سلسلة شهادات SSL كاملة |
| `sslciphers` | `nmap ssl-enum-ciphers -p 443 DOMAIN` | تعداد تشفيرات SSL |
| `bannergrab` | `nc -w 3 HOST PORT` | التقاط اللافتة |
| `myports` | `lsof -i -P -n \| grep LISTEN` | المنافذ المفتوحة على هذا المضيف |
| `arptable` | `arp -a` | جدول ARP |
| `routes` | `netstat -rn / ip route show` | جدول التوجيه |
| `fwrules` | `sudo iptables -L / pfctl -sr` | قواعد الجدار الناري |
| `sniff` | `sudo tcpdump -i any -nn` | التقاط الحزم |
| `tcapt` | `sudo tcpdump -w capture.pcap` | التقاط إلى ملف |
| `tcport` | `sudo tcpdump port PORT` | تصفية حسب المنفذ |
| `tchost` | `sudo tcpdump host HOST` | تصفية حسب المضيف |
| `secheaders` | `curl -sI URL \| grep security headers` | رؤوس أمان HTTP |
| `hashpw` | `echo -n PW \| openssl dgst -sha512` | تجزئة كلمة مرور |
| `genpw` | `tr -dc A-Za-z0-9... < /dev/urandom` | توليد كلمة مرور عشوائية |
| `worldwrite` | `find / -perm -0002` | ملفات قابلة للكتابة عالميًا |
| `findsuid` | `find / -perm -4000` | ملفات SUID الثنائية |
| `whoson` | `who -a / w` | المستخدمون المسجلون |
| `b64e` | `echo -n STR \| base64` | ترميز Base64 |
| `b64d` | `echo -n STR \| base64 --decode` | فك ترميز Base64 |
| `jwtdecode` | `jq -R 'split(\".\") \| .[0],.[1] \| @base64d \| fromjson'` | فك رمز JWT |
| `shodanip` | `curl -s https://internetdb.shodan.io/IP` | بحث Shodan سريع |
| `sshkey` | `ssh-keygen -t ed25519 -C EMAIL` | توليد مفتاح SSH آمن حديث |

### Data Tools

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `jqpp` | `cat file.json \| jq .` | تنسيق JSON |
| `jqkeys` | `jq 'keys'` | مفاتيح JSON العلوية |
| `jqlen` | `jq 'length'` | طول JSON |
| `jqm` | `jq 'map(.FIELD)'` | استخراج حقل JSON |
| `jqsel` | `jq '.[] \| select(.key==val)'` | تصفية JSON بالحقل |
| `yamlcheck` | `python3 -c yaml.safe_load` | التحقق من YAML |
| `yaml2json` | `python3 yaml to json` | YAML إلى JSON |
| `json2yaml` | `python3 json to yaml` | JSON إلى YAML |
| `csvhead` | `head -1 FILE.csv \| tr ',' '\n'` | رؤوس CSV |
| `csvcol` | `cut -d, -f N FILE.csv` | عمود CSV |
| `sortjson` | `jq 'sort_by(.KEY)'` | ترتيب JSON |

### Cloud Deploy

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `vdeploy` | `vercel --prod` | نشر Vercel إنتاج |
| `vdev` | `vercel dev` | خادم تطوير Vercel محلي |
| `venv` | `vercel env pull .env.local` | سحب متغيرات Vercel |
| `hdeploy` | `git push heroku main` | نشر Heroku |
| `hlogs` | `heroku logs --tail` | سجلات Heroku |
| `hbash` | `heroku run bash` | shell على Heroku |
| `hrestart` | `heroku restart` | إعادة تشغيل Heroku |
| `rdeploy` | `railway up` | نشر Railway |
| `rlogs` | `railway logs` | سجلات Railway |
| `fldeploy` | `fly deploy` | نشر Fly.io |
| `fllogs` | `fly logs` | سجلات Fly.io |
| `flssh` | `fly ssh console` | SSH إلى Fly.io |
| `flscale` | `fly scale count N` | تحجيم Fly.io |

### Gcp Gcloud

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `gcpid` | `gcloud config get-value project` | مشروع GCP الحالي |
| `gcpset` | `gcloud config set project PROJECT` | تعيين مشروع GCP |
| `gcpls` | `gcloud compute instances list` |_instances GCE |
| `gcpssh` | `gcloud compute ssh INSTANCE` | SSH إلى GCE |
| `gcpgke` | `gcloud container clusters list` | مجموعات GKE |
| `gcpgkecreds` | `gcloud container clusters get-credentials CLUSTER` | بيانات GKE |
| `gcpbq` | `bq ls` | مجموعات بيانات BigQuery |
| `gcpgsutil` | `gsutil ls` | مجموعات GCS |
| `gcpcp` | `gsutil cp FILE gs://BUCKET/` | نسخ إلى GCS |
| `gcpsync` | `gsutil -m rsync -r DIR gs://BUCKET/` | مزامنة إلى GCS |
| `gcprun` | `gcloud run services list` | خدمات Cloud Run |
| `gcpfn` | `gcloud functions list` | Cloud Functions |
| `gcpsql` | `gcloud sql instances list` | Cloud SQL |
| `gcplog` | `gcloud logging read FILTER --limit=50` | سجلات GCP |
| `gcpauth` | `gcloud auth login` | مصادقة GCP |

### Git Workflow

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `gg` | `git add . && git commit -m MSG && git push` | إضافة، تأكيد، دفع دفعة واحدة |
| `gclo` | `git clone https://github.com/USER/REPO` | استنساخ GitHub |
| `jclo` | `git clone https://github.com/juleshenry/REPO` | استنساخ juleshenry |
| `presto` | `git checkout --orphan && force-push` | تدميري: مسح كل السجل |
| `gwip` | `git add . && git commit -m 'wip: TIME'` | تأكيد عمل سريع (بدون دفع) |
| `gunwip` | `git reset --soft HEAD~1` | تراجع عن WIP |
| `gpristine` | `git reset --hard origin/BRANCH && git clean -fd` | إعادة تعيين كاملة للمطابقة البعيدة |
| `gtag` | `git tag -a TAG -m MSG && git push origin TAG` | إنشاء ودفع علامة |
| `gpr` | `gh pr create --title TITLE --fill` | إنشاء PR عبر gh |
| `gdiff-fancy` | `git diff --stat + git diff --shortstat` | ملخص فرق جميل |
| `gacp` | `git add . && git commit -m MSG && git push` | إضافة، تأكيد، دفع (مثل gg) |
| `ginit` | `git init && git add . && git commit -m 'Initial commit'` | تهيئة مستودع |
| `ghcl` | `git clone https://github.com/USER/REPO` | استنساخ من GitHub |
| `gbc` | `git checkout -b BRANCH` | إنشاء والانتقال لفرع |
| `gbdall` | `git branch -d B && git push origin --delete B` | حذف محلي + بعيد |
| `gundo` | `git reset --soft HEAD~1` | تراجع عن تأكيد |
| `gbs` | `git for-each-ref --sort=-committerdate` | فروع حسب آخر تعديل |
| `gquick` | `git add . && git commit -m 'Quick update: TIME' && git push` | تأكيد بطابع زمني |
| `gchanged` | `git diff --name-only HEAD~N..HEAD` | ملفات متغيرة |
| `gsearchtext` | `git log -S TEXT` | بحث في السجل |
| `gnew` | `git fetch origin && git checkout -b B origin/main` | فرع من origin/main |
| `gupdateall` | `git fetch --all && git pull` | جلب وسحب الكل |
| `greposize` | `git count-objects -vH` | حجم المستودع |
| `gfilesize` | `git ls-tree -r -t -l --full-name HEAD \| sort` | حجم الملفات |
| `glarge` | `git rev-list --objects --all \| ...` | أكبر blobs |
| `gsyncfork` | `git fetch upstream && merge upstream/main` | مزامنة الشوكة |
| `gsquash` | `git reset --soft HEAD~N && git commit -m MSG` | دمج N تأكيد |
| `gstats` | `git shortlog -sn --all --no-merges` | عدد التأكيدات |
| `garchive` | `git tag archive/B && delete branch` | أرشفة فرع كعلامة |
| `galias` | `alias \| grep '^g'` | جميع أسماء g المستعارة |
| `ginfo` | `repo name, branch, remote, last commit` | معلومات المستودع |
| `gbackup` | `tar -czf backup.tar.gz .` | نسخة احتياطية |

### Macos Power Tools

| الاسم المستعار | يشغّل | الوصف |
|-------|------|-------------|
| `caffeinate` | `caffeinate -d` | منع Mac من النوم |
| `hidefiles` | `defaults write com.apple.finder ... [مقتطع]

</div>
