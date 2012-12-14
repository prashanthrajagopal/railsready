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
whichRuby=$6 # 1=source 2=RVM
script_runner=$(whoami)
railsready_path=$7
log_file=$8

#echo "vars set: $ruby_version $ruby_version_string $ruby_source_url $ruby_source_tar_name $ruby_source_dir_name $whichRuby $railsready_path $log_file"

#test if aptitude exists and default to using that if possible
if command -v aptitude >/dev/null 2>&1 ; then
  pm="aptitude"
else
  pm="apt-get"
fi

echo -e "\nUsing $pm for package installation\n"

# Install build tools
echo -e "\n=> Installing build tools..."
sudo $pm -y install \
    wget curl build-essential clang \
    bison openssl zlib1g \
    libxslt1.1 libssl-dev libxslt1-dev \
    libxml2 libffi-dev libyaml-dev \
    libxslt-dev autoconf libc6-dev \
    libreadline6-dev zlib1g-dev libcurl4-openssl-dev \
    libtool >> $log_file 2>&1
echo "==> done..."

echo -e "\n=> Installing libs needed for sqlite and mysql..."
sudo $pm -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient-dev >> $log_file 2>&1
echo "==> done..."

# Install imagemagick
echo -e "\n=> Installing imagemagick (this may take a while)..."
sudo $pm -y install imagemagick libmagick9-dev >> $log_file 2>&1
echo "==> done..."

# Install git-core
echo -e "\n=> Installing git..."
sudo $pm -y install git-core >> $log_file 2>&1
echo "==> done..."

# Install memcached
echo -e "\n=> Installing git..."
sudo $pm -y install memcached >> $log_file 2>&1
echo "==> done..."

# Install SVN
echo -e "\n=> Installing SVN..."
sudo $pm -y install subversion >> $log_file 2>&1
echo "==> done..."  

# Install dependancies for nokogiri and rmagick gems
echo -e "\n=> Installing dependancies for nokogiri and rmagick gems..."
sudo $pm -y install libxslt-dev libxml2-dev libmagickwand-dev >> $log_file 2>&1
echo "==> done..."  

# Install vim
echo -e "\n=> Installing vim..."
sudo $pm -y install vim >> $log_file 2>&1
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
