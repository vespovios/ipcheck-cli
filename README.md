# ipcheck-cli

<p align="center">
  <a href="https://github.com/vespovios/homebrew-ipcheck">
    <img src="https://img.shields.io/badge/Homebrew-ipcheck_cli-ffbf00?logo=homebrew&logoColor=white&labelColor=3f3f3f" alt="Homebrew tap">
  </a>
  <a href="https://github.com/vespovios/ipcheck-cli">
    <img src="https://img.shields.io/github/v/release/vespovios/ipcheck-cli" alt="Latest release">
  </a>
  <a href="https://github.com/vespovios/ipcheck-cli/releases">
    <img src="https://img.shields.io/github/downloads/vespovios/ipcheck-cli/total" alt="Downloads">
  </a>
  <a href="https://github.com/vespovios/ipcheck-cli/blob/main/LICENSE">
    <img src="https://img.shields.io/github/license/vespovios/ipcheck-cli" alt="License">
  </a>
  <a href="https://github.com/vespovios/ipcheck-cli/actions/workflows/ci.yml">
    <img src="https://github.com/vespovios/ipcheck-cli/actions/workflows/ci.yml/badge.svg" alt="CI status">
  </a>
  <a href="https://github.com/vespovios/ipcheck-cli">
    <img src="https://komarev.com/ghpvc/?username=vespovios&repo=ipcheck-cli&color=0d6efd&label=Profile%20views" alt="Profile views">
  </a>
</p>

<p align="center">
  <b>macOS Installation (Homebrew)</b><br>
  <code>brew install vespovios/ipcheck/ipcheck</code>
</p>

<p align="center">
  <b>Ubuntu / Debian Installation</b><br>
  <code>curl -sL https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/install.sh | bash</code>
</p>

<p align="center">
  <sub>Alternatively, download the script manually and place <code>ipcheck</code> in <code>/usr/local/bin</code>.</sub>
</p>


`ipcheck` is a lightweight Bash CLI tool for querying IP geolocation information using the public API at **https://get.geojs.io**.

It supports:

- 🌈 Pretty, colored terminal output (with country flag emoji)
- 🌍 Shows both your IPv4 **and** IPv6 address on dual-stack connections
- ✨ Short / quiet modes for scripting
- 🧩 Raw JSON output (compact or pretty-printed)
- 🔎 Lookup of arbitrary IP addresses (`--ip`)
- ⚡ Local caching to avoid repeated API calls
- 🔔 Optional update checker (`--check-update`)
- 🛠 Works on Linux and macOS

---

## 🚀 Features

### **Full output (default)**  
Displays a full geolocation summary for your current public IP.

On a dual-stack connection both addresses are listed:

```bash
ipcheck
```

```
🌍  Public IP Information 🇩🇪
-----------------------------------------
IPv4 Address:     88.198.32.117
IPv6 Address:     2a01:4f8:c17:4a1:2b3c:9d8e:7f60:1a2b
Country:          Germany (DE)
Region:           Berlin
City:             Berlin
ISP:              Hetzner Online GmbH
Timezone:         Europe/Berlin
Latitude:         52.52
Longitude:        13.4
```

If only one address family is reachable, the original single `IP Address:`
line is shown instead.

> **Why two hosts?** `get.geojs.io` only reports the address of the connection it
> received, so on a dual-stack host it usually returns your IPv6 address and the
> IPv4 one stays invisible. `ipcheck` therefore also queries the family-specific
> GeoJS hosts `ipv4.geojs.io` and `ipv6.geojs.io`. `ipv6.geojs.io` is AAAA-only,
> so it simply fails on IPv4-only networks and no address is reported for it.

### **Short output**
```bash
ipcheck --short
# 88.198.32.117, 2a01:4f8:c17:4a1:2b3c:9d8e:7f60:1a2b - Germany (DE) 🇩🇪
```

### **Quiet output (IP only)**
```bash
ipcheck --quiet
# 88.198.32.117
```

### **Every address, one per line**
```bash
ipcheck --all-ips --quiet
# 88.198.32.117
# 2a01:4f8:c17:4a1:2b3c:9d8e:7f60:1a2b
```

