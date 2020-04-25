###########################################
#######		ZSH configuration file	#######
###########################################


#######################
##	General Settings	##
#######################
## If not running interactively, don't do anything
[[ $- != *i* ]] && return


## Termite
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi


## Export
export EDITOR=/usr/bin/nano
export TERM=xterm-256color
#export MOZ_WEBRENDER=1
#export LC_CTYPE="sk_SK.UTF-8"
export PATH="/usr/lib/ccache/bin/:$PATH"
export PATH="/usr/lib/colorgcc/bin/:$PATH"
export CCACHE_PATH="/usr/bin"


#######################
##	  GnuPG Settings	##
#######################
## Start the gpg-agent if not already running
if ! pgrep -x -u "${USER}" gpg-agent >/dev/null 2>&1; then
  gpg-connect-agent /bye >/dev/null 2>&1
fi


## Set SSH to use gpg-agent
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
fi


## Set GPG TTY
export GPG_TTY=$(tty)
export GPG_AGENT_INFO="/usr/bin/pinentry-gtk-2"


## Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null



#######################
##		Aliases			##
#######################
if [ -f ~/.zsh_aliases ]; then
  . ~/.zsh_aliases
fi



####################
##		Sources		##
####################
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOME/.zsh_prompt
#source $HOME/.zsh_powerline



####################
##		History		##
####################
## Enable history
if [ -z "$HISTFILE" ]; then
    HISTFILE=$HOME/.zsh_history
fi


## Variables
PATH="/usr/local/bin:/usr/local/sbin/:$PATH"
HISTSIZE=1000
SAVEHIST=1000
HOSTNAME="`hostname`"
LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:';


## Show history
case $HIST_STAMPS in
  "mm/dd/yyyy") alias history='fc -fl 1' ;;
  "dd.mm.yyyy") alias history='fc -El 1' ;;
  "yyyy-mm-dd") alias history='fc -il 1' ;;
  *) alias history='fc -l 1' ;;
esac



####################
##	SHELL Options	##
####################
setopt   notify globdots correct pushdtohome cdablevars autolist
setopt   correctall autocd recexact longlistjobs
setopt   autoresume histignoredups pushdsilent 
setopt   autopushd pushdminus extendedglob rcquotes mailwarning
unsetopt bgnice autoparamslash



#######################
##		ZSH options	##
#######################
#setopt NOHUP
#setopt NOTIFY
#setopt NO_FLOW_CONTROL
setopt INC_APPEND_HISTORY SHARE_HISTORY
setopt APPEND_HISTORY
#setopt AUTO_LIST
#setopt AUTO_REMOVE_SLASH
#setopt AUTO_RESUME
unsetopt BG_NICE
setopt CORRECT
setopt EXTENDED_HISTORY
#setopt HASH_CMDS
setopt MENUCOMPLETE
setopt ALL_EXPORT
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt SHARE_HISTORY
#setopt SH_WORD_SPLIT
setopt ALIASES



###########################
##	Autoload ZSH modules	##
###########################
autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
#zmodload -ap zsh/mapfile mapfile
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end



#######################
##		Key bindings	##
#######################
autoload -U compinit
compinit
bindkey "^?" backward-delete-char
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line
bindkey '^[[5~' up-line-or-history
bindkey '^[[6~' down-line-or-history
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end
bindkey "^r" history-incremental-search-backward
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
typeset -A key
key[Delete]=${terminfo[kdch1]}
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char



###########################
##		ZSH Highlight		##
###########################
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[cursor]='fg=bold'
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=green'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green'
ZSH_HIGHLIGHT_STYLES[function]='fg=green'
ZSH_HIGHLIGHT_STYLES[bracket-error]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=magenta,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=cyan,bold'
ZSH_HIGHLIGHT_PATTERNS+=('rm -rf' 'fg=magenta,bold')
ZSH_HIGHLIGHT_PATTERNS+=('rmf' 'fg=magenta,bold')
ZSH_HIGHLIGHT_PATTERNS+=('sudo sh' 'fg=magenta,bold')



#######################
##		Load colors		##
#######################
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
   colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
   eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
   eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
   (( count = $count + 1 ))
done



####################
##		Other		##
####################
#[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null
#neofetch
#$HOME/.config/i3/Scripts/scripts/al-info
$HOME/.config/i3/Scripts/scripts/ufetch-artix

