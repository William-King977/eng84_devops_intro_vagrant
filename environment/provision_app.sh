provision_app.sh
#!/bin/bash

# Run the update command
sudo apt-get update -y

# Run the upgrade command
sudo apt-get upgrade -y

# Install nginx
sudo apt-get install nginx -y

# Install nodejs with required version and dependencies
sudo apt-get install python-software-properties
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y

# install npm with pm2 -g
sudo npm install pm2 -g

# Install npm for other dependencies (express etc.)
# sudo npm install /home/vagrant/app/app

# Run the seed to populate the database (posts page)
# sudo node /home/vagrant/app/app/seeds/seed.js