
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

# Setup Finder
echo "Setup Finder"
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder ShowStatusBar -bool true

# XCode
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
echo "Updating Homebrew"
brew update
echo "Upgrading Homebrew"
brew upgrade

# iTerm2
echo "iTerm2"
brew cask install iterm2

# Update the Terminal
# Ooh-my-zsh
echo "oh-my-zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "Need to logout now to start the new SHELL..."
logout

# Git
echo "Git"
brew install git
echo "Git config"
git config --global user.name "Hugo Pretorius"
git config --global user.email hugopretorius914@gmail.com

# GitHub CLI
echo "GitHub CLI..."
brew install gh

# Speed Test
echo "Speed Test"
brew install speedtest_cli

# Node
echo "Node"
brew install node

# Flutter
echo "Flutter"
brew tap leoafarias/fvm
brew install fvm

# Android
echo "Android"
brew install android-sdk
brew install android-ndk

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
