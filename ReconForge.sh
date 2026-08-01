#!/bin/bash

clear

RED="\e[31m"
GREEN="\e[32m"
CYAN="\e[36m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
WHITE="\e[97m"
RESET="\e[0m"
BOLD="\e[1m"

echo -e "${RED}${BOLD}"
cat << "EOF"
██████╗ ███████╗███╗   ██╗████████╗███████╗███████╗████████╗
██╔══██╗██╔════╝████╗  ██║╚══██╔══╝██╔════╝██╔════╝╚══██╔══╝
██████╔╝█████╗  ██╔██╗ ██║   ██║   █████╗  ███████╗   ██║   
██╔═══╝ ██╔══╝  ██║╚██╗██║   ██║   ██╔══╝  ╚════██║   ██║   
██║     ███████╗██║ ╚████║   ██║   ███████╗███████║   ██║   
╚═╝     ╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚══════╝   ╚═╝   

        ██████╗ ███████╗ ██████╗ ██████╗ ███╗   ██╗
        ██╔══██╗██╔════╝██╔════╝██╔═══██╗████╗  ██║
        ██████╔╝█████╗  ██║     ██║   ██║██╔██╗ ██║
        ██████╔╝██╔══╝  ██║     ██║   ██║██║╚██╗██║
        ██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║
        ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝

        ALL URL | JS | API | PARAMETER DISCOVERY ENGINE
EOF
echo -e "${RESET}"

echo -e "${CYAN}${BOLD}┌───────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}${BOLD}│ Author   : Rana Sen (Pentester)                           │${RESET}"
echo -e "${CYAN}${BOLD}│ Mode     : Bug Bounty | Web Recon                         │${RESET}"
echo -e "${CYAN}${BOLD}│ Focus    : URLs • Endpoints • APIs • JS • Parameters      │${RESET}"
echo -e "${CYAN}${BOLD}│ Method   : Passive + Active Recon                         │${RESET}"
echo -e "${CYAN}${BOLD}└───────────────────────────────────────────────────────────┘${RESET}"

echo
echo -e "${GREEN}${BOLD}[+] Loaded Recon Toolchain:${RESET}"

echo -e "${YELLOW}  ├─ katana        → Fast crawler & endpoint discovery"
echo -e "  ├─ waymore       → Wayback + CommonCrawl URLs"
echo -e "  ├─ hakrawler     → Depth-based crawling"
echo -e "  ├─ waybackurls   → Historical endpoints"
echo -e "  ├─ urlfinder     → Pattern-based URL extraction"
echo -e "  ├─ gospider      → JS & dynamic crawl"
echo -e "  ├─ gau           → Archive URL harvesting"
echo -e "  ├─ paramspider   → Parameter discovery"
echo -e "  ├─ subjs         → JavaScript file collection"
echo -e "  ├─ getJS         → Deep JS endpoint extraction"
echo -e "  └─ arjun         → Hidden parameter brute-force${RESET}"

echo
echo -e "${MAGENTA}${BOLD}[!] Recon Philosophy:${RESET} ${WHITE}More URLs = More Attack Surface${RESET}"
echo -e "${BLUE}${BOLD}[*] Legal Only | Stay Ethical | Happy Hunting${RESET}"
echo "-----------------@@@@@@@@@@--------------------"

# --- Ask for the domain list file ---
read -p "Please enter the path to your domain list file: " domain_file

if [[ ! -f "$domain_file" ]]; then
    echo -e "${RED}${BOLD}Error: File '$domain_file' not found!${RESET}"
    exit 1
fi

mkdir -p results

# --- Run all reconnaissance tools ---
katana -list "$domain_file" -silent -o results/katana.txt
echo "[+] katana done"

waymore -i "$domain_file" -mode U -oU results/waymore.txt
echo "[+] waymore Done"

cat "$domain_file" | hakrawler -d 5 -subs -s -i -plain > results/hakrawler.txt
echo "[+] hakrawler Done"

cat "$domain_file" | waybackurls > results/waybackurls.txt
echo "[+] waybackurls Done"

cat "$domain_file" | urlfinder > results/urlfinder.txt
echo "[+] urlfinder Done"

gospider -S "$domain_file" -d 10 -c 10 -t 50 | grep -oP 'https?://[^\s"]+' > results/gospider.txt
echo "[+] gospider Done"

paramspider -l "$domain_file" > results/paramspider.txt
echo "[+] paramspider Done"

> results/gau.txt
while IFS= read -r domain; do
    gau --threads 5 --o results/gau_tmp.txt "$domain" 2>/dev/null
    cat results/gau_tmp.txt >> results/gau.txt
    rm -f results/gau_tmp.txt
done < "$domain_file"
echo "[+] gau done"

# --- Merge all URL sources ---
cat results/katana.txt results/waymore.txt results/hakrawler.txt \
    results/waybackurls.txt results/urlfinder.txt results/gospider.txt \
    results/paramspider.txt results/gau.txt | sort -u > results/all_urls.txt
echo "All URLs collected."

# --- Run Arjun on a subset of URLs (first 200) to discover hidden parameters ---
if command -v arjun &> /dev/null; then
    echo "[+] Running Arjun on top 200 URLs for parameter discovery (this may take a while)..."
    head -n 200 results/all_urls.txt > results/arjun_input.txt
    arjun -l results/arjun_input.txt -oT results/arjun_params.json -t 20 -m 50 2>/dev/null
    # Extract discovered parameterized URLs from Arjun's JSON output
    if [[ -f results/arjun_params.json ]]; then
        # Parse JSON to extract URLs with parameters found (arjun outputs each URL with discovered params)
        # We'll extract the 'url' field from each result, which already includes parameters.
        jq -r '.[] | .url' results/arjun_params.json > results/arjun_urls.txt 2>/dev/null
        if [[ -s results/arjun_urls.txt ]]; then
            echo "[+] Arjun discovered $(wc -l < results/arjun_urls.txt) parameterized URLs."
        else
            echo "[!] Arjun found no new parameters."
            touch results/arjun_urls.txt
        fi
    else
        echo "[!] Arjun did not produce output."
        touch results/arjun_urls.txt
    fi
else
    echo "[!] Arjun not installed. Skipping parameter brute-force."
    touch results/arjun_urls.txt
fi

# --- JS endpoint extraction ---
cat "$domain_file" | subjs > results/subjs.txt
echo "[+] subjs done"

cat "$domain_file" | getJS --complete --output results/getjs.txt
echo "[+] getJS done"

# Merge JS endpoints
cat results/subjs.txt results/getjs.txt | sort -u > results/all_endpoints-js.txt

# --- Final merge: include Arjun results, all URLs, and JS endpoints ---
cat results/all_urls.txt results/all_endpoints-js.txt results/arjun_urls.txt | sort -u > results/Final-URLs.txt

echo -e "${GREEN}[✔] Final file created: results/Final-URLs.txt${RESET}"

# --- Cleanup: delete all intermediate files, keep only Final-URLs.txt ---
echo "Cleaning up intermediate files..."
find results -type f ! -name "Final-URLs.txt" -delete
rm -f all_urls.txt all_endpoints-js.txt arjun_input.txt 2>/dev/null

echo -e "${GREEN}[✔] Recon Completed Successfully!${RESET}"
echo -e "${CYAN}Final output: results/Final-URLs.txt${RESET}"
