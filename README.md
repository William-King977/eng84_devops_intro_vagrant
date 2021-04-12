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
* `mkdir` - make a new directory, folder.
* `nano file_name` - create a file and edit it
* `touch file_name` - create an empty file
* `sudo` - used to run commands as an admin
* `sudo su` - go into dmin mode
* `cd ..` - go back a single directory
* `pwd` - current directory
* update command `sudo apt-get update -y` or `sudo apt-get upgrade -y` 
* `clear` - to clear screen/terminal
* `mv old_file new_file` - renaming a file named "old_file" to "new_file"
* `rm file_name` - deletes a file named "file_name"
* `cp my_file devops/my_file` - copies "my_file" into "devops" folder
* `mv file_name devops/` - moves "file_name" into "devops" folder
* `chmod +rwx filename`
  * `+` - means add permission
  * `-` - takes away the permission
  * `r` - read
  * `w` - write
  * `x` - execute
* `ll` - check current permission(s)
* `top` - check current process
* `ps`, `ps aux` - check process

* `sudo apt-get install nginx` - install web server called NGINX
* `systemctl status nginx` - check if NGINX is installed
