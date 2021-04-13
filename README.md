# Intro to DevOps
## What is DevOps?
* A collaboration of Dvelopment (Dev) and Operations (Ops).
* A cuture which promotes collaboration between Development and Operations Team to deploy code to production faster in an automated and repeatable way.
* A practice of development and operation engineers taking part together in the whole service lifecycle.
* An approach through which superior quality software can be devloped quickly and with more reliability.
* An alignment of development and IT operations with better communication and collaboration.

## DevOps Value
* CAMS Model
  * Sharing
  * Measurement
  * Automation
  * Culture

## Challenges
* The four pillars
  * Ease of use
  * Flexibility
  * Robustness
  * Cost

## DevOps Principles
1. Customer-Centric Action
2. End-to-End Responsibility
3. Continuous Improvement
4. Automate everything
5. Work as one team
6. Monitor and test everything

## Stages
* Countinuous Development
* Countinuous Testing
* Countinuous Inegration
* Countinuous Deployment
* Countinuous Monitoring

# Vagrant and Linux
## Vagrant commands
* `vagrant up` - to start-up a virtual machine (VM)
* `vagrant destroy` - to destroy the VM
* `vagrant reload` - to reload the VM
* `vagrant status` - checks how many machines are running and if they are running
* `vagrant ssh` - to SSH into VM
* `vagrant halt` - to pause the VM

* `apt-get` in Linux is a package manager to install/update like Windows installer, mac app store

## Linux Commands
* `uname` - username in VM
* `ls` - list files/folders in current directory
* `ls -a` - list all directories
* `cd ..` - go back a single directory
* `pwd` - current directory
* update command `sudo apt-get update -y` or `sudo apt-get upgrade -y` 
* `clear` - to clear screen/terminal
* `top` - check current process
* `ps`, `ps aux` - check process
* `systemctl status nginx` - check if NGINX is installed

### File handling
* `mkdir` - make a new directory, folder.
* `nano file_name` - create a file and edit it
* `touch file_name` - create an empty file
* `mv old_file new_file` - renaming a file named "old_file" to "new_file"
* `rm file_name` - deletes a file named "file_name"
* `cp my_file devops/my_file` - copies "my_file" into "devops" folder
* `mv file_name devops/` - moves "file_name" into "devops" folder

### Permissions
* `sudo` - used to run commands as an admin
* `sudo su` - go into admin mode
* `chmod +rwx filename`
  * `+` - means add permission
  * `-` - takes away the permission
  * `r` - read
  * `w` - write
  * `x` - execute
* `ll` - check current permission(s)

## Running and passing tests on host machine by installing required dependencies
* Change file location to `environment/test` ... more?
* `branch` on host machine
* `rack spec` on host to run tests

## Automate the installation of required dependencies in our Vagrant file to run our script
* add shell script path to our Vagrantfile
* `config.vm.provision "shell", path: "environment/provision.sh"`

* Creating the script (provision.sh)
```
provision.sh
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
```