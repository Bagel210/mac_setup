#!/bin/bash

# Set Hostname
sudo hostname `whoami`

# Install Pip
sudo easy_install pip

# Install venv globally
sudo pip install virtualenv

# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Add Cask
brew tap caskroom/cask

# Install Python 3.6
brew install https://raw.githubusercontent.com/Homebrew/homebrew-core/f2a764ef944b1080be64bd88dca9a1d80130c558/Formula/python.rb

# Install NPM
brew install npm
brew install bower

# Install mysql-connector
brew install mysql-connector-c

echo "Please find your mysql_config and fix it using this - https://pypi.org/project/mysqlclient/"

# Isntall LibXML - 
brew install libxmlsec1
brew install libxml2

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
install_cask_with_retry slack
install_cask_with_retry google-chrome
install_cask_with_retry pycharm
install_cask_with_retry phpstorm
install_cask_with_retry sequel-pro
install_cask_with_retry sublime-text
install_cask_with_retry flux


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
dockutil --add /Applications/Slack.app
dockutil --add /Applications/Safari.app
dockutil --add /Applications/Google\ Chrome.app
dockutil --add /Applications/iTunes.app
dockutil --add /Applications/PyCharm.app
dockutil --add /Applications/PhpStorm.app
dockutil --add /Applications/Sequel\ Pro.app
dockutil --add /Applications/Sublime\ Text.app
dockutil --add /Applications/System\ Preferences.app
dockutil --add ~/Downloads --view grid --display folder
dockutil --add /Applications --view grid --display folder


# Uses apple script to switch to the dark theme
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'


# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#Get the docker client
open "https://docs.docker.com/docker-for-mac/install"

