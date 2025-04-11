#!/bin/bash

set -e

OS=$(uname -s)

# Install Make
install_make() {
  if ! command -v make >/dev/null 2>&1; then
    echo "Installing Make..."
    if [ "$OS" = "Linux" ]; then
      if [ -f /etc/debian_version ]; then
        sudo apt-get update
        sudo apt-get install -y make
      elif [ -f /etc/redhat-release ]; then
        sudo yum install -y make
      else
        echo "Unsupported Linux distribution. Please install Make manually."
        exit 1
      fi
    elif [ "$OS" = "Darwin" ]; then
      brew install make
    else
      echo "Unsupported OS. Please install Make manually."
      exit 1
    fi
  else
    echo "Make is already installed."
  fi
}

# Install Docker
install_docker() {
  if ! command -v docker >/dev/null 2>&1; then
    echo "Installing Docker..."
    if [ "$OS" = "Linux" ]; then
      curl -fsSL https://get.docker.com | sh
      sudo usermod -aG docker $USER
      echo "Please log out and log back in to apply Docker group changes."
    elif [ "$OS" = "Darwin" ]; then
      brew install docker docker-compose
    else
      echo "Unsupported OS. Please install Docker manually."
      exit 1
    fi
  else
    echo "Docker is already installed."
  fi
}

# Install Docker Compose (if not included with Docker)
install_docker_compose() {
  if ! command -v docker-compose >/dev/null 2>&1; then
    echo "Installing Docker Compose..."
    if [ "$OS" = "Linux" ]; then
      sudo curl -L "https://github.com/docker/compose/releases/download/v2.20.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
      sudo chmod +x /usr/local/bin/docker-compose
    fi
  else
    echo "Docker Compose is already installed."
  fi
}

# Check for Homebrew on macOS
if [ "$OS" = "Darwin" ] && ! command -v brew >/dev/null 2>&1; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

install_make
install_docker
install_docker_compose

echo "Setup complete! You can now use 'make' and 'docker-compose'."