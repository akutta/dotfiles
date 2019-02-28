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

psql_local() {
  PGPASSWORD=password psql -h localhost -U docker uats
}

psql_dev() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/dev/base_config.yml | grep rds_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pg.dev.sensiapi.com -U rscloudteam sensidev
}

psql_dr_dev() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/dev/base_config.yml | grep rds_dr_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pgdr.dev.sensiapi.com -U rscloudteam demand_responsedev
}

psql_summary_dev() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/dev/base_config.yml | grep rds_summary_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pgsummary.dev.sensiapi.com -U rscloudteam thermostat_data_summary_dev
}

psql_stage() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/stage/base_config.yml | grep rds_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pg.stage.sensiapi.com -U rscloudteam sensistage
}

psql_dr_stage() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/stage/base_config.yml | grep rds_dr_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pgdr.stage.sensiapi.com -U rscloudteam demand_responsestage
}

psql_summary_stage() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/stage/base_config.yml | grep rds_summary_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pgsummary.stage.sensiapi.com -U rscloudteam thermostat_data_summary_stage
}

psql_prod() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/prod/base_config.yml | grep rds_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pg.rds.sensiapi.io -U rscloudteam sensiprod
}

psql_summary_prod() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/prod/base_config.yml | grep rds_summary_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pgsummary.sensiapi.io -U rscloudteam thermostat_data_summary_prod
}

psql_dr_prod() {
  password=$(ansible-vault view ~/projects/sensi/ansible/ansible_aws/asset_defs/prod/base_config.yml | grep rds_dr_password | rev | cut -d ' ' -f1 | rev | sed "s/\'//g")
  PGPASSWORD=$password psql -h pgdr.rds.sensiapi.io -U rscloudteam demand_responseprod
}

alias sensi_dev='for i in credentials config; do ln -sf ~/.aws/$i.sensi ~/.aws/$i; done; ln -sf ~/.ansible-vault.sensi ~/.ansible-vault && export_creds && export DEVENV=sensi && export SOCKET_ENV=stage && export ACCESS_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicnNjbG91ZHRlYW0rc3RhZ2VAZ21haWwuY29tIiwic2FsZXNmb3JjZV9pZCI6IjAwMUMwMDAwMDFnbmo2RklBUSJ9.s4W4GMotGvul_c-u92ATabVzI2ugECz3Yp74hCKPtlU && export PARTNER_ACCESS_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiJwb3N0bWFuIiwidXNlcm5hbWUiOiJ0ZXN0QHRlc3QuY29tIn0.-o2OquZzAz-L1J3uRN-yhtpFj-bzhl169kqLuLLDlg4'
alias cg_dev='for i in credentials config; do ln -sf ~/.aws/$i.cg ~/.aws/$i; done; ln -sf ~/.ansible-vault.cg ~/.ansible-vault && export_creds && export DEVENV=cg'
alias portal_dev='for i in credentials config; do ln -sf ~/.aws/$i.portal ~/.aws/$i; done; ln -sf ~/.ansible-vault.portal ~/.ansible-vault && export_creds && export DEVENV=portal'
alias sensi_prod='for i in credentials config; do ln -sf ~/.aws/$i.sensiprod ~/.aws/$i; done; ln -sf ~/.ansible-vault.sensiprod ~/.ansible-vault && export_creds && export DEVENV=sensiprod && export SOCKET_ENV=prod && export ACCESS_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoicnNjbG91ZHRlYW0rcHJvZEBnbWFpbC5jb20iLCJzYWxlc2ZvcmNlX2lkIjoiMDAxQzAwMDAwMVdzdlNpSUFKIn0.8ss95tWQhmECaK_vqazEf0yKTJq1okwSlRXjNQ_89n4 && export PARTNER_ACCESS_TOKEN=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJjbGllbnRfaWQiOiJwb3N0bWFuIiwidXNlcm5hbWUiOiJ0ZXN0QHRlc3QuY29tIn0.ud57ZttFZfjent-6VhycCrxy5RYshmQJ3JRCrRxqE8s'
alias wwex_dev='for i in credentials config; do ln -sf ~/.aws/$i.wwex ~/.aws/$i; done; ln -sf ~/.ansible-vault.wwex ~/.ansible-vault && export_creds && export DEVENV=wwex'
alias kmstest='for i in credentials config; do ln -sf ~/.aws/$i.kms ~/.aws/$i; done; ln -sf ~/.ansible-vault.kms ~/.ansible-vault && export_creds && export DEVENV=kms'

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

. ~/projects/sensi/ansible/ansible_aws/ansible/hacking/env-setup

. ~/nvm.sh
