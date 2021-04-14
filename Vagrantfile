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