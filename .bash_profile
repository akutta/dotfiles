export PATH=/Users/akutta/erlang/17.5/bin:/Users/akutta/.rbenv/shims:/Users/akutta/.rbenv/shims:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/share/dotnet:/Users/akutta/projects/go/bin:/Users/akutta/projects/go/bin:/usr/local/Cellar/mysql/5.6.27/bin:/usr/local/mysql/bin
alias ll='ls -lahG'
alias refresh_ec2='/etc/ansible/ec2.py --refresh-cache'
alias flushdns='sudo killall -HUP mDNSResponder'
alias screen_tstat='script -a -t 0 screen.log screen /dev/cu.usbserial-FTWKTMM0 115200'

export MONO_GAC_PREFIX="/usr/local"
alias docker-rm='docker rm $(docker ps -a -q) -f'
alias myip='dig +short myip.opendns.com @resolver1.opendns.com'

export LANG="en_US.UTF-8"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
#export PYTHONPATH="/usr/local/lib/python2.7/site-packages"
export GOPATH=$HOME/projects/go
export MYSQL_PATH=/usr/local/Cellar/mysql/5.6.27
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$MYSQL_PATH/bin
export ANSIBLE_VAULT_PASSWORD_FILE=~/.ansible-vault
export ANSIBLE_HOST_KEY_CHECKING=False


alias vi=vim

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
#eval "$(rbenv init -)"
.  ~/erlang/17.5/activate

export_creds() {
  export AWS_ACCESS_KEY=`grep aws_access_key ~/.aws/credentials | cut -d" " -f3`
  export AWS_SECRET_KEY=`grep aws_secret_access_key ~/.aws/credentials | cut -d" " -f3`
  export AWS_REGION=`grep region ~/.aws/config | cut -d" " -f3`
}

alias sensi_dev='for i in credentials config; do ln -sf ~/.aws/$i.sensi ~/.aws/$i; done; ln -sf ~/.ansible_vault.sensi ~/.ansible_vault && export_creds && export DEVENV=sensi && export SOCKET_ENV=stage'
alias cg_dev='for i in credentials config; do ln -sf ~/.aws/$i.cg ~/.aws/$i; done; ln -sf ~/.ansible_vault.cg ~/.ansible_vault && export_creds && export DEVENV=cg'
alias portal_dev='for i in credentials config; do ln -sf ~/.aws/$i.portal ~/.aws/$i; done; ln -sf ~/.ansible_vault.portal ~/.ansible_vault && export_creds && export DEVENV=portal'
alias sensi_prod='for i in credentials config; do ln -sf ~/.aws/$i.sensiprod ~/.aws/$i; done; ln -sf ~/.ansible_vault.sensiprod ~/.ansible_vault && export_creds && export DEVENV=sensiprod && export SOCKET_ENV=prod'
alias wwex_dev='for i in credentials config; do ln -sf ~/.aws/$i.wwex ~/.aws/$i; done; ln -sf ~/.ansible_vault.wwex ~/.ansible_vault && export_creds && export DEVENV=wwex'

export DEVENV=`ls -l ~/.aws/config | rev | cut -d. -f1 | rev`
export PS1="\h:\W \u[\${DEVENV}]:\$ "

export ANSIBLE_NOCOWS=1

export_creds
set_iterm_name() {
  mode=$1; shift
  echo -ne "\033]$mode;$@\007"
}
iterm_both () { set_iterm_name 0 $@; }
iterm_tab () { set_iterm_name 1 $@; }
iterm_window () { set_iterm_name 2 $@; }


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi
complete -C '`which aws_completer`' aws
