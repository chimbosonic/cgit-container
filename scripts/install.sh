#!/bin/bash
set -e

# Install run dependencies
function setup() {
  echo "Installing run dependencies"
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
  apt-get update
  apt-get install -y supervisor highlight python3-markdown apache2 lua-luaossl curl
}


function setup_apache() {
  a2enmod rewrite && a2enmod cgi
  cd /etc/apache2/mods-enabled
  ln -s ../mods-available/cgi.load cgi.load
  rm /etc/apache2/sites-enabled/000-default.conf
  ln -s /etc/apache2/sites-available/cgit.conf /etc/apache2/sites-enabled/
}


#Cleanup
function cleanup() {
  echo "Cleaning up"
  apt-get auto-remove -y
  apt-get clean
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
}

setup
setup_apache
cleanup
