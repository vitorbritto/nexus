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
#       ./nexus.sh [options] <port>
#
# Options:
#       --php           Start a webserver with PHP
#       --py            Start a webserver with Python
#
# Example:
#       Start a PHP webserver
#       $ ./nexus.sh --php 8080
#
# Alias:
#       alias nexus="bash ~/path/to/script/nexus.sh"
#
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# | OS SUPPORTED: MAC AND LINUX                                                |
# ------------------------------------------------------------------------------

if [ "$(uname)" == "Darwin" ]; then
	browser=open
	ip=$(ipconfig getifaddr en1)
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	browser=x-www-browser
	ip=$(LANG=C /sbin/ifconfig  | sed -ne $'/127.0.0.1/ ! { s/^[ \t]*inet[ \t]\\{1,99\\}\\(addr:\\)\\{0,1\\}\\([0-9.]*\\)[ \t\/].*$/\\2/p; }')
fi

# ------------------------------------------------------------------------------
# | FUNCTIONS                                                                  |
# ------------------------------------------------------------------------------

# Start webserver Function
nexus_start() {
	# Start an HTTP server from a directory, optionally specifying the port
	if [[ "${1}" == "-py" ]]; then
		local port="${3:-8000}"
		echo "HINT: Press CTRL+C to stop webserver"
		sleep 1 && $browser "http://localhost:${port}/" &
		# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
		# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
		python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
	fi

	# Start a PHP server from a directory, optionally specifying the port
	if [[ "${1}" == "-php" ]]; then
		local port="${3:-4000}"
		echo "HINT: Press CTRL+C to stop webserver"
		sleep 1 && $browser "http://${ip}:${port}/" &
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
