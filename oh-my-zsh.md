
https://github.com/ohmyzsh/ohmyzsh

```bash
# install
sudo apt install -y zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# verify version
zsh --version #5.8.1

# make default shell if not applied via script
chsh -s $(which zsh)
# test it is default
echo $SHELL

# copy .zshrc custom settings
code ~/.zshrc

# syntax highlightting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

