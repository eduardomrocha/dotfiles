#!/bin/bash
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
bold=$(tput bold)
reset=$(tput sgr0)

ask() {
  declare -r message=$1
  declare default=$2
  declare -r color=$3
  declare y='[y]es' n='[n]o'

  [[ $default ]] && {
    [[ y == $default* ]] && y="$bold[Y]es$reset"
    [[ n == $default* ]] && n="$bold[N]o$reset"
  }

  while read -erp "$color$message $y/$n: " default
  do
    [[ y == $default* ]] && return 0
    [[ n == $default* ]] && return 1
  done
}

DOWNLOADS="$HOME/Downloads/"
WSL="/proc/sys/fs/binfmt_misc/WSLInterop"
DOTFILES="$(dirname $(realpath "$0"))"

WezTerm() {
  declare color=$1

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ ! -f "$WSL" ]; then
      # install wezterm
      cd $DOWNLOADS
      git clone 'https://mpr.makedeb.org/wezterm-bin'
      cd wezterm-bin/
      makedeb -si
    else
      # instructions for WSL users
      echo "$bold${color}Install WezTerm manually: https://wezfurlong.org/wezterm/install/windows.html"
      echo "$bold${color}Copy wezterm.lua file manually from 'dotfiles/wezterm/' to C:\Program Files\WezTerm"
    fi
  else
    # install wezterm
    brew install --cask wezterm
  fi
}

copy_wezterm_config() {
  ln -sfT $DOTFILES/wezterm $HOME/.config/wezterm
}

tmux() {
  declare color=$1

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    cd $DOWNLOADS
    git clone 'https://mpr.makedeb.org/tmux'
    cd tmux/
    makedeb -si
  else
    # install tmux
    brew install tmux
  fi

  echo "$bold${color}Installing tpm..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

copy_tmux_config() {
  ln -sf $DOTFILES/.tmux.conf $HOME/.tmux.conf
}

zsh() {
  declare color=$1

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # install zsh
    sudo apt install -y zsh
  else
    # install zsh
    brew install zsh
  fi

  echo "$bold${color}Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "$bold${color}Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
}

copy_zsh_config() {
  ln -sf $DOTFILES/.zshrc $HOME/.zshrc
  echo "$bold${color}Copying Powerlevel10k config..."
  ln -sf $DOTFILES/.p10k.zsh $HOME/.p10k.zsh
}

Neovim() {
  declare color=$1

  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    if [ -f "$WSL" ]; then
      # install dictionary (cmp-look dependency)
      sudo apt install -y wamerican
    fi

    # install neovim
    cd $DOWNLOADS
    git clone 'https://mpr.makedeb.org/neovim'
    cd neovim/
    makedeb -si
  else
    # install neovim
    brew install neovim
  fi

  echo "$bold${color}Installing AstroNvim..."
  git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
}

copy_neovim_config() {
  git clone git@github.com:eduardomrocha/astronvim_config.git ~/.config/nvim/lua/user
}

fzf() {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}

declare -A colors=(
  [WezTerm]=$red
  [tmux]=$blue
  [zsh]=$green
  [Neovim]=$yellow
  [fzf]=$white
)

declare -A configs=(
  [WezTerm]=copy_wezterm_config
  [tmux]=copy_tmux_config
  [zsh]=copy_zsh_config
  [Neovim]=copy_neovim_config
)

declare -ar tools=(
  WezTerm
  tmux
  zsh
  Neovim
  fzf
)

install_tools() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # install makedeb
    bash -ci "$(wget -qO - 'https://shlink.makedeb.org/install')"

    if [ ! -d "$DOWNLOADS" ]; then
      mkdir $DOWNLOADS
    fi
  fi

  for tool in "${tools[@]}";
  do
    declare color=${colors[$tool]}
    if ask "${bold}Install $tool?$reset" y $color; then
      echo "$bold${color}Installing ${tool}..."
      ${tool} $color
      tput sgr0
    else
      echo "${color}Skiping $tool$reset"
    fi
  done
}

instructions() {
cat <<- EOF
$bold${magenta}Instructions:
- Open Neovim with "nv" to install plugins.
- Start tmux and press prefix + I to install plugins.
- Manually Download and Install FiraCode Nerd Font (https://www.nerdfonts.com/font-downloads).
EOF
}

copy_configs() {
  for tool in "${tools[@]}";
  do
    [ ! "${configs[$tool]+1}" ] && continue

    declare color=${colors[$tool]}
    if ask "${bold}Copy $tool config?$reset" y $color; then
      echo "${color}Copying ${tool} config..."
      ${configs[$tool]}
      tput sgr0
    else
      echo "${color}Skiping $tool config...$reset"
    fi
  done

  # git message
  echo "$bold${cyan}Copying .gitmessage..."
  ln -sf $DOTFILES/.gitmessage $HOME/.gitmessage
}

usage() {
cat <<- EOF
$green${bold}Usage:
    $(basename "$0") [ all | tools | configs ]

    all       Install tools and copy configurations.
    tools     Install tools, but do not copy configurations.
    configs   Copy configurations.$reset

EOF
}

main() {
  declare all install config usage

  if [[ "$@" == all ]]; then
    all=1
  elif [[ "$@" == tools ]]; then
    install=1
  elif [[ "$@" == configs ]]; then
    config=1
  else
    usage=1
    echo "$red$bold'$@' in not a valid option$reset"
  fi

  (( usage )) && {
    usage
    return 1
  }

  (( all )) && {
    install_tools
    copy_configs
    instructions
    return 1
  }

  (( install )) && {
    install_tools
    instructions
    return 1
  }

  (( config )) && {
    copy_configs
    return 1
  }

  echo "$mode"
}

main "$@"
