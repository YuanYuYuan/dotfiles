#!/usr/bin/env bash

mkdir -p /tmp/autossh
cd /tmp/autossh
wget https://www.harding.motd.ca/autossh/autossh-1.4g.tgz
tar xvf autossh-1.4g.tgz
cd autossh-1.4g
./configure --prefix $HOME/.local
make
make install
rm -rf /tmp/autossh
