########################################################
#    ____ _____
#   |  _ \_   _|
#   | |_) || |
#   |  __/ | |
#   |_|    |_|
#
########################################################
# This fish config file was inspired by the config file
# shared by Derek Taylor (DistroTube) in his gitlab:
#    http://www.gitlab.com/dwt1/ 
########################################################

### EXPORTS ###
# First line removes the path; second line sets it.  Without the first line,
# your path gets massive and fish becomes very slow.
set -e fish_user_paths
set -U fish_user_paths $HOME/.local/bin $HOME/.local/bin/statusbar $HOME/Applications /usr/local/bin/QNAP/QsyncClient $fish_user_paths
set fish_greeting                      # Supresses fish's intro message
set TERM "xterm-256color"              # Sets the terminal type
set EDITOR "nvim"
#set -x OPENAI_API_KEY (cat ~/.config/nvim/chatgpt.conf)

### AUTOCOMPLETE AND HIGHLIGHT COLORS ###
set fish_color_normal brcyan
set fish_color_autosuggestion '#7d7d7d'
set fish_color_command brcyan
set fish_color_error '#ff6c6b'
set fish_color_param brcyan

### FUNCTIONS ###
# Set default 'vi' mode
function fish_user_key_bindings
  # fish_default_key_bindings
  fish_vi_key_bindings
end
### END OF VI MODE ###
# Functions needed for !! and !$
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
# The bindings for !! and !$
if [ $fish_key_bindings = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Function for creating a backup file
# ex: backup file.txt
# result: copies file as file.txt.bak
function backup --argument filename
    cp $filename $filename.bak
end

# Function for pdf malware analisys
# ex: mwpdfscan file.pdf
# result: copies file as file.txt.bak
function mwpdfscan --argument filename
    docker run -v (pwd):/data cincan/jsunpack-n /data/$filename -V -d /data/output
end


### ALIASES ###
alias nv='nvim'     #Start nvim


alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" #Git command to manage bare git reposiory for my dotfiles

# Alias for docker commands
alias dcr="docker compose run --rm"     #Docker command com run an immage using a composer yaml file
alias dcf="docker compose logs -f"      #Docker command to look at the running immage logs using a composer yaml file
alias dc="docker compose"               #Docker compose command

# Colorize grep output (good for log files)
alias grep='grep --color=auto'          #Colorize grep output
alias egrep='egrep --color=auto'        #Colorize egrep output
alias fgrep='fgrep --color=auto'        #Colorize fgrep output

# human-readable sizes
alias df='df -h'            #df command with human readable sizes
alias free='free -m'        #free command with human readable sizes
alias dum='du -BM -d1'      #disk usage command in MB only for the Level 1 directory

# broot
alias br='broot -dhp'       #broot command to browse through the directory structure
alias bs='broot --sizes'    #broot command to show directory sizes

# confirm before overwriting
alias rm='rm -i'            #rm command change the default behaviour to confirm before executing
alias mv='mv -i'            #mv command change the default behaviour to confirm before executing
alias cp="cp -i"            #cp command change the default behaviour to confirm before executing

# termbin
alias tb="nc termbin.com 9999"      #termbin to paste comandline output

# pacman and yay
alias pacsyu='sudo pacman -Syyu'                 #update only standard pkgs
alias yaysua='yay -Sua --noconfirm'              #update only AUR pkgs
alias yaysyu='yay -Syu --noconfirm'              #update standard pkgs and AUR pkgs
alias unlock='sudo rm /var/lib/pacman/db.lck'    #remove pacman lock
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'  #remove orphaned packages

# Changing "ls" to "exa"
alias ll='exa -al --color=always --group-directories-first' #list dir command -> my preferred listing
alias la='exa -a --color=always --group-directories-first'  #list all files and dirs
alias ls='exa -l --color=always --group-directories-first'  #list dir long format
alias lt='exa -aT --color=always --group-directories-first' #tree listing

# navigation
alias ..='cd ..'                 #back one dir
alias ...='cd ../..'             #back two dirs
alias .3='cd ../../..'           #back three dirs
alias .4='cd ../../../..'        #back four dirs
alias .5='cd ../../../../..'     #back five dirs

### START NEOFECH ###
neofetch

### CONDA INITIATIZATION ###
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
alias conda_init='eval /home/pedro/anaconda3/bin/conda "shell.fish" "hook" $argv | source'
# <<< conda initialize <<<

