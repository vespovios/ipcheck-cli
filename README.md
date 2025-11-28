# ipcheck-cli

[![Homebrew tap](https://img.shields.io/badge/homebrew-vespovios%2Fipcheck-blue)](https://github.com/vespovios/homebrew-ipcheck)
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/vespovios/ipcheck-cli)](https://github.com/vespovios/ipcheck-cli/releases)
[![GitHub all releases](https://img.shields.io/github/downloads/vespovios/ipcheck-cli/total)](https://github.com/vespovios/ipcheck-cli/releases)
[![License](https://img.shields.io/github/license/vespovios/ipcheck-cli)](https://github.com/vespovios/ipcheck-cli/blob/main/LICENSE)
[![CI](https://github.com/vespovios/ipcheck-cli/actions/workflows/ci.yml/badge.svg)](https://github.com/vespovios/ipcheck-cli/actions/workflows/ci.yml)
[![Visitors](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2Fvespovios%2Fipcheck-cli&title=Visitors&edge_flat=false)](https://github.com/vespovios/ipcheck-cli)

`ipcheck` is a lightweight Bash CLI tool for querying IP geolocation information using the public API at **https://get.geojs.io**.

It supports:

- 🌈 Pretty, colored terminal output (with country flag emoji)
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

### **Short output**
```bash
ipcheck --short
# 141.144.249.100 - Germany (DE) 🇩🇪
```

### **Quiet output (IP only)**
```bash
ipcheck --quiet
# 141.144.249.100
```

### **Raw JSON / pretty JSON**
```bash
ipcheck --raw
ipcheck --raw-pretty
```

### **Lookup a specific IP**
```bash
ipcheck --ip 8.8.8.8
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
ipcheck v0.7.3

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
