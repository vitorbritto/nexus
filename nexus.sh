#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: nexus.sh
# Author:  Vitor Britto
#
# Description:
#       Nexus is a simple and fast method to start a web server
#
# Important:
#       Make this script executable to easily run it.
#       $ chmod u+x nexus.sh
#
# Usage:
#       ./nexus.sh [options] [commands] <port>
#
# Options:
#       -l, --linux     Using Linux
#       -m, --mac       Using Mac
#       -h, --help      Output this help text
#
# Commands:
#       php             Start a webserver with PHP
#       py              Start a webserver with Python
#
# Example:
#       Start a PHP webserver
#       $ ./nexus.sh -m php 8080
#
# Alias:
#       alias nexuspy="bash ~/path/to/script/nexus.sh -m py 8080"
#       alias nexusphp="bash ~/path/to/script/nexus.sh -m php 8080"
#
# ------------------------------------------------------------------------------

OPEN_MAC="/usr/bin/open"
OPEN_GNU="x-www-browser"



# ------------------------------------------------------------------------------
# | FUNCTIONS                                                                  |
# ------------------------------------------------------------------------------

# Help Function
nexus_help() {

cat <<EOT

------------------------------------------------------------------------------
NEXUS - Simple and fast method to start a web server
------------------------------------------------------------------------------

Usage:
      ./nexus.sh [options] [commands] <port>

Options:
      -l, --linux     Using Linux
      -m, --mac       Using Mac
      -h, --help      Output this help text

Commands:
      php             Start a webserver with PHP
      py              Start a webserver with Python

Example:
      Start a PHP webserver
      $ ./nexus.sh -m php 8080

Alias:
      alias nexuspy="bash ~/path/to/script/nexus.sh -m py 8080"
      alias nexusphp="bash ~/path/to/script/nexus.sh -m php 8080"


Documentation can be found at https://github.com/vitorbritto/nexus/

Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}

# Start a Web Server on Mac
nexus_mac() {
    # Start an HTTP server from a directory, optionally specifying the port
    if [[ "${2}" == "py" ]]; then
        local PORT="${4:-8000}"
        echo "HINT: Press CTRL+C to stop webserver"
        sleep 1 && $OPEN_MAC "http://localhost:${PORT}/" &
        # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
        # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
        python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$PORT"
    fi

    if [[ "${2}" == "php" ]]; then
        local PORT="${4:-4000}"
        local IP=$(ipconfig getifaddr en1)
        echo "HINT: Press CTRL+C to stop webserver"
        sleep 1 && $OPEN_MAC "http://${IP}:${PORT}/" &
        php -S "${IP}:${PORT}"
    fi
    exit
}

# Start a Web Server on GNU/Linux
nexus_linux() {
    # Start an HTTP server from a directory, optionally specifying the port
    if [[ "${2}" == "py" ]]; then
        local PORT="${4:-8000}"
        echo "HINT: Press CTRL+C to stop webserver"
        sleep 1 && $OPEN_GNU "http://localhost:${PORT}/" &
        # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
        # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
        python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$PORT"
    fi

    if [[ "${2}" == "php" ]]; then
        local PORT="${4:-4000}"
        local IP=$(LANG=C /sbin/ifconfig  | sed -ne $'/127.0.0.1/ ! { s/^[ \t]*inet[ \t]\\{1,99\\}\\(addr:\\)\\{0,1\\}\\([0-9.]*\\)[ \t\/].*$/\\2/p; }')
        echo "HINT: Press CTRL+C to stop webserver"
        sleep 1 && $OPEN_GNU "http://${IP}:${PORT}/" &
        php -S "${IP}:${PORT}"
    fi
    exit
}

# Main Function
nexus_main() {

    # Show help option
    if [[ "${1}" == "-h" || "${1}" == "--help" ]]; then
        nexus_help ${1}
        exit
    fi

    if [[ "${1}" == "-l" || "${1}" == "--linux" ]]; then
        nexus_linux $*
        exit
    fi

    if [[ "${1}" == "-m" || "${1}" == "--mac" ]]; then
        nexus_mac $*
        exit
    fi

}



# Initialize Nexus
nexus_main $*
