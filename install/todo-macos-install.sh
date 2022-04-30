
# change default shell
echo "/usr/local/bin/zsh" | sudo tee -a /etc/shells
chsh -s /usr/local/bin/zsh

# zsh config
ln -s $HOME/.$USER-sh/config/zshrc .zshrc

# autojump
git clone git://github.com/wting/autojump.git &&
cd autojump &&
./install.py &&
cd .. &&
rm -rf autojump

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# download color themes
curl https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors -o $HOME/Downloads/Dracula.itermcolors
curl https://raw.githubusercontent.com/dracula/terminal-app/master/Dracula.terminal -o $HOME/Downloads/Dracula.terminal

# get powerlevel9k
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k

# ssh
mkdir $HOME/.ssh
cp -R /Volumes/NYG4000/bck/ssh .ssh

# install manuel de 1pwd et import de l'archive
# copie des préférences de divvy

cp /Volumes/NYG4000/bck/Bookmarks.plist Library/Safari/
