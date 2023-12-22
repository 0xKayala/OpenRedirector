#!/bin/bash

# ASCII art
echo -e "\e[91m"
cat << "EOF"
   ____                   ____           ___                __            
  / __ \____  ___  ____  / __ \___  ____/ (_)_______  _____/ /_____  _____
 / / / / __ \/ _ \/ __ \/ /_/ / _ \/ __  / / ___/ _ \/ ___/ __/ __ \/ ___/
/ /_/ / /_/ /  __/ / / / _, _/  __/ /_/ / / /  /  __/ /__/ /_/ /_/ / /    
\____/ .___/\___/_/ /_/_/ |_|\___/\__,_/_/_/   \___/\___/\__/\____/_/   v1.0.0  
    /_/                                                                   
                                     Made by Satya Prakash (0xKayala)                                                
EOF
echo -e "\e[0m"

# Help menu
display_help() {
    echo -e "OpenRedirector is a powerful automation tool for detecting Open Redirect vulnerabilities in web applications\n\n"
    echo -e "Usage: $0 [options]\n\n"
    echo "Options:"
    echo "  -h, --help              Display help information"
    echo "  -d, --domain <domain>   Domain to scan for open-redirect vulnerabilities"
    echo "  -f, --file <filename>   File to scan for open-redirect vulnerabilities"
    exit 0
}

# Get the current user's home directory
home_dir=$(eval echo ~$USER)

# Check if ParamSpider is already cloned and installed
if [ ! -d "$home_dir/ParamSpider" ]; then
    echo "Cloning ParamSpider..."
    git clone https://github.com/0xKayala/ParamSpider "$home_dir/ParamSpider"
fi

# Check if OpenRedireX is already cloned and installed
if ! command -v openredirex &> /dev/null; then
    echo "Installing OpenRedireX..."
    git clone https://github.com/devanshbatham/openredirex "$home_dir/openredirex"
    cd "$home_dir/openredirex" || exit
    sudo chmod +x setup.sh
    ./setup.sh
fi

# Check if httpx is installed, if not, install it
if ! command -v httpx &> /dev/null; then
    echo "Installing httpx..."
    go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
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
        -f|--file)
            filename="$2"
            shift
            shift
            ;;
        *)
            echo "Unknown option: $key"
            display_help
            ;;
    esac
done

# Step 2: Ask the user to enter the domain name or specify the file
if [ -z "$domain" ] && [ -z "$filename" ]; then
    echo "Please provide a domain with -d or a file with -f option."
    display_help
fi

# Combined output file for all domains
output_file="output/allurls.txt"

# Step 3: Get the vulnerable parameters based on user input
if [ -n "$domain" ]; then
    echo "Running ParamSpider on $domain"
    python3 "$home_dir/ParamSpider/paramspider.py" -d "$domain" --exclude png,jpg,gif,jpeg,swf,woff,gif,svg --level high --quiet -o "output/$domain.txt"
elif [ -n "$filename" ]; then
    echo "Running ParamSpider on URLs from $filename"
    while IFS= read -r line; do
        python3 "$home_dir/ParamSpider/paramspider.py" -d "$line" --exclude png,jpg,gif,jpeg,swf,woff,gif,svg --level high --quiet -o "output/$line.txt"
        cat "output/$line.txt" >> "$output_file"  # Append to the combined output file
    done < "$filename"
fi

# Step 4: Check whether URLs were collected or not
if [ ! -s "output/$domain.txt" ] && [ ! -s "$output_file" ]; then
    echo "No URLs Found. Exiting..."
    exit 1
fi

# Step 5: Run the OpenRedireX tool on the collected URLs
echo "Running OpenRedireX on $domain.txt"
if [ -n "$domain" ]; then
    cat "output/$domain.txt" | httpx -silent -mc 200,301,302,403 | openredirex
elif [ -n "$filename" ]; then
    cat "$output_file" | httpx -silent -mc 200,301,302,403 | openredirex
fi

# Step 5: End with a general message as the scan is completed
echo "Scan is completed - Happy Hunting"
