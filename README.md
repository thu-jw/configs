# Configs 

## zsh

```shell
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

```shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting


```

## Conda
```
wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh
```

## tmux
```
wget https://raw.githubusercontent.com/thu-jw/configs/master/tmux/.tmux.conf
```

## neovim
installation:
https://github.com/neovim/neovim/releases/tag/nightly
```
wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x nvim.appimage && ./nvim.appimage
```

### Plugin
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
```
mkdir -p ~/.config/nvim
curl -o ~/.config/nvim/init.vim https://raw.githubusercontent.com/thu-jw/configs/master/nvim/init.vim
```

### Node
```
echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.zshrc
mkdir ~/.local
mkdir ~/node-latest-install
cd ~/node-latest-install
wget -c http://nodejs.org/dist/node-latest.tar.gz | tar xz --strip-components=1
./configure --prefix=~/.local
make install 
wget -c https://www.npmjs.org/install.sh | sh  
```
