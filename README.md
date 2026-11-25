# nix-config
My personal nix config using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://nix-community.github.io/home-manager/). Works with both NixOS and standalone Nix.

## 📂 Directories

```sh
📁 nix-config
├── 📁 hosts            # 🖥️ NixOS system config
│   ├── 📁 common
│   │   ├── 📁 global   # every host
│   │   ├── 📁 optional # opt-in per host
│   │   └── 📁 users    # users + home-manager integration
│   └── 📁 <hostname>   # one per NixOS machine
├── 📁 home/alex        # 🏠 home-manager user config
│   ├── 📁 global       # every profile
│   ├── 📁 features     # opt-in per profile
│   ├── 📄 <hostname>.nix
│   └── 📄 standalone.nix # non-NixOS machines only
└── 📁 shared           # 🤝 settings both sides have options for
```

### ⚖️ NixOS vs home-manager

- 🖥️ **`hosts/`**: anything that needs root or affects the whole machine: boot, hardware, system services (sshd, docker, pipewire), users, locale, the nix daemon, desktop sessions.
- 🏠 **`home/`**: your user environment, the same on every machine: shell, CLI tools, editors, git, ssh client, dotfiles, desktop preferences. Rule of thumb: if standalone home-manager can do it, it goes here.

# Setup
## Prerequisites
Install Nix, either standalone or with NixOS.

## Install config
### NixOS
1. `cd ~/.config`
2. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
3. `cd nix-config`
4. `sudo mv /etc/nixos /etc/nixos.bak`
5. `sudo ln -s ~/.config/nix-config /etc/nixos`
6. `sudo nixos-rebuild switch --flake .#<hostname>`

> [!IMPORTANT]
> If you face issues with the switch command, make sure your hardware config is good.
> You can generate the config for your current hardware with `nixos-generate-config` and compare.

> [!CAUTION]
> If using NixOS-WSL follow [these docs](https://nix-community.github.io/NixOS-WSL/how-to/change-username.html)
> instead of running `sudo nixos-rebuild switch`. Otherwise the non-default username will lead to a broken install.

### Standalone (non-NixOS, e.g. Pop!_OS)
1. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
2. `nix --extra-experimental-features 'nix-command flakes' develop`
3. `home-manager switch --flake .#alex@<hostname> -b hm-bak`

After the first switch, `home-manager` is installed and flakes are enabled, so use
`home-manager switch --flake .` (on NixOS hosts home-manager is applied by `nixos-rebuild`).

Fast-moving tools are installed outside Nix and update themselves; Nix only configures them:
- [mise](https://mise.jdx.dev): `curl https://mise.run | sh`
- [Copilot CLI](https://github.com/github/copilot-cli): nixpkgs pins an old release with `--no-auto-update`

# Usage
## Making system changes
1. Modify the `~/.config/nix-config` config files
2. Commit and push the changes with git
3. Run `sudo nixos-rebuild switch` to apply the changes

## Updating
Renovate opens a "flake inputs" PR and a `flake.lock` maintenance PR every Monday.

To manually update the entire system:
1. Update the flake.lock file with `nix flake update`
2. Apply the changes with `sudo nixos-rebuild switch`
> [!TIP]
> You can update flake.lock and apply the changes in one command with `sudo nixos-rebuild switch --recreate-lock-file`

To update an individual input, such as home-manager:
1. `nix flake update home-manager`
2. `sudo nixos-rebuild switch`

## Secrets
Secrets live in `*.sops.yaml` files next to the module that uses them (e.g. `home/alex/features/copilot/secrets.sops.yaml`), encrypted with [sops](https://github.com/getsops/sops) and decrypted at activation by [sops-nix](https://github.com/Mic92/sops-nix) (`home/alex/features/secrets`).
Recipients in `.sops.yaml` are YubiKey-held age identities ([age-plugin-yubikey](https://github.com/str4d/age-plugin-yubikey)), so no private key ever exists on disk:

- The YubiKey that lives in a machine gets a touch-only (`--pin-policy never`) identity so sops-nix can decrypt at login; touch the key when it blinks.
- Spare YubiKeys get PIN + touch identities; they're for editing and recovery.
- `~/.config/sops/age/keys.txt` is managed per profile and only holds identity stubs (they point at a YubiKey slot, they can't decrypt).

Edit a secret (touch the YubiKey; unset `SOPS_CONFIG`/`SOPS_AGE_KEY_FILE` if another repo's mise env sets them):
```bash
sops home/alex/features/copilot/secrets.sops.yaml
```

Add a YubiKey or machine:
```bash
age-plugin-yubikey --generate --pin-policy once --touch-policy cached --name nix-config  # `never` for a key that stays in a machine
age-plugin-yubikey --identity --slot <n>   # stub for that profile's keys.txt
# add the recipient to .sops.yaml, then re-encrypt (needs an existing key):
git ls-files '*.sops.yaml' | xargs -n1 sops updatekeys -y
```
To use a spare YubiKey (no stored stub needed; it's read from the key):
```bash
age-plugin-yubikey --identity --slot 1 > /tmp/spare.txt
SOPS_AGE_KEY_FILE=/tmp/spare.txt sops home/alex/features/copilot/secrets.sops.yaml; rm /tmp/spare.txt
```
YubiKey FIPS models can't be used: age-plugin-yubikey needs a TDES management key, which FIPS approved mode forbids ([#92](https://github.com/str4d/age-plugin-yubikey/issues/92)).

## Debugging
If you encounter an error when applying changes you can get more detailed error messages with:
`sudo nixos-rebuild switch --show-trace --print-build-logs --verbose`
> [!TIP]
> A shorter equivalent is `sudo nixos-rebuild switch --show-trace -L -v`


# Thanks
Thank you to all the wonderful developers of Nix, home-manager, and countless other open source
projects without which this project would never be possible.

A special thanks to Misterio77 for his [Nix Starter Configs](https://github.com/Misterio77/nix-starter-configs) project as well as for making his [personal nix configs](https://github.com/Misterio77/nix-config) available. His config structure was a big source of inspiration for this project.

I'd also like to thank ryan4yin for his [NixOS & Flakes Book](https://github.com/ryan4yin/nixos-and-flakes-book) which was my starting point for this entire nix journey.
