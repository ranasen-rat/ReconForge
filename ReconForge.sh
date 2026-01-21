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
        ██╔══██╗██╔══╝  ██║     ██║   ██║██║╚██╗██║
        ██║  ██║███████╗╚██████╗╚██████╔╝██║ ╚████║
        ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝

        ALL URL | JS | API | PARAMETER DISCOVERY ENGINE
EOF
echo -e "${RESET}"

echo -e "${CYAN}${BOLD}┌───────────────────────────────────────────────────────────┐${RESET}"
echo -e "${CYAN}${BOLD}│ Author   : Rana Sen (Pentester)                           │${RESET}"
echo -e "${CYAN}${BOLD}│ Mode     : Bug Bounty | Red Team | Web Recon              │${RESET}"
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
echo -e "  └─ getJS         → Deep JS endpoint extraction${RESET}"

echo
echo -e "${MAGENTA}${BOLD}[!] Recon Philosophy:${RESET} ${WHITE}More URLs = More Attack Surface${RESET}"
echo -e "${BLUE}${BOLD}[*] Legal Only | Stay Ethical | Happy Hunting${RESET}"
echo "-----------------@@@@@@@@@@--------------------"


read -p "Please Enter Your Domains or Files: " Domains

katana -list $Domains -silent -o katana.txt 2>/dev/null
echo "[+] katana done"

waymore -i $Domains -mode U -oU waymore.txt 2>/dev/null
echo "[+] waymore Done"

cat $Domains | hakrawler -d 5 -subs -s -i -plain > hakrawler.txt 2>/dev/null
echo "[+] hakrawler Done"

cat $Domains | waybackurls > waybackurls.txt 2>/dev/null
echo "[+] waybackurls Done"

cat domains.txt | urlfinder > urlfinder.txt 2>/dev/null
echo "[+] urlfinder Done"

gospider -S $Domains -d 10 -c 10 -t 50 | grep -oP 'https?://[^\s"]+' > gospider.txt 2>/dev/null
echo "[+] gospider Done"

mkdir -p results
paramspider -l $Domains > paramspider.txt 2>/dev/null
echo "[+] paramspider Done"

cat $Domains | gau --threads 5 --o gau.txt 2>/dev/null
echo "[+] gau done"

cat katana.txt waymore.txt hakrawler.txt waybackurls.txt urlfinder.txt gospider.txt results/paramspider.txt gau.txt | sort -u > all_urls.txt

echo "All URLs Find Successfully Done."

# subjs
cat $Domains | subjs > subjs.txt 2>/dev/null

# getJS
cat $Domains | getJS --complete --output getjs.txt 2>/dev/null

# merge endpoints
cat subjs.txt getjs.txt | sort -u > all_endpoints-js.txt
cat all_urls.txt all_endpoints-js.txt | sort -u > Final-URLs.txt

echo -e "${COLOR}[✔] Finished: $DOMAIN${NC}"
echo "--------------------------------------------------"

done

echo -e "${COLOR}[✔] Recon Completed Successfully!${NC}"

