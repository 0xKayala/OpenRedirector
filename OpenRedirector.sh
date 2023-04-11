#!/bin/bash

# ASCII art
echo -e "\e[91m
#   _____                 ______         _ _               _             
#  |  _  |                | ___ \       | (_)             | |            
#  | | | |_ __   ___ _ __ | |_/ /___  __| |_ _ __ ___  ___| |_ ___  _ __ 
#  | | | | '_ \ / _ \ '_ \|    // _ \/ _\` | | '__/ _ \/ __| __/ _ \| '__|
#  \ \_/ / |_) |  __/ | | | |\ \  __/ (_| | | | |  __/ (__| || (_) | |   
#   \___/| .__/ \___|_| |_\_| \_\___|\__,_|_|_|  \___|\___|\__\___/|_|   
#        | |                                                             
#        |_|             Made by Satya Prakash (0xKayala)                                                
\e[0m"

# Help menu
display_help() {
    echo -e "OpenRedirector is a powerful automation tool for detecting OpenRedirect vulnerabilities in web applications\n\n"
    echo -e "Usage: $0 [options]\n\n"
    echo "Options:"
    echo "  -h, --help              Display help information"
    echo "  -d, --domain <domain>   Domain to scan for open redirects"
    exit 0
}

# Step 1: Parse command line arguments
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -h|--help)
            display_help
            ;;
        -d|--domain)
            domain="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option: $key"
            display_help
            ;;
    esac
done

# Step 2: Ask the user to enter the domain name
if [ -z "$domain" ]; then
    echo "Enter the domain name: "
    read domain
fi

# Step 3: Get the vulnerable parameters of the given domain name using ParamSpider tool and save the output into a text file
echo "Running ParamSpider on $domain"
python3 /home/kali/ParamSpider/paramspider.py -d "$domain" -o /home/kali/OpenRedirector/paramspider_output.txt

# Step 4: Run the openredirex.py tool on the above text file
echo "Running openredirex.py on paramspider_output.txt"
python3 /home/kali/OpenRedireX/openredirex.py -l /home/kali/OpenRedirector/paramspider_output.txt -p /home/kali/OpenRedireX/payloads.txt

# Step 5: End with general message as the scan is completed
echo "Scan is completed."
