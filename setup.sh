
# Get permission to run this script with below command
# chmod +x script-name-here.sh

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do
    sudo -n true
    sleep 60
    kill -0 "$$" || exit
done 2>/dev/null &

# Setup Finder Commands
# Show Library Folder in Finder
chflags nohidden ~/Library

# Show Hidden Files in Finder
defaults write com.apple.finder AppleShowAllFiles YES

# Show Path Bar in Finder
defaults write com.apple.finder ShowPathbar -bool true

# Show Status Bar in Finder
defaults write com.apple.finder ShowStatusBar -bool true

echo "Installing xcode-stuff"
xcode-select --install

# Check for Homebrew, and then install it
if test ! "$(which brew)"; then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    echo "Homebrew installed successfully"
else
    echo "Homebrew already installed!"
fi

# Install XCode Command Line Tools
echo 'Checking to see if XCode Command Line Tools are installed...'
brew config

# Updating Homebrew.
echo "Updating Homebrew..."
brew update

# Upgrade any already-installed formulae.
echo "Upgrading Homebrew..."
brew upgrade

# Install iTerm2
echo "Installing iTerm2..."
brew cask install iterm2

# Update the Terminal
# Install oh-my-zsh
echo "Installing oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Need to logout now to start the new SHELL..."
logout

# Install Git
echo "Installing Git..."
brew install git

echo "Git config"
git config --global user.name "Hugo Pretorius"
git config --global user.email hugopretorius914@gmail.com

# Install GitHub CLI
echo "Installing GitHub CLI..."
brew install gh

# Install without cask
brew install speedtest_cli
brew install node

# Install with cask
brew install --cask android-SDK
brew install --cask android-ndk
brew install --cask flutter

# Remove outdated versions from the cellar.
echo "Running brew cleanup..."
brew cleanup
echo "You're done!"

# Apps
apps=(
  android-studio
  visual-studio-code
  google-chrome
  spotify
  slack
)

# Install apps to /Applications
echo "installing apps with Cask..."
brew install --cask --appdir="/Applications" ${apps[@]}