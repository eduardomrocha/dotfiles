# Makefile to manage the Nix environment with Flakes, Home Manager, and SOPS

# --- Configuration Variables ---
USERNAME = eduardo
AGE_KEY_FILE = key.txt
SECRETS_FILE = secrets.yaml

# --- .PHONY Targets ---
# Declare that targets are commands, not files.
.PHONY: help personal work switch update secrets clean

# --- Available Commands ---

## Display this help message with available commands.
help:
	@echo "Nix Environment Management Makefile"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Main Targets:"
	@echo "  \033[36mwork\033[0m            Apply the Work (Impel) profile configuration."
	@echo "  \033[36mpersonal\033[0m        Apply the Personal profile configuration."
	@echo ""
	@echo "Other Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sed -n '/Main Targets/!p' | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}'


# --- Profile Activation Targets ---

## (work) Apply the Work (Impel) profile configuration.
work:
	@$(MAKE) switch PROFILE=work

## (personal) Apply the Personal profile configuration.
personal:
	@$(MAKE) switch PROFILE=personal


# --- Internal and Maintenance Commands ---

## (switch) [INTERNAL] Apply the Home Manager configuration to the current system.
switch:
	@echo "🔒 Applying configuration for profile: \033[33m$(PROFILE)\033[0m"
	SOPS_AGE_KEY_FILE=$(AGE_KEY_FILE) nix run home-manager -- switch --flake .#$(USERNAME)-$(PROFILE)
	@echo "✅ Configuration applied successfully!"

## (update) Update flake dependencies (nixpkgs, home-manager, etc.).
update:
	@echo "🔄 Updating flake dependencies..."
	nix flake update
	@echo "⚠️ Dependencies updated. Run 'make work' or 'make personal' to apply."

## (secrets) Securely edit the secrets file.
secrets:
	@echo "✏️  Opening editor for the secrets file..."
	sops $(SECRETS_FILE)

## (clean) Clean up old Nix generations to free up disk space.
clean:
	@echo "🗑️  Cleaning old Nix generations..."
	nix-collect-garbage -d
	@echo "✅ Cleanup complete."
