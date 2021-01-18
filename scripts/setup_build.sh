#!/bin/bash
set -e

# Install build dependencies
function setup() {
  echo "Installing build dependencies"
  echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
  apt-get update
  apt-get install -y curl wget git xz-utils build-essential autoconf automake libtool zlib1g-dev libssl-dev highlight python-markdown lua5.2 lua-luaossl liblua5.2-dev
}

setup