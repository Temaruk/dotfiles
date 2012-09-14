alias gsync='git pull && git push'
alias most='history | awk '\''{print $2}'\'' | awk '\''BEGIN{FS="|"}{print $1}'\'' | sort | uniq -c | sort -n | tail -n 20 | sort -nr'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias lla='ls -la'
alias gpinup='git pull && git submodule init && git submodule update'

