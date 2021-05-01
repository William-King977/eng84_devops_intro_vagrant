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
  * **Ease of use** - tools should be simple/easy to use. It's used by other teams!
  * **Flexibility** - tools built should be flexible to change and be up-to-date
  * **Robustness** - ensure that the applications are always live
  * **Cost** - cost considerations (switch off servers when not in use etc.)

## DevOps Principles
1. Customer-Centric Action
2. End-to-End Responsibility
3. Continuous Improvement
4. Automate everything
5. Work as one team
6. Monitor and test everything

## DevOps Life Cycle Stages
* Continuous Development
* Continuous Testing
* Continuous Integration
* Continuous Delivery/Deployment
* Continuous Monitoring

## DevOps helps:
* Culture
* People/teams
* Collaboration
* Principles
* Automation tools
* SDLC
* System quality
* Cost efficiency
* Business value

# Vagrant and Linux
## Vagrant commands
* `vagrant up` - to start-up a virtual machine (VM)
* `vagrant destroy` - to destroy the VM
* `vagrant reload` - to reload the VM
* `vagrant status` - checks how many machines are running and if they are running
* `vagrant ssh` - to SSH into VM
* `vagrant halt` - to pause the VM

## Running tests
On the host machine, do the following:
* Change file location to `environment/spec-tests`
* Execute `gem install bundler:2.2.9`
* Execute `bundle`
* Then use `rack spec` to run the tests
* Note: `rack spec` can be used to run tests in other folders

## Linux variables
### Defining variables
To define a variable called `NAME`, do the following WITHOUT any spaces:
* `NAME="William"`
* If there are spaces, Linux will think that `NAME` is a command.

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
One of the ways of making the environment variables persistent is to save it into `~/.bashrc` as follows:
* `echo "export ENV_VAR_NAME=contents" >> ~/.bashrc`
* An actual example I will need soon: `echo "export DB_HOST=mongodb://192.168.10.101:27017/posts" >> ~/.bashrc`

The above command saves the environment variable at the end of the `~/.bashrc` file.

# NGINX
NGINX is open source software for web serving, reverse proxying, caching, and more. It started out as a web server designed for maximum performance and stability.

In addition to its HTTP server capabilities, it can also function as a proxy server for email and a reverse proxy, and load balancer for HTTP, TCP and UDP servers.

NGINX is commonly used as a reverse proxy and load balancer to manage incoming traffic and distribute it to slower upstream servers - anything from legacy database servers and microservices.

## Benefits of NGINX
* It's designed for cloud-native architectures, meaning that it can improve the performance of the IT infrastructure.
* NGINX is multifunctional, meaning that the same tool can be used for reverse proxy, as a web server, or its other functions. This minimises the amount of maintenance required.
* NGINX's software updates with the latest technologies.
* NGNIX's content cache and reverse proxy are used to reduce the load on application servers and make the most effective use of the underlying hardware.

## Reverse proxy with NGINX
What is the default location of our NGINX file that loads the NGINX page?
* `cd /etc/nginx/sites-available/`
* To access it: `nano /etc/nginx/sites-available/default`
* We need to use the default file in the same location to add our code to use it as our reverse proxy

### What is a reverse proxy (server)?
A reverse proxy is a server that sits behind the firewall in a private network and directs client requests to the appropriate backend server. They provide an additional level of abstraction and control to ensure the smooth flow of network traffic between clients and servers.

### Benefits of reverse proxy
They are implemented to help increase security, performance, and reliability. Other benefits include:
* **Load balancing** - reverse proxy can distribute the requests among a pool of different servers, which are all handling requests for the same website.
* **Security** - the origin of the servers are hidden and this acts as an additional defence against security attacks. It also ensures that multiple servers can be accessed from a single URL.