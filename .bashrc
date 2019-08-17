#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.

alias ls="ls -hN --color=auto --group-directories-first" 
alias ll='ls -l'
alias la='ls -la'
alias grep="grep --color=auto" 
alias diff="diff --color=auto" 
		
PS1='\e[0;32m[\u@\h \e[0m\W\e[0;32m]\e[0m\$ '
