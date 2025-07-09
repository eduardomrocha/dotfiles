# ~/dotfiles/home.nix
# We accept the 'profile' and 'lib' arguments from flake.nix here
{ config, pkgs, lib, profile, ... }:

let
  # Variable to detect if we are running inside WSL.
  # It will be 'true' if the system is Linux AND the WSL-specific file exists.
  isWSL = pkgs.stdenv.isLinux && (builtins.pathExists /proc/sys/fs/binfmt_misc/WSLInterop);
in
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
    # wezterm is removed from here as it's now managed conditionally below
    tmux
    zsh
    fzf
    lazygit
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
  ];

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
    ".tmux.conf" = { source = ./.tmux.conf; };
    ".gitmessage" = { source = ./.gitmessage; };
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

    # wezterm is now conditional
    wezterm = lib.mkIf (!isWSL) {
      enable = true;
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
        theme = "powerlevel10k/powerlevel10k";
        plugins = [ "git" "command-not-found" "tmux" "docker" "docker-compose" "fzf" "python" ];
      };
      # Extra initialization block for profile-specific commands
      initExtra = lib.mkIf (profile == "work") ''
        # Oh My Zsh settings
        COMPLETION_WAITING_DOTS="true"
        export UPDATE_ZSH_DAYS=7
        export HIST_TIME_FORMAT="%d.%m.%Y "

        # FNM (Fast Node Manager) initialization
        eval "$(fnm env --use-on-cd)"

        # Settings that only run on the "work" profile
        if [[ -f "$HOME/.suiterc" ]]; then
          source "$HOME/.suiterc"
        fi
        if [[ -f "$HOME/suite/.env/bin/activate" ]]; then
          source "$HOME/suite/.env/bin/activate"
        fi
      '';
    };
  };

  # Manages dotfiles in ~/.config
  xdg.configFile = {
    # wezterm config is now conditional
    "wezterm" = lib.mkIf (!isWSL) {
      source = ./config/wezterm;
    };

    "nvim".source = ./config/nvim;
  };
}
