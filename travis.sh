#!/usr/bin/env sh
set -evx
env | sort

make

if [ "$TRAVIS_OS_NAME" = "linux" ]; then
  git clone https://github.com/google/chaps-linux
  (
    cd chaps-linux || exit
    make DPKGSIGN="-us -uc" package
    dpkg -i ./*chaps*amd64.deb
  )
  make test_chaps
fi
