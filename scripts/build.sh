#!/bin/bash
set -e

function build_cgit() {
  cd /root/cgit
  make get-git
  make LUA_PKGCONFIG=lua5.2
  make install
  sed -i '118 s/^/#/' /usr/local/lib/cgit/filters/syntax-highlighting.sh
  echo 'exec highlight --force --inline-css -f -I -O xhtml -S "$EXTENSION" 2>/dev/null' >> /usr/local/lib/cgit/filters/syntax-highlighting.sh
}

function get_cgit() {
  git clone --depth 1 https://git.zx2c4.com/cgit /root/cgit
}

get_cgit
build_cgit