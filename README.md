# ReconForge
# 🔍 Advanced URL & Endpoint Recon Framework

An **automated reconnaissance framework** for **Bug Bounty hunters and Penetration Testers** that discovers **URLs, APIs, JavaScript endpoints, and parameters** using multiple passive and active recon techniques.

This script aggregates results from several industry‑standard tools and produces a **clean, deduplicated final attack‑surface list**.

---

## 🚀 Features

* 🔎 Full URL & endpoint discovery
* 🧠 Passive + Active reconnaissance
* 📜 Historical URLs from archives
* 📦 JavaScript & API endpoint extraction
* 🧩 Parameter discovery for fuzzing
* ⚡ Fast, automated multi‑tool execution
* 🧹 Clean & deduplicated output
* 🖥️ Terminal‑friendly professional banner

---

## 🛠 Tools Used

| Category       | Tools                             |
| -------------- | --------------------------------- |
| Crawling       | `katana`, `hakrawler`, `gospider` |
| Archive URLs   | `waybackurls`, `waymore`, `gau`   |
| URL Extraction | `urlfinder`                       |
| Parameters     | `paramspider`                     |
| JavaScript     | `subjs`, `getJS`                  |

---

## 🧩 Installation

### ✅ Requirements

* Linux (Kali Linux recommended)
* Bash `>= 4`
* Go `>= 1.20`
* Python `>= 3.8`
* Git

---

### 🔧 System Dependencies

```bash
sudo apt update
sudo apt install -y git curl wget jq python3 python3-pip golang
```

---

### 📦 Go‑Based Tools

```bash
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/hakluke/hakrawler@latest
go install github.com/jaeles-project/gospider@latest
go install -v github.com/edoardottt/cariddi/cmd/cariddi@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/tomnomnom/gf@latest
go install github.com/projectdiscovery/urlfinder/cmd/urlfinder@latest
go install github.com/lc/subjs@latest
go install github.com/003random/getJS@latest
```

Add Go tools copy our bin PATH:

```bash
sudo cd ~/go/bin
sudo cp * /usr/bin
```

---

### 🐍 Python‑Based Tools

```bash
pip3 install waymore
pip3 install paramspider
```

---

### 🔍 Verify Installation

```bash
katana -h
hakrawler -h
gospider -h
cariddi -h
waybackurls
gau -h
subjs -h
urlfinder -h
waymore -h
paramspider -h
getJS -h
```

---

## ▶️ Usage

```bash
chmod +x ReconForge.sh
./ReconForge.sh
```

Input:

* Single domain:

  ```
  example.com
  ```
* Or file with domains:

  ```
  domains.txt
  ```

---

## 📤 Output Files

| File              | Description              |
| ----------------- | ------------------------ |
| `katana.txt`      | Katana crawl results     |
| `waymore.txt`     | Archived URLs            |
| `hakrawler.txt`   | Crawled endpoints        |
| `waybackurls.txt` | Wayback URLs             |
| `urlfinder.txt`   | Pattern‑based URLs       |
| `gospider.txt`    | JS & dynamic URLs        |
| `gau.txt`         | Archive harvested URLs   |
| `paramspider.txt` | Parameters               |
| `subjs.txt`       | JavaScript files         |
| `getjs.txt`       | JS endpoints             |
| `all_urls.txt`    | Merged URLs              |
| `Final-URLs.txt`  | **Final attack surface** |

---

## 🧠 Recon Philosophy

> **More URLs = More Attack Surface**
> Maximum coverage leads to maximum findings.

---

## ⚠️ Disclaimer

This tool is intended **only for educational purposes and authorized security testing**.
Unauthorized scanning is illegal and unethical.

---

## 👤 Author

**Rana Sen**
Pentester | Bug Bounty Hunter | Red Team
Focused on Web, API & JavaScript Security

---
