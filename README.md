
RHEL
```shell
sudo dnf install -y tmux node tmux zsh nodejs make cmake gcc gcc-c++ golang
git clone https://github.com/ryanoasis/nerd-fonts ; cd nerd-fonts ; ./setup.sh
```

Golang dependencies
```shell
go install golang.org/x/tools/gopls@latest
go install mvdan.cc/gofumpt@latest
go install github.com/segmentio/golines@latest
go install golang.org/x/tools/cmd/goimports@latest
```

Install rust
```shell
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

Install tree-sitter
```shell
cargo install tree-sitter-cli --git https://github.com/tree-sitter/tree-sitter.git --tag v0.18.3
```

LUA:

Install luarocks:
```shell
brew install luarocks
```

Install lua formatting packet:
```shell
cargo install stylua
```