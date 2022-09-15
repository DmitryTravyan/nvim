# Rockylinux 9

At first, we should install main tools via dnf
```shell
sudo dnf install -y node nodejs make cmake gcc gcc-c++ git wget openssl-devel lua tar unzip xclip
```

Second, enable epel9 repo and install neovim
```shell
sudo rpm -i https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
sudo dnf intall -y neovim
```

The next step is to install other languages that cannot be installed by the dns package manager.
- Rust
```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
```
- Golang
```shell
curl -fLO https://go.dev/dl/go1.19.1.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.1.linux-amd64.tar.gz
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile
rm -rf go1.19.1.linux-amd64.tar.gz
```
- Luarocks
```shell
sudo dnf config-manager --set-enabled crb
dnf install -y lua-devel
curl -fLO https://luarocks.org/releases/luarocks-3.9.1.tar.gz
tar -xzf luarocks-3.9.1.tar.gz && cd luarocks-3.9.1
./configure --lua-version=5.4 --with-lua-include=/usr/include/ && make && sudo make install
```

Install cargo packages
```shell
cargo intall ripgrep fd-find tree-sitter-cli
```

Install ruby and neovim gems
```shell
sudo dnf install -y ruby ruby-devel
sudo gen install neovim
```

Add nerd-fonts to the system
```shell
git clone https://github.com/ryanoasis/nerd-fonts ; cd nerd-fonts ; ./setup.sh
```

# Optional Golang dependencies

Golang dependencies
```shell
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install golang.org/x/tools/cmd/goimports@latest
```
