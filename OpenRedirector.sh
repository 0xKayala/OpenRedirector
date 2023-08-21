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
    echo -e "OpenRedirector is a powerful automation tool for detecting Open Redirect vulnerabilities in web applications\n\n"
    echo -e "Usage: $0 [options]\n\n"
    echo "Options:"
    echo "  -h, --help              Display help information"
    echo "  -d, --domain <domain>   Domain to scan for open redirects"
    exit 0
}

# Get the current user's home directory
home_dir=$(eval echo ~$USER)

# Check if ParamSpider is already cloned and installed
if ! command -v paramspider &> /dev/null; then
    echo "Installing ParamSpider..."
    git clone https://github.com/devanshbatham/paramspider.git "$home_dir/paramspider"
    cd "$home_dir/paramspider" || exit
    pip install .
fi

# Check if OpenRedireX is already cloned and installed
if ! command -v openredirex &> /dev/null; then
    echo "Installing OpenRedireX..."
    git clone https://github.com/devanshbatham/openredirex "$home_dir/openredirex"
    cd "$home_dir/openredirex" || exit
    sudo chmod +x setup.sh
    ./setup.sh
fi

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
    echo "Enter the domain name: target.com"
    read domain
fi

# Step 3: Get the vulnerable parameters of the given domain name using ParamSpider tool and save the output into a text file
echo "Running ParamSpider on $domain"
paramspider -d "$domain"

# Check if ParamSpider found any unique URLs
unique_urls=$(grep -oP '(?<=\=)[^&]+' results/$domain.txt | sort -u | wc -l)
if [ $unique_urls -eq 0 ]; then
    echo "No URLs Found"
    exit 1
fi

# Step 4: Run the OpenRedireX tool on the above text file
echo "Running OpenRedireX on $domain.txt"
cat results/$domain.txt | openredirex -p $home_dir/openredirex/payloads.txt -k "FUZZ" -c 50

# Step 5: End with general message as the scan is completed
echo "Scan is completed - Happy Fuzzing"
