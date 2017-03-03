defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 15

defaults read NSGlobalDomain InitialKeyRepeat

alias diary="cd ~/code/Diary; vim README.md"
alias oramaenv='source ~/Orama/minha_conta/venv/bin/activate'
alias mysqlserver='sudo /usr/local/mysql/support-files/mysql.server'

export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:${DYLD_LIBRARY_PATH}"
export PATH="/usr/local/mysql/lib:${PATH}"

export PATH="~/go-ethereum/build/bin:${PATH}"
export PATH="~/Library/Application Support/mist/binaries/swarm/unpacked:${PATH}"
export PATH="~/Library/Application Support/mist/binaries/geth/unpacked:${PATH}"
export PATH="~/solidity/build/solc:${PATH}"

export PATH="~/bin/haste-compiler/bin:${PATH}"

export PATH="/Users/v/code/aff/.stack-work/install/x86_64-osx/ghc-7.10.2/7.10.2/bin:${PATH}"

export PATH="~/Code/eth/testnet:${PATH}"

alias closure="java -jar ~/bin/closure.jar"
alias closure0="java -jar ~/bin/closure.jar --compilation_level WHITESPACE_ONLY"
alias closure1="java -jar ~/bin/closure.jar --compilation_level SIMPLE"
alias closure2="java -jar ~/bin/closure.jar --compilation_level ADVANCED"


alias vsync="rsync -azP ~/code/reddit/ v@162.243.40.54:~/reddit;"

alias ccc="ssh v@45.55.199.107"
alias cc="ssh v@107.170.113.76"
alias ccsync="rsync -azP ~/code/CoinCap-api/v2/ --exclude=node_modules/ --exclude=data/ --exclude=urls.js v@45.55.199.107:~/coincap; rsync -azP ~/code/CoinCap-api/v2/ --exclude=node_modules/ --exclude=data/ --exclude=urls.js v@107.170.113.76:~/coincap"
alias fofinsync="rsync -azP ~/code/fofin --exclude=node_modules/ v@107.170.113.76:~"

export PATH=$PATH:/Users/v/bin
alias vim='mvim -v'

# alias vsync='rsync --exclude=".git/" --progress --recursive --delete --force -Lruae ssh ~/Viclib vh@viclib.com:~'

export PATH=$PATH:/Users/v/haskell/old_lambdawiki/bin
export PATH=$PATH:/Users/v/haskell/Caramel/bin
export PATH=$PATH:/Users/v/backup
export PATH=$PATH:/Users/v/code/aff/.stack-work/install/x86_64-osx/ghc-7.10.2/7.10.2/bin

# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi

if [ -e /Users/v/.nix-profile/etc/profile.d/nix.sh ]; then . /Users/v/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# alias vsync='rsync --exclude=".git/" --progress --recursive --delete --force -Lruae ssh ~/Dropplets vh@lambda.wiki:~'

alias coincap="ssh ubuntu@52.91.191.48"

alias ls='ls -FhlG'

alias tree='tree -I "*.dyn_hi|*.dyn_o|*.o|*.jsexe*|*.hi|*.js_o|*.js_hi|dist|bin"'

# unregister broken GHC packages. Run this a few times to resolve dependency rot in installed packages.                                                                                                                                     
# ghc-pkg-clean -f cabal/dev/packages*.conf also works.                                                                                                                                                                                     
function ghc-pkg-clean() {
    for p in `ghc-pkg check $* 2>&1  | grep problems | awk '{print $6}' | sed -e 's/:$//'`
    do
        echo unregistering $p; ghc-pkg $* unregister $p
    done
}

# remove all installed GHC/cabal packages, leaving ~/.cabal binaries and docs in place.                                                                                                                                                     
# When all else fails, use this to get out of dependency hell and start over.                                                                                                                                                               
function ghc-pkg-reset() {
    read -p 'erasing all your user ghc and cabal packages - are you sure (y/n) ? ' ans
    test x$ans == xy && ( \
        echo 'erasing directories under ~/.ghc'; rm -rf `find ~/.ghc -maxdepth 1 -type d`; \
        echo 'erasing ~/.cabal/lib'; rm -rf ~/.cabal/lib; \
        # echo 'erasing ~/.cabal/packages'; rm -rf ~/.cabal/packages; \                                                                                                                                                                     
        # echo 'erasing ~/.cabal/share'; rm -rf ~/.cabal/share; \                                                                                                                                                                           
        )
}

alias cabalupgrades="cabal list --installed  | egrep -iv '(synopsis|homepage|license)'"

alias sb="stack build"
alias si="stack install"
alias sg="stack ghci"
alias ta="echo test alias"

export PATH="/usr/local/mysql/bin:$PATH"

alias olocal="vim /Users/v/Orama/minha_conta/orama_web/settings/local.py"

alias g="clear; echo 'hl (haelin)'; echo 'at (advisor_tool)'; echo 'ns (node_sources)'; echo 'mc (minha_conta)'; echo 'ow (orama_web)'"
alias cls="clear; ls; echo '----------'; pwd; echo '----------'"
alias ghl="cd ~/Haskell/Haelin; cls"
alias gat="cd ~/Orama/minha_conta/orama_web/advisor_tool; cls"
alias gns="cd ~/Orama/minha_conta/orama_web/advisor_tool/static/node_sources; cls"
alias gmc="cd ~/Orama/minha_conta; cls"
alias gow="cd ~/Orama/minha_conta/orama_web; cls"

# Ctags
alias ctags="`brew --prefix`/bin/ctags"


alias gethjs="geth --exec 'loadScript(\"/Users/v/crypto/eth/utils.js\")' attach"

export NVM_DIR="/Users/v/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export GOPATH="$HOME/GO/"
export PATH="$GOPATH/bin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/v/.sdkman"
[[ -s "/Users/v/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/v/.sdkman/bin/sdkman-init.sh"



alias getjson='curl -H "Content-Type: application/json" -X POST'
alias postjson='curl -H "Content-Type: application/json" -X POST'


















alias geth="geth --solc ~/solidity/build/solc/solc"
alias geth_attach_testnet="geth attach ipc:/Users/v/Library/Ethereum/testnet/geth.ipc"



export GPG_TTY=$(tty)
if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
else
    eval $(gpg-agent --daemon --write-env-file ~/.gnupg/.gpg-agent-info)
fi




alias compress_targz='tar -cvzf'
alias decompress_targz='tar -xvf'
