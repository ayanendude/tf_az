#!/bin/bash

echo "hello world"
sudo apt-get update
wget https://apt.puppetlabs.com/puppet6-release-bionic.deb
sudo dpkg -i puppet6-release-bionic.deb
sudo apt-get update
sudo apt install -y puppet-agent
