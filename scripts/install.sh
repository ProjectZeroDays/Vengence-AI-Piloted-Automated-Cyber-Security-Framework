#!/bin/bash

# https://github.com/projectzerodays
# Installs Git, Github CLI, and The GitHub CLI CoPilot Extension and Setting Configurations for Bash, Zsh, Powershell, and Aliases Using a GitHub User Token (GitHub PAT)

# Installing Git
brew install git

# Installing GitHub CLI
brew install gh

# Setting The Enviornment Variable For The GitHub Authorization
export GH_TOKEN=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
set GH_TOKEN=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

# Installing Github CoPilot Extension
gh extension install github/gh-copilot

# Upgrading Github CoPilot Extension
gh extension upgrade gh-copilot

# Setting Configurations For Bash
echo 'eval "$(gh copilot alias -- bash)"' >> ~/.bashrc
source ~/.bashrc

# Setting Configurations For Zsh
echo 'eval "$(gh copilot alias -- zsh)"' >> ~/.zshrc
source ~/.zshrc

# Setting Configurations For Powershell
pwsh
$GH_COPILOT_PROFILE = Join-Path -Path $(Split-Path -Path $PROFILE -Parent) -ChildPath "gh-copilot.ps1"
gh copilot alias -- pwsh | Out-File ( New-Item -Path $GH_COPILOT_PROFILE -Force )
echo ". `"$GH_COPILOT_PROFILE`"" >> $PROFILE

# Enable GitHub CoPilot CLI Command Execution (Set Default to ‘YES’)
gh copilot config

# Define the config file
CONFIG_FILE="config/config.json"

# Function to install a tool and record its path
install_tool() {
    local tool_name=$1
    local install_command=$2
    local check_command=$3
    local path_command=$4

    echo "Checking if $tool_name is installed..."
    if ! eval $check_command &> /dev/null; then
        echo "Installing $tool_name..."
        eval $install_command

        echo "Recording the path of $tool_name..."
        tool_path=$(eval $path_command)
        jq --arg tool "$tool_name" --arg path "$tool_path" '.tools[$tool] = $path' $CONFIG_FILE > tmp.$$.json && mv tmp.$$.json $CONFIG_FILE
    else
        echo "$tool_name is already installed."
    fi
}

# Function to generate API keys
generate_api_key() {
    local tool_name=$1
    local api_key_command=$2

    echo "Generating API key for $tool_name..."
    api_key=$(eval $api_key_command)
    jq --arg tool "$tool_name" --arg key "$api_key" '.api_keys[$tool] = $key' $CONFIG_FILE > tmp.$$.json && mv tmp.$$.json $CONFIG_FILE
}

# Create config file if it doesn't exist
if [ ! -f $CONFIG_FILE ]; then
    echo '{}' | jq '.tools = {} | .api_keys = {}' > $CONFIG_FILE
fi

# Determine the operating system
OS=$(uname -v)

# Install tools and record their paths based on the operating system
if echo "$OS" | grep -q "Darwin"; then
    echo "Detected macOS"

    # Install Homebrew if not installed
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    install_tool "OWASP ZAP" "brew install owasp-zap" "zap-cli --version" "which zap-cli"
    install_tool "Nikto" "brew install nikto" "nikto -Version" "which nikto"
    install_tool "OpenVAS" "brew install openvas" "openvas -v" "which openvas"
    install_tool "Wireshark" "brew install wireshark" "wireshark -v" "which wireshark"
    install_tool "Metasploit" "brew install metasploit" "msfconsole --version" "which msfconsole"
    install_tool "Nmap" "brew install nmap" "nmap --version" "which nmap"
    install_tool "Snort" "brew install snort" "snort -V" "which snort"
    install_tool "Kali Linux" "brew install kali-linux" "kali-linux --version" "which kali-linux"
    install_tool "KeePass" "brew install keepassxc" "keepassxc --version" "which keepassxc"
    install_tool "ClamAV" "brew install clamav" "clamscan --version" "which clamscan"
    install_tool "Wifite" "brew install wifite" "wifite --version" "which wifite"
    install_tool "Aircrack-ng" "brew install aircrack-ng" "aircrack-ng --help" "which aircrack-ng"
    install_tool "Kismet" "brew install kismet" "kismet -v" "which kismet"
else
    echo "Detected Linux"

    install_tool "OWASP ZAP" "sudo apt-get install -y zaproxy" "zap-cli --version" "which zap-cli"
    install_tool "Nikto" "sudo apt-get install -y nikto" "nikto -Version" "which nikto"
    install_tool "OpenVAS" "sudo apt-get install -y openvas" "openvas -v" "which openvas"
    install_tool "Wireshark" "sudo apt-get install -y wireshark" "wireshark -v" "which wireshark"
    install_tool "Metasploit" "curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/msfupdate | sudo bash" "msfconsole --version" "which msfconsole"
    install_tool "Nmap" "sudo apt-get install -y nmap" "nmap --version" "which nmap"
    install_tool "Snort" "sudo apt-get install -y snort" "snort -V" "which snort"
    install_tool "Kali Linux" "sudo apt-get install -y kali-linux" "kali-linux --version" "which kali-linux"
    install_tool "KeePass" "sudo apt-get install -y keepass2" "keepass2 --version" "which keepass2"
    install_tool "ClamAV" "sudo apt-get install -y clamav" "clamscan --version" "which clamscan"
    install_tool "Wifite" "sudo apt-get install -y wifite" "wifite --version" "which wifite"
    install_tool "Aircrack-ng" "sudo apt-get install -y aircrack-ng" "aircrack-ng --help" "which aircrack-ng"
    install_tool "Kismet" "sudo apt-get install -y kismet" "kismet -v" "which kismet"
fi

# Install Python modules
echo "Installing Python modules..."
pip install -r requirements.txt

# Generate API keys for tools
generate_api_key "OWASP ZAP" "zap-cli api-key generate"
generate_api_key "Nikto" "nikto --generate-api-key"
generate_api_key "OpenVAS" "openvas --generate-api-key"
generate_api_key "Wireshark" "wireshark --generate-api-key"
generate_api_key "Metasploit" "msfconsole --generate-api-key"
generate_api_key "Nmap" "nmap --generate-api-key"
generate_api_key "Snort" "snort --generate

#!/bin/bash

# Find all .py and .sh files and make them executable
find . -type f \( -name "*.py" -o -name "*.sh" \) -exec chmod +x {} \;

echo "All .py and .sh files are now executable."

./scripts/generate_database.sh
./scripts/setup-virtual-env.sh
./scripts/setup-virtual-env.sh
