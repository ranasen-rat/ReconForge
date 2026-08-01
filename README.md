```
# ReconForge
# 🔍 Advanced URL & Endpoint Recon Framework

An **automated reconnaissance framework** for **Bug Bounty hunters and Penetration Testers** that discovers **URLs, APIs, JavaScript endpoints, and hidden parameters** using multiple passive and active recon techniques.

This script aggregates results from several industry‑standard tools and produces a **clean, deduplicated, final attack‑surface list** – all intermediate files are automatically removed, leaving only the final result.

---

## 🚀 Features

* 🔎 Full URL & endpoint discovery  
* 🧠 Passive + Active reconnaissance  
* 📜 Historical URLs from archives (Wayback, CommonCrawl)  
* 📦 JavaScript & API endpoint extraction  
* 🧩 Hidden parameter brute‑force with **Arjun**  
* ⚡ Fast, automated multi‑tool execution  
* 🧹 Clean & deduplicated output – only `Final-URLs.txt` survives  
* 🖥️ Terminal‑friendly professional banner  

---

## 🛠 Tools Used

| Category            | Tools                                                                   |
| ------------------- | ----------------------------------------------------------------------- |
| **Crawling**        | `katana`, `hakrawler`, `gospider`                                       |
| **Archive URLs**    | `waybackurls`, `waymore`, `gau`                                         |
| **URL Extraction**  | `urlfinder`                                                             |
| **Parameters**      | `paramspider` (passive) + **`arjun`** (active brute‑force)             |
| **JavaScript**      | `subjs`, `getJS`                                                        |
| **Parsing**         | `jq` (for Arjun JSON output)                                            |

---

## 🧩 Installation

### ✅ System Requirements

* Linux (Kali Linux recommended)  
* Bash `>= 4`  
* Go `>= 1.20`  
* Python `>= 3.8`  
* Git  

### 🔧 System Dependencies

```bash
sudo apt update
sudo apt install -y git curl wget jq python3 python3-pip golang
```

### 📦 Go‑Based Tools

```bash
go install github.com/projectdiscovery/katana/cmd/katana@latest
go install github.com/hakluke/hakrawler@latest
go install github.com/jaeles-project/gospider@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install github.com/projectdiscovery/urlfinder/cmd/urlfinder@latest
go install github.com/lc/subjs@latest
go install github.com/003random/getJS@latest
```

> **Note:** `urlfinder` is now maintained by ProjectDiscovery – use the above command.

Copy all binaries to your `PATH` (optional but recommended):

```bash
sudo cp ~/go/bin/* /usr/local/bin/
```

### 🐍 Python‑Based Tools

```bash
pip3 install waymore
pip3 install paramspider
pip3 install arjun
```

### 🔍 Verify Installation

```bash
katana -h
hakrawler -h
gospider -h
waybackurls
gau -h
subjs -h
urlfinder -h
waymore -h
paramspider -h
getJS -h
arjun -h
jq --version
```

---

## ▶️ Usage

1. **Clone** the repository (or download `ReconForge.sh`).
2. Make it executable:
   ```bash
   chmod +x ReconForge.sh
   ```
3. Run the script:
   ```bash
   ./ReconForge.sh
   ```
4. When prompted, enter the **path to a file** containing one domain per line (e.g., `domains.txt`).

Example `domains.txt`:
```
example.com
api.test.org
sub.example.net
```

The script will:
- Launch all reconnaissance tools.
- Merge and deduplicate results.
- Run **Arjun** on the **first 200 URLs** to discover hidden parameters.
- Produce a single final file: `results/Final-URLs.txt`.
- **Automatically delete all intermediate files** – only `Final-URLs.txt` remains.

---

## 📤 Output

After completion, your directory will look like:

```
.
├── ReconForge.sh
├── domains.txt
└── results/
    └── Final-URLs.txt   # <-- your final attack surface
```

### Intermediate Files (Generated then Deleted)

| File               | Description                         |
| ------------------ | ----------------------------------- |
| `katana.txt`       | Katana crawl results                |
| `waymore.txt`      | Archived URLs                       |
| `hakrawler.txt`    | Crawled endpoints                   |
| `waybackurls.txt`  | Wayback URLs                        |
| `urlfinder.txt`    | Pattern‑based URLs                  |
| `gospider.txt`     | JS & dynamic URLs                   |
| `gau.txt`          | Archive harvested URLs              |
| `paramspider.txt`  | Passive parameters                  |
| `subjs.txt`        | JavaScript files                    |
| `getjs.txt`        | JS endpoints                        |
| `arjun_input.txt`  | Subset of URLs fed to Arjun         |
| `arjun_params.json`| Arjun raw output                    |
| `arjun_urls.txt`   | Parameterized URLs from Arjun       |
| `all_urls.txt`     | Merged URL list                     |
| `all_endpoints-js.txt` | Merged JS endpoints             |

> **Note:** All these files are **deleted** at the end – only `Final-URLs.txt` persists.

---

## ⚙️ Customisation

- **Arjun scan size**: Edit the `head -n 200` line in the script to scan more/less URLs (e.g., `head -n 500`). More URLs = slower but more thorough.
- **Arjun threads**: Adjust `-t 20` in the `arjun` command to increase/decrease parallelism.
- **Keep intermediate files**: Comment out the `find results ... -delete` line to preserve all outputs for debugging.

---

## 🧠 Recon Philosophy

> **More URLs = More Attack Surface**  
> Maximum coverage leads to maximum findings.  
> This framework combines both passive archives and active crawling to give you the widest possible attack surface.

---

## ⚠️ Disclaimer

This tool is intended **only for educational purposes and authorized security testing**.  
Unauthorized scanning is illegal and unethical. Use it responsibly and only on targets you own or have explicit permission to test.

---

## 👤 Author

**Rana Sen**  
Pentester | Bug Bounty Hunter | Red Team  
Focused on Web, API & JavaScript Security  

---

## 🤝 Contributions

Found a bug? Want to add a new tool? Open an issue or submit a pull request. All contributions are welcome!

---

## 📄 License

This project is licensed under the **MIT License** – see the [LICENSE](LICENSE) file for details.

---

**Happy Hunting!** 🕵️‍♂️
```

---

You can save this as `README.md` in your project folder. It's accurate, up‑to‑date, and ready to share.
