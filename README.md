# ipcheck

`ipcheck` is a small Bash CLI tool for querying IP geolocation information using the public API at https://get.geojs.io.

It supports:
- Pretty, colored output (with country flag emoji)
- Short / quiet modes for scripting
- Raw JSON output (compact or pretty-printed)
- Lookup of arbitrary IP addresses (`--ip`)
- Simple caching to avoid hammering the API
- Optional update check hook

## Features

- **Default output**  
  Full geolocation summary for your current public IP.

- **Short output**  
  ```bash
  ipcheck --short
  # 141.144.249.103 - Germany (DE) 🇩🇪

Quiet output (IP only)

ipcheck --quiet
# 141.144.249.103

Raw JSON / pretty JSON

ipcheck --raw
ipcheck --raw-pretty

Lookup a specific IP

ipcheck --ip 8.8.8.8
ipcheck --ip 1.1.1.1 --short

Installation
Requirements

bash

curl

jq

python3 (recommended: for IP validation + flag emoji)

Linux or macOS terminal

On Ubuntu / Debian:

sudo apt update
sudo apt install curl jq python3

Install as a global command

From the project directory:

chmod +x ipcheck
sudo cp ipcheck /usr/local/bin/ipcheck


Now you can run:

ipcheck

Usage
ipcheck v0.7

Usage: ipcheck [OPTIONS]

Fetch and display public IP geolocation information (using geojs.io).

Options:
  -i, --ip IP        Look up a specific IP instead of your own
  -s, --short        Show short output (IP, country, flag)
  -r, --raw          Output raw JSON from the API
      --raw-pretty   Output pretty-printed JSON
  -q, --quiet        Output only the IP address
      --no-flag      Disable country flag emoji
      --check-update Check for a newer ipcheck version (if UPDATE_URL is set)
  -h, --help         Show this help message and exit

