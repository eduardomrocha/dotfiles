# Usage

    ./setup.sh [ all | tools | configs ]

    all       Install tools and copy configurations.
    tools     Install tools, but do not copy configurations.
    configs   Copy configurations.

## What it will install

- **makedeb**: If you are using a Debian based OS it will install makedeb, a
simplicity-focused packaging tool for Debian archives. makedeb takes everything
developers love about targeting Debian/Ubuntu based distributions, and makes
the packaging easier, more enjoyable, and more maintainable.
- **WezTerm**: A powerful cross-platform terminal emulator and multiplexer
written by  [](https://github.com/wez/)[@wez](https://github.com/wez "GitHub
User: wez")  and implemented in Rust
- **tmux**: A terminal multiplexer. It lets you switch easily between several
programs in one terminal, detach them (they keep running in the background)
and reattach them to a different terminal.
- **tpm**: A Tmux Plugin Manager.
- **zsh**: A shell designed for interactive use, although it is also a powerful
scripting language.
- **Oh My Zsh**: A delightful, open source, community-driven framework for
managing your Zsh configuration.
- **Powerlevel10k**: A theme for Zsh. It emphasizes speed, flexibility and
out-of-the-box experience.
- **Neovim**: A project that seeks to aggressively refactor Vim in order to:
  - Simplify maintenance and encourage
  - Split the work between multiple developers
  - Enable advanced UIs without modifications to the core
  - Maximize extensibility

- **AstroNvim**: An aesthetic and feature-rich neovim config that is extensible
and easy to use with a great set of plugins.
- **fzf**: A general-purpose command-line fuzzy finder.

## What it will configure

It will copy the configuration files for the following tools:

- **WezTerm**
- **tmux**
- **zsh**
- **Powerlevel10k**
- **Neovim (AstroNvim)**
