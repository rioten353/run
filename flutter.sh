#!/bin/bash

sudo apt-get install -y curl git unzip xz-utils zip -y

sudo apt-get install \
      clang cmake git \
      ninja-build pkg-config \
      libgtk-3-dev liblzma-dev -y


wget https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.24.4-stable.tar.xz

tar -xf flutter_linux_3.24.4-stable.tar.xz 

echo 'export PATH="~/flutter/bin:$PATH"' >> ~/.bashrc

git config --global --add safe.directory /root/flutter