### **Restrict to one address family**
```bash
ipcheck --ipv4
ipcheck --ipv6
```

### **Raw JSON / pretty JSON**
```bash
ipcheck --raw
ipcheck --raw-pretty
```

`--raw` and `--raw-pretty` print the primary response only, so their output
shape is unchanged. Use `ipcheck --all-ips --quiet` to script against both.

### **Lookup a specific IP**
```bash
ipcheck --ip 8.8.8.8
ipcheck --ip 2606:4700:4700::1111
ipcheck --ip 1.1.1.1 --short
```

---

## 📦 Installation

### **Requirements**

- `bash`
- `curl`
- `jq`
- `python3` (recommended for IP validation + emojis)
- Linux or macOS terminal

---

## 🍺 Homebrew Install (macOS & Linuxbrew)

Install directly from your tap:

```bash
brew install vespovios/ipcheck/ipcheck
```

Or tap first:

```bash
brew tap vespovios/ipcheck
brew install ipcheck
```

Update:

```bash
brew upgrade ipcheck
```

Uninstall:

```bash
brew uninstall ipcheck
```

---

## ⭐ One-Line Install (Linux or macOS)

```bash
bash <(curl -sL https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/install.sh)
```

This automatically:
- Detects your OS  
- Installs dependencies  
- Installs `ipcheck` in the correct directory  

---

## 🛠 Manual Installation

### **Option 1 — Clone repository & install**

```bash
git clone https://github.com/vespovios/ipcheck-cli.git
cd ipcheck-cli

chmod +x ipcheck
sudo cp ipcheck /usr/local/bin/ipcheck
```

---

### **Option 2 — Quick Install (Linux)**  

```bash
sudo curl -L https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/ipcheck -o /usr/local/bin/ipcheck
sudo chmod +x /usr/local/bin/ipcheck
```

---

### **Option 3 — Quick Install (macOS)**  

Install dependencies:

```bash
brew install jq
```

Then install:

```bash
sudo curl -L https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/ipcheck -o /usr/local/bin/ipcheck
sudo chmod +x /usr/local/bin/ipcheck
```

Test:

```bash
ipcheck
```

---

## 📘 Usage

```text
ipcheck v0.8.0

Usage: ipcheck [OPTIONS]

Fetch and display public IP geolocation information (using geojs.io).

Options:
  -i, --ip IP        Look up a specific IP instead of your own
  -s, --short        Show short output (IP, country, flag)
  -r, --raw          Output raw JSON from the API
      --raw-pretty   Output pretty-printed JSON
  -q, --quiet        Output only the IP address
  -4, --ipv4         Only report the IPv4 address
  -6, --ipv6         Only report the IPv6 address
  -a, --all-ips      With --quiet, print every discovered IP, one per line
      --no-flag      Disable country flag emoji
      --check-update Check for a newer ipcheck version (if UPDATE_URL is set)
  -h, --help         Show this help message and exit

Both the IPv4 and the IPv6 address are shown when the host has both.
```

---

## 🔄 Update Checking

`ipcheck` includes a built-in update mechanism.

To check if a newer version is available:

```bash
ipcheck --check-update
```

The update URL is defined inside the script:

```bash
UPDATE_URL="https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/VERSION"
```

---

## 🛠 Development

Clone the repository:

```bash
git clone https://github.com/vespovios/ipcheck-cli.git
cd ipcheck-cli
```

Run locally without installing:

```bash
./ipcheck --raw
```

### **Bumping version numbers**

1. Update the version in the script header:
   ```bash
   VERSION="0.x.x"
   ```
2. Update the `VERSION` file:
   ```bash
   echo "0.x.x" > VERSION
   ```
3. Commit and tag:
   ```bash
   git add ipcheck VERSION
   git commit -m "Bump version to 0.x.x"
   git tag v0.x.x
   git push
   git push origin v0.x.x
   ```

---

## 📜 License

This project is licensed under the **MIT License**.  
See the [LICENSE](LICENSE) file for details.
