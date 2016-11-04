#!/bin/bash

# Set Hostname
sudo hostname whoami

echo "Please enter your name"
read name
git config --global user.name "$name"

echo "Input Github email address"
read email
git config --global user.email "$email"

# Install Pip
sudo easy_install pip

# Install venv globally
sudo pip install virtualenv

# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Add Cask
brew tap caskroom/cask

function install_cask_with_retry {
    brew cask install $1
    if [ $? -ne 0 ]
    then
        echo "Uh oh, failed to install... Sod it; let's try again!"
        brew cask install $1
    fi
}

# Install Apps
install_cask_with_retry dropbox
install_cask_with_retry google-chrome
install_cask_with_retry pycharm
install_cask_with_retry phpstorm
install_cask_with_retry sequel-pro
install_cask_with_retry sublime-text
install_cask_with_retry iterm2
install_cask_with_retry mamp
install_cask_with_retry vagrant
install_cask_with_retry virtualbox
install_cask_with_retry flux
install_cask_with_retry transmission


# Install DockUtil
curl https://raw.githubusercontent.com/kcrawford/dockutil/master/scripts/dockutil -o /usr/local/bin/dockutil
chmod a+x /usr/local/bin/dockutil

# Minimize Dock
dockutil --remove all

dockutil --add /Applications/App\ Store.app
dockutil --add /Applications/Messages.app
dockutil --add /Applications/Mail.app
dockutil --add /Applications/Calendar.app
dockutil --add /Applications/Notes.app
dockutil --add /Applications/Safari.app
dockutil --add /Applications/iTunes.app
dockutil --add /Applications/iTerm.app
dockutil --add /Applications/PyCharm.app
dockutil --add /Applications/PhpStorm.app
dockutil --add /Applications/Sequel\ Pro.app
dockutil --add /Applications/Sublime\ Text.app
dockutil --add /Applications/System\ Preferences.app
dockutil --add ~/Downloads --view grid --display folder
dockutil --add /Applications --view grid --display folder

# Launch Dropbox to enable login and setup
/Applications/Dropbox.app/Contents/MacOS/Dropbox &

# Wait for dropbox to begin sync
while [ ! -s ~/Dropbox/id_rsa.enc ] ;
do
    sleep 1
done

while [ ! -s ~/Dropbox/id_rsa.pub ] ;
do
    sleep 1
done

# Decrypt private key
mkdir -p ~/.ssh
openssl enc -d -aes-256-cbc -in ~/Dropbox/id_rsa.enc -out ~/.ssh/id_rsa
chmod 0600 ~/.ssh/id_rsa
cp ~/Dropbox/id_rsa.pub ~/.ssh

# Copy .dotfiles
./update_dotfiles.sh

# Uses apple script to switch to the dark theme
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'

