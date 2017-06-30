#!/bin/sh

which nvim > /dev/null 2>&1
if [ $? -eq 0 ]; then
	echo "neovim はインストールされませんでした。"
else
	echo "neovim をインストールします。"
	yes |
	sudo apt-get -y install software-properties-common python3-dev python3-pip
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo apt-get -y update
	sudo apt-get -y install neovim
	sudo pip3 install -U pip
	sudo pip3 install neovim
	echo "neovim install complete!"
fi
