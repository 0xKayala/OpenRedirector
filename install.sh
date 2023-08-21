#!/bin/bash

# Rename the OpenRedirector.sh file to OpenRedirector
mv OpenRedirector.sh openredirector

# Move the OpenRedirector file to /usr/local/bin
sudo mv openredirector /usr/local/bin/

# Make the OpenRedirector file executable
sudo chmod +x /usr/local/bin/openredirector

echo "OpenRedirector has been installed successfully! Now Enter the command 'openredirector' to run the tool."
