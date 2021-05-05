# Multi-machine Vagrant with DB
Before doing any of these instructions, one must complete the previous section first to enable testing (Running tests).

## Create a Vagrant file
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

## Create `provision_app.sh` for the app
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

# Install npm with pm2 -g
sudo npm install pm2 -g
```

## Create `provision_db.sh` for the database
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

## Install Hostsupdater
* Execute `vagrant plugin install vagrant-hostsupdater --plugin-version=1.0.2` to install the specified version (recommended)
* Execute `vagrant plugin install vagrant-hostsupdater` to install the latest version

## Running the virtual machines
First, open two terminals, one for each virtual machine and both must be running as an administrator. Next, ensure that one's file location is the same as their Vagrantfile on both terminals. After that, do the following:
* Execute `vagrant up app` on one terminal
* Execute `vagrant up db` on the other terminal

After starting up the virtual machines, one is ready to run the tests.

### Hostsupdater Bug
* If running `vagrant up` throws an error, comment out the `private_network` and `.aliases` lines, then run `vagrant up` again
* After the machine(s) is running, use `vagrant halt`, then uncomment the previously mentioned lines
* Now, use `vagrant up` and there shouldn't be any issues

## Running and passing the tests
Finally, one must pass the tests given. Before running the tests, one must have the two virtual machines running from following the previous section. To run the tests, do the following on a separate terminal on the host machine:
* Change file location to `environment/spec-tests`
* Execute `gem install bundler:2.2.9`
* Execute `bundle init`
* Execute `rake spec` to run the tests
* Change file location to `tests` (more tests)
* Execute `rake spec`

After this, all the tests for both the app and database should pass.

## Linking the app and database
Now, it is time to run the app with the database. In `provision_app`, we had added an environment variable that allows the app to connect with the database. Before running the app, one must populate the database first. To populate the database, SSH into the app using `vagrant ssh app` and do the following:
* Navigate to the `seeds` directory using `cd app/app/seeds`
* Execute `node seed.js`

Once the data has been populated, do the following:
* Return to the `app` directory using `cd ..` 
* Execute `node app.js`

If one gets an error involving `express` or other dependencies, they will need to run `npm install` in the `app/app` directory in the virtual machine.

## Viewing the content
On the host machine, go on a web browser and enter the following URL:
* `http://development.local:3000/posts`
* If development.local does not work, there's an issue with the aliasing. Try the IP: `http://192.168.10.100:3000/posts`

Now, the web page should display similar contents to the image below:
![image](https://user-images.githubusercontent.com/44005332/114748220-99984a00-9d49-11eb-8d30-53551640569b.png)
