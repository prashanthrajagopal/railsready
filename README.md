#Rails Ready
###Ruby and Rails setup script for Linux and OSX
###Distros supported:
 * Ubuntu
 * CentOS 5 (utilizes the Fedora EPEL repo)
 * OSX (requires XCode/GCC to be installed. Install command line tools via XCode->preferences to install GCC)

#
###To run:
####Linux
  * `wget --no-check-certificate https://raw.github.com/prashanthrajagopal/railsready/master/railsready.sh && bash railsready.sh`

####OSX
  * `curl -O https://raw.github.com/prashanthrajagopal/railsready/master/railsready.sh && bash railsready.sh`

The script will ask if you want to build Ruby from source or install RVM

###What this gives you:
  * Homebrew (OSX only)
  * Ruby 1.9.3 latest patch level (installed to /usr/local/bin/ruby) or RVM running 1.9.3 latest patch level
  * OR Ruby 1.8.7 - ree for legacy users with UBUNTU only... 
  * Imagemagick
  * libs needed to run Rails (sqlite, mysql, etc)
  * Bundler, Passenger, and Rails gems
  * Git

Please note: If you are running on a super slow connection your sudo session may timeout and you'll have to enter your password again. If you're running this on an EC2 or RS instance it shouldn't be problem.

Just install either NGINX or Apache, run passenger-install-nginx-module or passenger-install-apache-module, upload your app, point your vhost config to your apps public dir and go!

A note about RVM+passenger+nginx:
Passenger installed via RVM can't locate the OpenSSL package installed on Ubuntu. A user contributed fix is as follows:

````
rvm remove 1.9.3
rvm pkg install openssl
rvm install 1.9.3 --with-openssl-dir=$HOME/.rvm/usr
rvmsudo passenger-install-nginx-module
````

#
####Rails Ready now supports a "plugin" type system. The distro is detected and a corresponding "recipe" file is pulled down to run the distro specific setup steps. Check the recipes dir to see if your distro is supported. If you would like to add support for a system fork the repo, write a recipe, and submit a pull request. Take a look at recipes/ubuntu.sh for an idea of what to model your recipe after.

If you use this or have any suggestions let me know at prashanth.rajagopal@icloud.com

The original railsready is written by joshfng@gmail.com. I have just made a few changes to enable installation of legacy ruby 1.8.7.
This script also installs jdk 6 update 29. 

Java Installation happens only in Ubuntu as of now. 

Thanks to joshfng@gmail.com.
