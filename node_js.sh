#!/bin/bash


wget https://nodejs.org/dist/v22.11.0/node-v22.11.0-linux-x64.tar.xz

tar -xf node-v22.11.0-linux-x64.tar.xz


echo 'export PATH="$PATH:/root/node-v22.11.0-linux-x64/bin"' >> ~/.bashrc

source ~/.bashrc


