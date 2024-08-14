# nixos
My personal nixos config using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://nix-community.github.io/home-manager/)

# Setup
1. `cd ~/.config`
2. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
3. `sudo ln -s ~/.config/nixos /etc/nixos`
4. `sudo nixos-rebuild switch` (or `sudo nixos-install` if this is a fresh install)
