#!/bin/sh

which nvim > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "neovim はインストールされませんでした。"
else
	echo "neovim をインストールします。"
	yes |
	sudo apt-get install software-properties-common python3-dev python3-pip
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get update
	sudo apt-get install neovim
	sudo pip3 install -U pip
	sudo pip3 install neovim
	echo "neovim install complete!"
fi
