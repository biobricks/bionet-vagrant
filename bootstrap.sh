#!/bin/bash

hostname bionet-vagrant
echo "bionet-vagrant" > /etc/hostname
echo -e "\n127.0.0.1 bionet-vagrant" >> /etc/hosts

# update everything
apt update
apt upgrade

# install basic dependencies
apt install apt-transport-https

# add elasticsearch and nodejs repos and install
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -

apt update
apt install build-essential nodejs openjdk-8-jre elasticsearch

# tweak jvm setting so we don't run out of ram
cp /vagrant/elasticsearch/jvm.options /etc/elasticsearch/

# make elasticsearch auto-start on boot and restart it
systemctl enable elasticsearch.service
systemctl restart elasticsearch.service

# install latest NCBI BLAST+ binaries
cd
wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/LATEST/ncbi-blast-2.6.0+-x64-linux.tar.gz
tar xvzf ncbi-blast-2.6.0+-x64-linux.tar.gz
mv ncbi-blast-2.6.0+/bin/* /usr/local/bin/

# fetch bionet and dependencies
su -l ubuntu -c "git clone https://github.com/biobricks/bionet-new"
su -l ubuntu -c "cd bionet-new/ && npm install"
