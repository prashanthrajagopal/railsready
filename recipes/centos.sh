#!/bin/bash
#
# Rails Ready
#
# Author: Josh Frye <joshfng@gmail.com>
# Licence: MIT
#
# Contributions from: Wayne E. Seguin <wayneeseguin@gmail.com>
# Contributions from: Ryan McGeary <ryan@mcgeary.org>
#

ruby_version=$1
ruby_version_string=$2
ruby_source_url=$3
ruby_source_tar_name=$4
ruby_source_dir_name=$5
whichRuby=$6
script_runner=$(whoami)
railsready_path=$7
log_file=$8

epel_repo_url="http://download.fedora.redhat.com/pub/epel/5/i386/epel-release-5-4.noarch.rpm"

#echo "vars set: $ruby_version $ruby_version_string $ruby_source_url $ruby_source_tar_name $ruby_source_dir_name $whichRuby $railsready_path $log_file"

# Add the EPEL repo if centos
echo -e "\n=> Adding EPEL repo..."
sudo rpm -Uvh $epel_repo_url
echo "==> done..."

# Install build tools
echo -e "\n=> Installing build tools..."
sudo yum install -y gcc-c++ patch \
 readline readline-devel zlib zlib-devel \
 libyaml-devel libffi-devel openssl-devel \
 make automake bash curl sqlite-devel mysql-devel >> $log_file 2>&1
echo "==> done..."

# Install imagemagick
echo -e "\n=> Installing imagemagick (this may take a while)..."
sudo yum install -y ImageMagick >> $log_file 2>&1
echo "==> done..."

# Install Git
echo -e "\n=> Installing git..."
sudo yum install -y git >> $log_file 2>&1
echo "==> done..."

# Install vim
echo -e "\n=> Installing vim..."
sudo $pm -y install vim >> $log_file 2>&1
echo "==> done..." 

# Install SVN
echo -e "\n=> Installing SVN..."
sudo $pm -y install mod_dav_svn subversion >> $log_file 2>&1
echo "==> done..."  

# Install dependancies for nokogiri and rmagick gems
echo -e "\n=> Installing dependancies for nokogiri and rmagick gems..."
sudo $pm -y install gcc ruby-devel libxml2 libxml2-devel libxslt libxslt-devel >> $log_file 2>&1
echo "==> done..."  

# Install jdk6u29
echo -e "\n=> Installing jdk6u29..."
sudo mkdir /usr/lib/jvm
sudo chown -R $(whoami):$(whoami) /usr/lib/jvm
if(uname -m=="x86_64")
then 
cd /usr/lib/jvm; wget https://www.dropbox.com/s/r5ewiyqhws7fhgt/jdk-6u29-linux-x64.bin?dl=1
else
cd /usr/lib/jvm; wget https://www.dropbox.com/s/qvq7yqnomoiu5uo/jdk-6u29-linux-i586.bin?dl=1
fi
sudo chmod +x /usr/lib/jvm/jdk-6*
cd /usr/lib/jvm; sudo ./jdk-6u29*
echo "JAVA_HOME=/usr/lib/jvm/jdk1.6.0_29" >> /etc/bash.bashrc
echo "export PATH=$PATH:$JAVA_HOME/bin" >> /etc/bash.bashrc
echo "==> done..."  
