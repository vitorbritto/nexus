![Nexus Logo](src/nexus.jpg "Nexus")


## Welcome

Nexus is a simple and fast method to start a web server.

> Note: tested on **Linux** and **Mac**.

## Requirements

- [PHP v5.4+](http://www.php.net/)
- [Python v2.6+](https://www.python.org/)

> **Important:** make sure you start the web server inside the current project directory.


## Installation

```bash

# 1. Clone this repository
$ git clone git://github.com/vitorbritto/nexus.git

# 2. Place the `nexus.sh` script wherever you want

# 3. Make the script executable
$ chmod u+x path/to/nexus.sh

```


## Usage

    $ ./nexus.sh [options] <port>

> Note: `<port>` is optional

### Options:
      --php     start a web server with PHP
      --py      start a web server with Python


## Bonus

If you prefer, put the following **alias** inside your `.bashrc` file:

    alias nexus="bash ~/path/to/script/nexus.sh"

Now, you can simply run:

    $ nexus [options] <port>


## License

[MIT License](http://vitorbritto.mit-license.org/) © Vitor Britto
