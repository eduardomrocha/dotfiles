# Declarative Development Environment with Nix

This repository contains my personal development environment configuration, managed declaratively with Nix, Home Manager, and Nix Flakes. The goal is to have a 100% reproducible setup on any Linux, macOS, or WSL machine using a single set of files.

## ✨ Features

* **Declarative:** The entire configuration (packages, dotfiles, environment variables) is defined as code.
* **Reproducible:** Guarantees that the same environment is created on any machine. No more "it works on my machine" issues.
* **Multi-Profile:** Supports distinct configurations for **Work** and **Personal** environments, selected at activation time.
* **Secret Management:** Uses [sops-nix](https://github.com/Mic92/sops-nix) to securely manage API keys and other secrets, encrypted within the Git repository.
* **Unified:** The same codebase works on Ubuntu, WSL (Windows), and macOS.

---

## 🚀 Setup on a New Machine

Follow these steps to deploy this environment on a new computer.

### Step 1: Initial Dependencies

On a clean Ubuntu/Debian installation, you might need `git` and `curl`.

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

### Step 5: Configure Secrets with SOPS (First-Time Setup)

Your secrets (API keys, etc.) are encrypted. To decrypt them, the new machine needs your private `age` key.

#### Case A: You Already Have Your `key.txt` File

If you have previously generated your `age` key, simply copy the `key.txt` file (which you have stored in a safe place) into the root of this `dotfiles` folder.

#### Case B: This Is Your First Setup (or You Lost the Key)

You will need to generate a new key and re-encrypt your secrets.

1.  **Install `sops` and `age` temporarily:**
    ```bash
    nix-shell -p sops age
    ```

2.  **Generate a new key:**
    ```bash
    age-keygen -o key.txt
    ```
    **IMPORTANT:** Back up this `key.txt` file in an extremely secure location (password manager, vault, etc.) and add it to your `.gitignore` to NEVER commit it to Git.

3.  **Create the `secrets.yaml` file:** Create the file with your API keys and the newly generated `age` public key. Use the template below and fill in your data.

    *Template `secrets.yaml`:*
    ```yaml
    GEMINI_API_KEY: "your_value_here"
    BRAVE_API_KEY: "your_value_here"
    sops:
      age:
        - recipient: <PASTE_YOUR_PUBLIC_AGE_KEY_HERE>
          enc: ""
      creation_rules:
        - path_regex: ".*"
          key_groups:
            - age:
                - <PASTE_YOUR_PUBLIC_AGE_KEY_HERE>
    ```

4.  **Encrypt the file:**
    ```bash
    sops --encrypt --in-place secrets.yaml
    ```
5.  Exit the nix-shell by typing `exit`.

### Step 6: Activate the Environment

With everything in place, use the `Makefile` to build and activate the desired profile for this machine.

* For a **work machine**:
    ```bash
    make work
    ```
* For a **personal machine**:
    ```bash
    make personal
    ```

**Note:** The first time you run this command, it will take a **long time**. Nix is downloading and building all the tools from scratch. Subsequent activations will be much faster.

### Step 7: Set Zsh as Default Shell (One-Time Action)

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

### Step 8: Final Post-Installation Setup

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
| `make secrets` | Securely opens the secrets file for editing. |
| `make update` | Updates Nix dependencies (packages, Home Manager, etc.). |
| `make clean` | Cleans up old package versions to free up disk space. |

The general workflow is:
1.  Make a change to a `.nix` file.
2.  Run `make personal` or `make work` to apply it.
3.  `git commit` and `git push` to save your changes.

---

## 🔑 Secret Management (SOPS)

To add or modify secrets (like API keys):

1.  Run the command:
    ```bash
    make secrets
    ```
2.  `sops` will decrypt `secrets.yaml` and open it in your default editor.
3.  Make your changes, save, and close the editor. `sops` will **automatically re-encrypt the file** upon saving.
4.  Commit the updated (and still encrypted) `secrets.yaml` file.
5.  Run `make personal` or `make work` to load the new environment variables into your system.

---

### A Note on Home Manager Installation

You might notice that there is no separate step to "install Home Manager". This is by design. Because we are using Nix Flakes, Home Manager is defined as a direct dependency in our `flake.nix` file. The `make work` command (which runs `home-manager switch --flake ...`) takes care of fetching and running the correct version of Home Manager automatically. This is one of the great advantages of using Flakes, as it makes the entire setup more self-contained and reproducible.
