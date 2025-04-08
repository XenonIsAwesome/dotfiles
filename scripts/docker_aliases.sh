# Containers
alias dsaq='docker stop $(docker ps -aq)'
alias dkaq='docker kill $(docker ps -aq)'
alias draq='docker rm $(docker ps -aq)'
alias dcc='dkaq; draq;'

# Images
alias drmidangl='docker rmi -f $(docker images -f dangling=true -aq)'
alias drmia='docker rmi -f $(docker images -aq)'

# System
alias dspa='docker system prune --all'
