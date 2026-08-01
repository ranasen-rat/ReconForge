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
