# shell-configs
Repository for my shell configurations. 

Steps to Setup Vim on new laptop

1. Install Vundle using the instructions listed here: https://github.com/VundleVim/Vundle.vim
2. Point the rtp path in the .vimrc file to the Vundle.vim file destination
3. Open vim (look for no syntax errors on startup) and then run `:PluginInstall` command to install Vundle plugins for vim 

Setup Oh-my-zsh on shell (Terminal or iTerm2) 

1. Run `sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"` in terminal to install
