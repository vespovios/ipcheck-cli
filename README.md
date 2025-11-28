# ipcheck-cli

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

### **Install dependencies on Ubuntu/Debian**
```bash
sudo apt update
sudo apt install curl jq python3
```

### Install `ipcheck` globally

### **Option 1 — Clone repository & install (Linux or macOS)**

```bash
git clone https://github.com/vespovios/ipcheck-cli.git
cd ipcheck-cli

chmod +x ipcheck
sudo cp ipcheck /usr/local/bin/ipcheck
```

Now you can run:

```bash
ipcheck
```

---

### **Option 2 — Quick Install (Linux)**  
Download directly into `/usr/local/bin`:

```bash
sudo curl -L https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/ipcheck   -o /usr/local/bin/ipcheck

sudo chmod +x /usr/local/bin/ipcheck
```

---

### **Option 3 — Quick Install (macOS)**

macOS already includes `bash`, `curl`, and `python3`.  
Only `jq` is needed:

```bash
brew install jq
```

Then install `ipcheck`:

```bash
sudo curl -L https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/ipcheck   -o /usr/local/bin/ipcheck

sudo chmod +x /usr/local/bin/ipcheck
```

Now test:

```bash
ipcheck
```
---
## 📘 Usage

```
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
   ```
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
