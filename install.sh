#!/bin/bash

askYesOrNo() {
    while true ; do
        read -p "$1 (y/n)?" answer
        case $answer in
            [yY] | [yY]es | YES )
                return 0;;
            [nN] | [nN]o | NO )
                return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

askYesOrNo "latexをインストールしますか？"
if [ $? -eq 0 ]; then
	yes | sudo apt-add-repository ppa:texlive-backports/ppa
	sudo apt-get install -y texlive-lang-cjk
fi

