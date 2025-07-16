# Declarative Development Environment with Nix

This repository contains my personal development environment configuration, managed declaratively with Nix, Home Manager, and Nix Flakes. The goal is to have a 100% reproducible setup on any Linux, macOS, or WSL machine using a single set of files.

## ✨ Features

* **Declarative:** The entire configuration (packages, dotfiles, environment variables) is defined as code.
* **Reproducible:** Guarantees that the same environment is created on any machine. No more "it works on my machine" issues.
* **Multi-Profile:** Supports distinct configurations for **Work** and **Personal** environments, selected at activation time.
* **Unified:** The same codebase works on Ubuntu, WSL (Windows), and macOS.

---

## 🚀 Setup on a New Machine

Follow these steps to deploy this environment on a new computer.

### Step 1: Initial Dependencies

On a clean Ubuntu/Debian installation, you will likely need `git` and `curl`.

```bash
sudo apt update && sudo apt install -y git curl
```

### Step 2: Install Nix

Nix is the foundation of the entire system.

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```
After the installation is complete, **close and reopen your terminal** to load Nix into your environment.

### Step 3: Enable Nix Flakes

Our configuration uses Flakes, the modern Nix packaging system. Enable it with the following commands:

```bash
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### Step 4: Clone This Repository

Clone this repository to your local machine.

```bash
git clone git@github.com:eduardomrocha/dotfiles.git
cd dotfiles
```

### Step 5: Activate the Environment

With everything in place, use the `Makefile` to build and activate the desired profile for this machine. This single command installs all tools and configures them.

* For a **work machine**:
    ```bash
    make work
    ```
* For a **personal machine**:
    ```bash
    make personal
    ```

**Note:** The first time you run this command, it will take a **long time**. Nix is downloading and building all the tools from scratch. Subsequent activations will be much faster.

### Step 6: Set Zsh as Default Shell (One-Time Action)

Home Manager installs Zsh and configures it, but for security reasons, it does not change your user's default login shell. You must do this manually once per machine.

1.  **Find the path to the Zsh installed by Nix.**
    ```bash
    ZSH_PATH=$(which zsh)
    ```

2.  **Add the new shell to the list of allowed shells.** (This is required on Linux/WSL). This command will ask for your `sudo` password.
    ```bash
    echo $ZSH_PATH | sudo tee -a /etc/shells
    ```

3.  **Change your user's default shell.** This will ask for your user password.
    ```bash
    chsh -s $ZSH_PATH
    ```

4.  **Verify the change.** **Close and reopen your terminal completely.** You should now be greeted by the Powerlevel10k prompt. You can confirm by running `echo $SHELL`, which should show the path to your Nix-managed Zsh.

### Step 7: Final Post-Installation Setup

After opening your new Zsh terminal:

1.  **Initialize the toolchains (one-time setup):**
    * **Rust:** `rustup default stable`
    * **Node.js:** `fnm install --lts` and then `fnm default lts-latest`

Your environment is now fully configured and operational!

---

## 💻 Daily Usage

The `Makefile` in the project root simplifies all common operations.

| Command | Description |
| :--- | :--- |
| `make help` | Shows all available commands. |
| `make personal` | Activates or applies changes to the Personal profile. |
| `make work` | Activates or applies changes to the Work profile. |
| `make update` | Updates Nix dependencies (packages, Home Manager, etc.). |
| `make clean` | Cleans up old package versions to free up disk space. |

The general workflow is:
1.  Make a change to a `.nix` file.
2.  Run `make personal` or `make work` to apply it.
3.  `git commit` and `git push` to save your changes.

---

### A Note on Home Manager Installation

You might notice that there is no separate step to "install Home Manager". This is by design. Because we are using Nix Flakes, Home Manager is defined as a direct dependency in our `flake.nix` file. The `make work` command (which runs `home-manager switch --flake ...`) takes care of fetching and running the correct version of Home Manager automatically. This is one of the great advantages of using Flakes, as it makes the entire setup more self-contained and reproducible.
