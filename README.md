# Intro to DevOps
## What is DevOps?
* A collaboration of Development (Dev) and Operations (Ops).
* A culture which promotes collaboration between Development and Operations Team to deploy code to production faster in an automated and repeatable way.
* A practice of development and operation engineers taking part together in the whole service lifecycle.
* An approach through which superior quality software can be developed quickly and with more reliability.
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
* Continuous Development
* Continuous Testing
* Continuous Integration
* Continuous Deployment
* Continuous Monitoring

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

## Running tests
On the host machine, do the following:
* Change file location to `environment/spec-tests`
* Execute `gem install bundler:2.2.9`
* Execute `bundle`
* Then use `rack spec` to run the tests
* Note: `rack spec` can be used to run tests in other folders


## Multi-machine Vagrant with DB
Before doing any of these instructions, one must complete the previous section first to enable testing (Running tests).

### Create a Vagrant file
First, one must create a Vagrantfile with the following contents. As shown below, a virtual machine is configured for both the app and database using `config.vm.define`. Each one has a respective provision file, which holds commands that will execute as the virtual machine is being created. The OS inside both machines is Linux.
```
# Install the required plugins to create alliases
required_plugins = ["vagrant-hostsupdater"]
required_plugins.each do |plugin|
  exec "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
end

Vagrant.configure("2") do |config|
  # Set the OS to Linux
  config.vm.box = "ubuntu/xenial64"

  # App virtual machine
  config.vm.define "app" do |app|
    # Let's attach private network with IP
    app.vm.network "private_network", ip: "192.168.10.100"

    # Creating an alias to link this IP with a logical web address
    app.hostsupdater.aliases = ["development.local"]

    # Transferring files/folder data from our OS to VM.
    # Vagrant has an option os synced_folder
    app.vm.synced_folder ".", "/home/vagrant/app"

    # Run the shell script from the given location
    app.vm.provision "shell", path: "environment/provision_app.sh"

    # Environment variable to help connect to the database
    app.vm.provision "shell", inline: "sudo echo 'export DB_HOST=mongodb://192.168.10.101:27017/posts' >> /etc/profile.d/myvars.sh", run: "always"
  end

  # Mongo db virtual machine
  config.vm.define "db" do |db|
    # Make IP different to the app
    db.vm.network "private_network", ip: "192.168.10.101"
    db.vm.provision "shell", path: "environment/provision_db.sh"
  end
end
```

### Create `provision_app.sh` for the app
Inside `provision_app.sh` are the following contents. These commands install the necessary dependencies to run the app virtual machine.
```
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
```

### Create `provision_db.sh` for the database
Inside `provision_db.sh` are the following contents. These commands install the necessary dependencies to run the database virtual machine. Note that there are commands that are used to specifically install MongoDB version 3.2.20 as well as needing to listen into IP 0.0.0.0 to pass the tests. Also, MongoDB must be initialised inside the virtual machine.
```
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
```

### Running the virtual machines
First, open two terminals, one for each virtual machine and both must be running as an administrator. Next, ensure that one's file location is the same as their Vagrantfile on both terminals. After that, do the following:
* Execute `vagrant up app` on one terminal
* Execute `vagrant up db` on the other terminal

After starting up the virtual machines, one is ready to run the tests.

### Running and passing the tests
Finally, one must pass the tests given. Before running the tests, one must have the two virtual machines running from following the previous section. To run the tests, do the following on a separate terminal on the host machine:
* Change file location to `tests`
* Execute `rake spec`

After this, all the tests for both the app and database should pass. There are 18 and 8 tests respectively if running on GitBash. On command line, there are 9 and 4 tests respectively.

### Linking the app and database
Now, it is time to run the app with the database. In `provision_app`, we had added an environment variable that allows the app to connect with the database. Before running the app, one must populate the database first. To populate the database, SSH into the app using `vagrant ssh app` and do the following:
* Navigate to the `seeds` directory
* Execute `node seed.js`

Once the data has been populated, do the following:
* return to the `app` directory using `cd ..` 
* Execute `node app.js`

If one gets an error involving `express` or other dependencies, they will need to run `npm install` inside the app virtual machine.

### Viewing the content
On your host machine, go on a web browser and enter the following URL:
* `http://development.local:3000/posts`
* If development.local does not work: `http://192.168.10.100:3000/posts`

Now, the web page should display similar contents to the image below:
-- ADD IMAGE --

## Linux variables
### Defining variables
To define a variable called `NAME`, do the following WITHOUT any spaces:
* `NAME="William"`

If there are spaces, Linux will think that `NAME` is a command.

### Output variables
Use the `echo` command to output the contents of `NAME`. A dollar sign (`$`) must be used as a prefix to access the variable.
* `echo $NAME`

### Environment variables (env var)
How can we check the existing env variable in our system:
* `env` - displays all existing env variables
* `printenv` - prints the contents for a single env variable
* `echo` - can also be used, but the `$` prefix is needed

`export` is the keyword to create an env variable as:
* key=value
* key="some other value"
* key=value1:value2

The system default env variables are:
* `USER`
* `HOME`
* `PATH`
* `TERM`

### Persistent environment variables
One of the ways of making the environment variables peristent is to save it into `~/.bashrc` as follows:
* `echo "export ENV_VAR_NAME=contents" >> ~/.bashrc`

The above command saves the environment variable at the end of the `~/.bashrc` file.
