# hello world
echo "interactive login zsh"

# alias 
alias fd=fdfind
alias clear="echo -e \"\033c\""

# zim 
export ZIM_HOME=~/.config/zim/.zim 
export ZDOTDIR=~ 
source ~/.config/zim/.zimrc

# zsh
alias ezsh="vim ~/.zshrc"
alias szsh="source ~/.zshrc"

# ip and proxy
alias iplocal="ifconfig enp5s0 | rg 'inet ' | awk '{ print \$2 }'"
alias ippublic='curl ipinfo.io'
# alias proxy='export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890'
alias unproxy='unset all_proxy http_proxy https_proxy'
# proxy

# local bin 
export PATH=$PATH:~/.local/bin

# Scrpit 
source ~/.efficient_scripts.sh

# zoxide 
eval "$(zoxide init --cmd cd zsh)"

# c/cpp tool chain
# export CXXFLAGS="-stdlib=libc++"
# export LDFLAGS="-stdlib=libc++"

# cuda toolkit
export PATH=/usr/local/cuda-12.6/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# hugging face mirror
export HF_ENDPOINT=https://hf-mirror.com
