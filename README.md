# nix-config
My personal nix config using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://nix-community.github.io/home-manager/). Works with both NixOS and standalone Nix.

# Setup
## Prerequisites
Install Nix, either standalone or with NixOS. For MacOS see the recommendations from [nix-darwin](https://github.com/LnL7/nix-darwin).

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

## MacOS
1. `cd ~/.config`
2. Clone the repo
3. `cd nix-config`
2. `nix run nix-darwin -- switch --flake .`
3. Now you can use `darwin-rebuild switch --flake .`

### Standalone
1. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
2. `nix-shell`
3. `home-manager --flake . switch`

# Usage
## Making system changes
1. Modify the `~/.config/nix-config` config files
2. Commit and push the changes with git
3. Run `sudo nixos-rebuild switch` to apply the changes

## Updating
To update the entire system:
1. Update the flake.lock file with `nix flake update`
2. Apply the changes with `sudo nixos-rebuild switch`
> [!TIP]
> You can update flake.lock and apply the changes in one command with `sudo nixos-rebuild switch --recreate-lock-file`

To update an individual input, such as home-manager:
1. `nix flake update home-manager`
2. `sudo nixos-rebuild switch`

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
