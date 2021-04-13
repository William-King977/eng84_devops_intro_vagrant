provision_app.sh
#!/bin/bash

# Run the update command
sudo apt-get update -y

# Run the upgrade command
sudo apt-get upgrade -y

# Install nginx
sudo apt-get install nginx -y

# Install nodejs with requored version and dependencies
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# install npm with pm2 -g
sudo npm install pm2 -g