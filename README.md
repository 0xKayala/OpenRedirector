# OpenRedirector
`OpenRedirector` is a powerful automation tool for detecting OpenRedirect vulnerabilities in web applications. It combines the capabilities of two powerful tools - `ParamSpider` for mining parameters from web archives and `OpenRedireX` for fuzzing OpenRedirect issues. With `OpenRedirector`, you can easily scan any domain and quickly identify potential vulnerabilities, allowing you to take proactive steps to secure your web applications. Whether you are a security researcher or a web developer, `OpenRedirector` is an essential tool for your toolkit.

So why wait? Download `OpenRedirector` today and start securing your web applications against open redirect vulnerabilities!

# Screenshot
![image](https://user-images.githubusercontent.com/16838353/231228421-61f82713-39f7-4593-8fef-a66d1dd7d758.png)

# Output
![image](https://user-images.githubusercontent.com/16838353/231231594-e9b2dd9e-bc9b-4bdc-824c-cd73e9aff118.png)

# Install OpenRedirector

#### Note:
Download the Tools `ParamSpider` and `OpenRedireX` in order to use our `OpenRedirector` Tool without any issues. Links of those tools are provided in the below section. Make sure you download the above tools into the same directory and add or replace those paths in our tool as shown in the below example.

##### For Example:

python3 /path/to/ParamSpider/paramspider.py -d "$domain" -o /path/to/OpenRedirect/paramspider_output.txt (ParamSpider)
python3 /path/to/OpenRedireX/openredirex.py -l /path/to/OpenRedirect/paramspider_output.txt -p /path/to/OpenRedireX/payloads.txt (OpenRedireX)

### Usage

```sh
./OpenRedirector -h
```

This will display help for the tool. Here are the options it supports.


```console
OpenRedirector is a powerful automation tool for detecting OpenRedirect vulnerabilities in web applications

Usage: ./OpenRedirect.sh [options]

Options:
  -h, --help              Display help information
  -d, --domain <domain>   Domain to scan for open redirects
```  

### Steps to Install:
1. git clone https://github.com/0xKayala/OpenRedirector.git
2. cd OpenRedirector
3. chmod +x OpenRedirector.sh
4. ./OpenRedirector.sh

Tools included - [ParamSpider](https://github.com/devanshbatham/ParamSpider) and [OpenRedireX](https://github.com/devanshbatham/OpenRedireX)

Made by
`Satya Prakash` | `0xKayala` \
A `Security Researcher` and `Bug Hunter` \
About me on `about.me/satyakayala`
Subscribe me on `Youtube.com/@0xKayala`
