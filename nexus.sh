#!/usr/bin/env bash

# ------------------------------------------------------------------------------
#
# Program: yoda.sh
# Author:  Vitor Britto
#
# Description:
#       This is my personal READ LATER method.
#
# Important:
#       First of all, define where you want to save your "readlater" file
#       then make this script executable to easily run it.
#       $ chmod u+x yoda.sh
#
# Usage:
#       INSERT: ./yoda.sh 'NAME' 'http://URL'
#       VIEW:   ./yoda.sh [ -l, --list   ]
#       OPEN:   ./yoda.sh [ -o, --open   ]
#       HELP:   ./yoda.sh [ -h, --help   ]
#       EXPORT: ./yoda.sh [ -e, --export ]
#
# Assumptions:
#       - The url of interest is a simple one.
#
# Alias:
#       alias yoda="bash ~/path/to/script/yoda.sh"
#
# ------------------------------------------------------------------------------
# TODO: regex for grep on export bookmarks
# ------------------------------------------------------------------------------



# ------------------------------------------------------------------------------
# | FUNCTIONS                                                                  |
# ------------------------------------------------------------------------------

# Start webserver Function
nexus_start() {
    # Start an HTTP server from a directory, optionally specifying the port
    if [[ "${1}" == "--py" ]]; then
        local port="${3:-8000}"
        echo "HINT: Press CTRL+C to stop webserver"
        sleep 1 && open "http://localhost:${port}/" &
        # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
        # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
        python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
    fi

    # Start a PHP server from a directory, optionally specifying the port
    if [[ "${1}" == "--php" ]]; then
        local port="${3:-4000}"
        local ip=$(ipconfig getifaddr en1)
        echo "HINT: Press CTRL+C to stop webserver"
        sleep 1 && open "http://${ip}:${port}/" &
        php -S "${ip}:${port}"
    fi

}

# Help Function
nexus_help() {

cat <<EOT

------------------------------------------------------------------------------
NEXUS - Simple and fast method to start a web server
------------------------------------------------------------------------------

Usage:
    ./nexus.sh [options] <port>

Example:
    Start a PHP webserver
    $ ./nexus.sh --php 8080

Options:
    --php           Start a webserver with PHP
    --py            Start a webserver with Python

Documentation can be found at https://github.com/vitorbritto/nexus/

Copyright (c) Vitor Britto
Licensed under the MIT license.

------------------------------------------------------------------------------

EOT

}


# Initialize Nexus
nexus_start $*
