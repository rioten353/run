#!/bin/bash

wget https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/wezterm-20240203-110809-5046fc22.Ubuntu20.04.deb

sudo dpkg -i wezterm-20240203-110809-5046fc22.Ubuntu20.04.deb

sudo apt --fix-broken install -y

git clone https://github.com/rioten353/wezterm

mv wezterm/wezterm.lua ~/.wezterm.lua

