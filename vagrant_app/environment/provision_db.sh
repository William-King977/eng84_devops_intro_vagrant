#!/bin/bash

# Run the update and upgrade commands
sudo apt-get update -y
sudo apt-get upgrade -y

# Installing MongoDB (version 3.2.20)
wget -qO - https://www.mongodb.org/static/pgp/server-3.2.asc | sudo apt-key add -
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20

# Change VM listener IP to 0.0.0.0
sudo sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf

# Running MongoDB
sudo systemctl enable mongod
sudo service mongod start
