#!/usr/bin/env bash
set -euo pipefail

REPO_RAW_URL="https://raw.githubusercontent.com/vespovios/ipcheck-cli/main/ipcheck"

log()  { printf "[ipcheck-install] %s\n" "$*"; }
err()  { printf "[ipcheck-install][ERROR] %s\n" "$*" >&2; }
die()  { err "$*"; exit 1; }

detect_os() {
  UNAME_OUT=$(uname -s)
  case "$UNAME_OUT" in
    Linux*)
      OS_TYPE="linux"
      if [[ -f /etc/os-release ]]; then
        # shellcheck disable=SC1091
        . /etc/os-release
        DISTRO_ID=${ID:-unknown}
        DISTRO_LIKE=${ID_LIKE:-}
      else
        DISTRO_ID="unknown"
        DISTRO_LIKE=""
      fi
      ;;
    Darwin*)
      OS_TYPE="macos"
      DISTRO_ID="macos"
      DISTRO_LIKE=""
      ;;
    *)
      die "Unsupported OS: $UNAME_OUT"
      ;;
  esac
}

detect_install_dir() {
  if [[ "$OS_TYPE" == "macos" ]]; then
    # Prefer Homebrew bin on Apple Silicon if present
    if [[ -d /opt/homebrew/bin ]]; then
      INSTALL_DIR="/opt/homebrew/bin"
    else
      INSTALL_DIR="/usr/local/bin"
    fi
  else
    # Linux (Ubuntu/Debian)
    INSTALL_DIR="/usr/local/bin"
  fi
}

ensure_sudo() {
  if [[ ! -w "$INSTALL_DIR" ]]; then
    if ! command -v sudo >/dev/null 2>&1; then
      die "sudo not found and $INSTALL_DIR is not writable. Please rerun as root or install sudo."
    fi
  fi
}

install_deps_linux_debian() {
  log "Detected Linux (Debian/Ubuntu). Installing dependencies with apt..."

  if ! command -v sudo >/dev/null 2>&1 && [[ $EUID -ne 0 ]]; then
    die "This script needs root privileges to install packages. Please run as root or install sudo."
  fi

  local SUDO=""
  [[ $EUID -ne 0 ]] && SUDO="sudo"

  $SUDO apt-get update -y
  $SUDO apt-get install -y curl jq python3
}

install_deps_macos() {
  log "Detected macOS. Checking dependencies..."

  # curl is built-in on macOS, but check anyway
  if ! command -v curl >/dev/null 2>&1; then
    die "curl is not available on this macOS system. Please install it (e.g. via Xcode Command Line Tools)."
  fi

  if ! command -v brew >/dev/null 2>&1; then
    err "Homebrew is required to install jq and python3 on macOS."
    err "Install Homebrew from: https://brew.sh"
    die "After installing Homebrew, rerun this script."
  fi

  log "Installing jq and python3 via Homebrew (if not already installed)..."
  brew install jq python3 || true
}

install_ipcheck() {
  local target="${INSTALL_DIR}/ipcheck"
  local SUDO=""
  [[ ! -w "$INSTALL_DIR" ]] && SUDO="sudo"

  log "Downloading ipcheck from: $REPO_RAW_URL"
  $SUDO curl -L "$REPO_RAW_URL" -o "$target"

  log "Making ipcheck executable..."
  $SUDO chmod +x "$target"

  log "ipcheck installed to: $target"
}

main() {
  detect_os
  detect_install_dir

  log "OS type: $OS_TYPE (distro: $DISTRO_ID $DISTRO_LIKE)"
  log "Install directory: $INSTALL_DIR"

  ensure_sudo

  case "$OS_TYPE" in
    linux)
      if [[ "$DISTRO_ID" == "ubuntu" || "$DISTRO_ID" == "debian" || "$DISTRO_LIKE" == *"debian"* || "$DISTRO_LIKE" == *"ubuntu"* ]]; then
        install_deps_linux_debian
      else
        err "Non-Debian-based Linux detected (ID=$DISTRO_ID, LIKE=$DISTRO_LIKE)."
        die "Automatic dependency installation is only implemented for Debian/Ubuntu. Please install curl, jq and python3 manually, then rerun this script."
      fi
      ;;
    macos)
      install_deps_macos
      ;;
    *)
      die "Unsupported OS: $OS_TYPE"
      ;;
  esac

  install_ipcheck

  log "Done. Try running:"
  log "  ipcheck"
}

main "$@"

