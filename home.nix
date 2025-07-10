# ~/dotfiles/home.nix
# We accept the 'profile' and 'lib' arguments from flake.nix here
{ config, pkgs, lib, profile, ... }:

{
  # Set user and home directory
  home.username = "eduardo";
  home.homeDirectory = "/home/eduardo";

  # This is required for Home Manager to work correctly
  home.stateVersion = "24.05";

  # Point to the default secrets file for sops
  sops = {
    defaultSopsFile = ./secrets.yaml;
  };

  # List of packages to install
  home.packages = with pkgs; [
    tmux
    zsh
    zsh-powerlevel10k
    fzf
    lazygit
    lazydocker
    git
    ripgrep
    nerd-fonts.geist-mono
    aspellDicts.en # Dictionary dependency for nvim-cmp

    # Dev Tools
    go
    rustup
    python3
    pipx
    fnm
    gnumake
    gcc
  ];

  fonts.fontconfig.enable = true;

  # Environment Variables
  home.sessionVariables = {
    # Common variables for all profiles
    LANG = "en_US.UTF-8";
    EDITOR = "nvim";
    GOPATH = "${config.home.homeDirectory}/go";

    # For the 'personal' profile, it gets the secret. For 'work', it gets an empty string.
    GEMINI_API_KEY = if profile == "personal"
                     then "${config.sops.secrets.GEMINI_API_KEY.value}"
                     else "";
    BRAVE_API_KEY = if profile == "personal"
                    then "${config.sops.secrets.BRAVE_API_KEY.value}"
                    else "";

  } // lib.mkIf (profile == "work") {
    # Work-specific variables
    sts_suiterc_git_prompt = "1";
    sts_suiterc_recommended = "1";
    sts_suiterc_legacy = "1";
  };

  # Manages dotfiles in the home directory's root
  home.file = {
    ".p10k.zsh" = { source = ./.p10k.zsh; };
    ".gitmessage" = { source = ./.gitmessage; };

    ".config/nvim" = {
      source = ./config/nvim;
      recursive = true;
    };

    ".config/wezterm" = {
      source = ./config/wezterm;
      recursive = true;
    };

    ".tmux.conf" = {
      source = "${config.xdg.configHome}/tmux/tmux.conf";
    };
  };

  # Configuration for specific programs
  programs = {
    home-manager.enable = true;
    fzf = { enable = true; enableZshIntegration = true; };
    neovim = { enable = true; };

    git = {
      enable = true;
      userName = "Eduardo Menezes Rocha";
      userEmail = if profile == "personal"
                  then "eduardomenezesr@gmail.com"
                  else "eduardo.nearsure@impel.ai";
      extraConfig = { commit.template = "${config.home.homeDirectory}/.gitmessage"; };
    };

    tmux = {
      enable = true;
      shell = "${pkgs.zsh}/bin/zsh";
      terminal = "tmux-256color";
      prefix = "C-n";
      mouse = true;
      plugins = with pkgs.tmuxPlugins; [
        {
          plugin = dracula;
          extraConfig = ''
            set -g @dracula-plugins "time"
            set -g @dracula-show-flags true
            set -g @dracula-show-left-icon "#S"
            set -g @dracula-show-timezone false
            set -g @dracula-show-location false
            set -g @dracula-show-battery-status false
            set -g @dracula-network-bandwidth-show-interface false
            set -g @dracula-day-month true
            set -g @dracula-military-time true
          '';
        }
        {
          plugin = resurrect;
          extraConfig = ''
            set -g @resurrect-strategy-nvim 'session'
          '';
        }
        sensible
      ];
      extraConfig = ''
        # Unbind default prefix since we changed it
        unbind C-b

        # Reload configuration file (path updated to where Home Manager places it)
        unbind r
        bind r source-file ~/.config/tmux/tmux.conf \; display "Configuration reloaded!"

        # Redefine splitting shortcuts
        bind | split-window -h
        bind - split-window -v

        # Titles (window number, program name, active (or not)
        set-option -g set-titles on
        set-option -g set-titles-string '#W #T'

        # vi-mode for copy mode
        set-window-option -g mode-keys vi
        bind-key -T copy-mode-vi 'v' send -X begin-selection
        bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

        # resize panes commands
        bind -r H resize-pane -L 1
        bind -r J resize-pane -D 1
        bind -r K resize-pane -U 1
        bind -r L resize-pane -R 1

        # renumber window on close
        set-option -g renumber-windows on
        # dont let tmux rename window
        set-option -g allow-rename off

        # Vim-aware pane navigation
        is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
        is_fzf="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?fzf$'"
        bind -n C-h run "($is_vim && tmux send-keys C-h) || tmux select-pane -L"
        bind -n C-j run "($is_vim && tmux send-keys C-j)  || ($is_fzf && tmux send-keys C-j) || tmux select-pane -D"
        bind -n C-k run "($is_vim && tmux send-keys C-k) || ($is_fzf && tmux send-keys C-k)  || tmux select-pane -U"
        bind -n C-l run  "($is_vim && tmux send-keys C-l) || tmux select-pane -R"
        bind-key -n 'C-\' if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

        # Terminal features for true color and italics
        set-option -gsa terminal-features '*:Tc'
        set-option -gsa terminal-features '*:RGB'
        set -as terminal-overrides ',xterm*:sitm=\E[3m'
        set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'
        set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'
      '';
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      history = {
        size = 10000;
        save = 10000;
        extended = true;
      };
      shellAliases = {
        nix-edit = "nvim ~/dotfiles/home.nix"; # Adjust path if needed
        nix-switch-work = "make work";
        nix-switch-personal = "make personal";
        nv = "nvim";
        gcover = "go test -coverprofile=c.out && go tool cover -html=c.out";
        lg = "lazygit";
      };
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [
          "git"
          "command-not-found"
          "tmux"
          "docker"
          "docker-compose"
          "fzf"
          "python"
        ];
      };
      # Extra initialization block for profile-specific commands
      initContent =
        ''
          # Oh My Zsh settings
          COMPLETION_WAITING_DOTS="true"
          export UPDATE_ZSH_DAYS=7
          export HIST_TIME_FORMAT="%d.%m.%Y "

          # FNM (Fast Node Manager) initialization
          eval "$(fnm env --use-on-cd)"

          source "${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme"
          # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
          [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
        ''
        + (if profile == "work" then ''
          # Settings that only run on the "work" profile
          if [[ -f "$HOME/.suiterc" ]]; then
            source "$HOME/.suiterc"
          fi
          if [[ -f "$HOME/suite/.env/bin/activate" ]]; then
            source "$HOME/suite/.env/bin/activate"
          fi
        '' else "");
    };
  };
}
