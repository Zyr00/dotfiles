#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -s autocd #Allows you to cd into directory merely by typing the directory name.

alias ls="ls -hN --color=auto --group-directories-first" 
alias ll='ls -lh'
alias la='ls -lah'
alias grep="grep --color=auto" 
alias diff="diff --color=auto" 
		
PS1='\e[0;32m[\u@\h \e[0m\W\e[0;32m]\e[0m\$ '

function colors1 () 
{ 
    echo "aa 256\n"
    local o= i= x=`tput op` cols=`tput cols` y= oo= yy=;
    y=`printf %$(($cols-6))s`;
    yy=${y// /=};
    for i in {0..256};
    do
        o=00${i};
        oo=`echo -en "setaf ${i}\nsetab ${i}\n"|tput -S`;
        echo -e "${o:${#o}-3:3} ${oo}${yy}${x}";
    done
}

function colors2 ()
{
    echo "aa c666\n"
    local r= g= b= c= CR="`tput sgr0;tput init`" C="`tput op`" n="\n\n\n" t="  " s="    ";
    echo -e "${CR}${n}";
    function c666 ()
    {
        local b= g=$1 r=$2;
        for ((b=0; b<6; b++))
        do
            c=$(( 16 + ($r*36) + ($g*6) + $b ));
            echo -en "setaf ${c}\nsetab ${c}\n" | tput -S;
            echo -en "${s}";
        done
    };
    function c666b ()
    {
        local g=$1 r=;
        for ((r=0; r<6; r++))
        do
            echo -en " `c666 $g $r`${C} ";
        done
    };
    for ((g=0; g<6; g++))
    do
        c666b=`c666b $g`;
        echo -e " ${c666b}";
        echo -e " ${c666b}";
        echo -e " ${c666b}";
        echo -e " ${c666b}";
        echo -e " ${c666b}";
    done;
    echo -e "${CR}${n}${n}"
}
