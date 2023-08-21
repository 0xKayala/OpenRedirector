# OpenRedirector
`OpenRedirector` is a powerful automation tool for detecting OpenRedirect vulnerabilities in web applications. It combines the capabilities of two powerful tools - `ParamSpider` for mining parameters from web archives and `OpenRedireX` for fuzzing OpenRedirect issues. With `OpenRedirector`, you can easily scan any domain and quickly identify potential vulnerabilities, allowing you to take proactive steps to secure your web applications. Whether you are a security researcher or a web developer, `OpenRedirector` is an essential tool for your toolkit.

So why wait? Download our `OpenRedirector` today and start securing your web applications against open redirect vulnerabilities!

### Tools included:
[ParamSpider](https://github.com/devanshbatham/ParamSpider) `git clone https://github.com/devanshbatham/ParamSpider.git`<br><br>
[OpenRedireX](https://github.com/devanshbatham/OpenRedireX) `git clone https://github.com/devanshbatham/OpenRedireX.git`

# Screenshot
![image](https://user-images.githubusercontent.com/16838353/231228421-61f82713-39f7-4593-8fef-a66d1dd7d758.png)

# Output
![OpenRedirector](https://user-images.githubusercontent.com/16838353/235112718-117ab627-a270-453b-b7f6-09bb911e129c.gif)

# Install OpenRedirector

## Note:
Download the Tools `ParamSpider` and `OpenRedireX` in order to use our `OpenRedirector` Tool without any issues. Links of those tools are provided in the above section. Make sure you download both the tools into the same directory and open `OpenRedirector.sh` file with any editor and check the paths are matching to the location of the tools `ParamSpider` and `OpenRedireX`. If the paths are not matching then change them according to the tool paths of location on your pc as shown in the below example.


## Usage

```sh
openredirector -h
```

This will display help for the tool. Here are the options it supports.


```console
OpenRedirector is a powerful automation tool for detecting OpenRedirect vulnerabilities in web applications

Usage: openredirector [options]

Options:
  -h, --help              Display help information
  -d, --domain <domain>   Domain to scan for open redirects
```  

### Steps to Install:
1. git clone https://github.com/0xKayala/OpenRedirector.git
2. cd OpenRedirector
3. sudo chmod +x install.sh
4. ./install.sh
5. openredirector -h


Made by
`Satya Prakash` | `0xKayala` \
A `Security Researcher` and `Bug Hunter` \
About me on `about.me/satyakayala`
Subscribe me on `Youtube.com/@0xKayala`
