#!/bin/bash
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#install Neovim 
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
if ! command -v nvim &> /dev/null; then

	# Download Neovim (Consider using a package manager for updates)
	curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz

	# Extract Neovim
	tar -xzf nvim-linux64.tar.gz

	# Move Neovim directory (Avoids root ownership)
	mv nvim-linux64 ~/.local/nvim/

	# Add Neovim to PATH (Consider a user-specific approach)
	echo "export PATH=\$PATH:\$HOME/.local/nvim/bin" >> ~/.bashrc

	# Source .bashrc to apply changes (Optional, consider reloading terminal)
	source ~/.bashrc

	rm -rf nvim-linux64.tar.gz


	echo "Neovim installation (potentially incomplete) finished."
	echo "**Please reload your terminal for the changes to take effect.**"
else
    echo "Neovim is already installed."
fi

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Install nvim config 
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Neovim configuration repository URL
nvim_repo="https://github.com/rioten353/nvim.git"

# Check if git is installed
if ! command -v git &> /dev/null; then
  echo "Error: git is not installed. Please install git before running this script."
  exit 1
fi

# Check if the Neovim configuration directory already exists
if [[ -d ~/.config/nvim ]]; then
  echo "Neovim configuration already exists. Skipping cloning."
else
  # Clone the Neovim configuration repository
  git clone "$nvim_repo" ~/.config/nvim

  # Check if cloning was successful
  if [[ $? -ne 0 ]]; then
    echo "Error: Failed to clone the Neovim configuration repository."
    exit 1
  fi

  echo "Neovim configuration cloned to ~/.config/nvim (may require additional setup)."
  echo "**Please refer to the repository documentation for installation instructions.**"
fi

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#install packages
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


# Function to check if a package is installed
function is_package_installed() {
    dpkg -s "$1" >/dev/null 2>&1
}

# List of packages to install
packages=("fish" "git" "ranger" "ncdu" "htop" "luarocks" "neofetch" "tmux" "make" "g++" "ripgrep")

for package in "${packages[@]}"; do
    if ! is_package_installed "$package"; then
        sudo apt install "$package" -y
    else
        echo "$package is already installed."
    fi
done
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Install Fira Code Nerd Font
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Check if FiraCode Nerd Font is installed
font_file="/usr/local/share/fonts/FiraMonoNerdFontMono-Bold.otf"

if [[ -f "$font_file" ]]; then
    echo "FiraCode Nerd Font is already installed."
else
    # Font repository URL
    font_repo="https://github.com/rioten353/install.git"

    # Target font file name
    font_file="FiraMonoNerdFontMono-Bold.otf"

    # Install directory (temporary)
    install_dir="nerd-fonts"

    # Check if git is installed
    if ! command -v git &> /dev/null; then
        echo "Error: git is not installed. Please install git before running this script."
        exit 1
    fi

    # Clone the font repository
    git clone "$font_repo" "$install_dir"

    # Check if cloning was successful
    if [[ $? -ne 0 ]]; then
        echo "Error: Failed to clone the font repository."
        exit 1
    fi

    # Change directory to the install directory
    cd "$install_dir"

    # Install the font (requires sudo)
    sudo cp "$font_file" "/usr/local/share/fonts/"

    # Move back to the original directory
    cd ..

    # Remove the temporary directory
    rm -rf "$install_dir"

    echo "FiraCode Nerd Font installed (may require font cache refresh)."
fi

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Install Rust
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Check for cargo command
if ! command -v cargo &> /dev/null; then
  echo "Rust is not installed. Would you like to install it? (y/N)"
  read -r install_rust

  if [[ "$install_rust" =~ ^[Yy]$ ]]; then
    # Install Rust using curl (consider using a package manager)
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # Add ~/.cargo/env to .bashrc
    echo "source ~/.cargo/env" >> ~/.bashrc
    source ~/.bashrc

    # Check if installation was successful
    if ! command -v cargo &> /dev/null; then
      echo "Error: Rust installation failed."
    else
      echo "Rust installed successfully."
    fi
  else
    echo "Skipping Rust installation."
  fi
else
  echo "Rust is already installed."
fi

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Install Dart
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Check for Dart command
if ! command -v dart &> /dev/null; then
  echo "Dart is not installed. Would you like to install it? (y/N)"
  read -r install_dart

  if [[ "$install_dart" =~ ^[Yy]$ ]]; then
    # Download link for Dart (replace with the actual download link)
    download_link="https://storage.googleapis.com/dart-archive/channels/stable/release/latest/linux_packages/dart_3.5.4-1_amd64.deb"

    # Download Dart installer
    curl -LO "$download_link"

    sudo dpkg -i ./dart_*.deb

    rm -rf dart_*.deb  # Remove downloaded installer

    echo "Dart installation (potentially incomplete) finished."
  else
    echo "Skipping Dart installation."
  fi
else
  echo "Dart is already installed."
fi

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Install python
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Check for Python 3.13 and pip3
if ! command -v python3.13 &> /dev/null; then
  echo "Python 3.13 is not installed. Would you like to install it? (y/N)"
  read -r install_python

  if [[ "$install_python" =~ ^[Yy]$ ]]; then
    # Add the Deadsnakes PPA (for Debian-based systems)
    sudo add-apt-repository ppa:deadsnakes/ppa

    # Update the package lists
    sudo apt update

    # Install Python 3.13 and pip3
    sudo apt install python3.13

    echo "Python 3.13 and pip3 installed successfully!"
  else
    echo "Skipping Python 3.13 installation."
  fi
else
  echo "Python 3.13 is already installed."
fi


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Install uv
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Check if uv is already installed
if ! command -v uv &> /dev/null; then
  # uv is not installed
  echo "uv is not currently installed."
  read -r -p "Would you like to install uv now? (y/N) " response

  if [[ $response =~ ^([Yy]|[Yy]es)$ ]]; then
    # User confirms installation
    curl -LsSf https://astral.sh/uv/install.sh | sh

    echo "uv installation complete."
  else
    echo "Skipping uv installation."
  fi
else
  echo "uv is already installed."
fi

#refresh bashrc
source ~/.bashrc

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#tmux
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo "tmux is not setup ."
  read -r -p "Would you like to setup tmux? (y/N) " response

  if [[ $response =~ ^([Yy]|[Yy]es)$ ]]; then
    # User confirms installation
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    mv tmux.conf ~/.tmux.conf

    echo "tmux setup complete."
  else
    echo "Skipping tmux setup."
  fi
