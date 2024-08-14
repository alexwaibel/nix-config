# nixos
My personal nixos config using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://nix-community.github.io/home-manager/)

# Setup (installing fresh nixos)
1. `cd ~/.config`
2. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
3. `sudo cp -r ~/.config/nixos/* /mnt/etc/nixos/`
4. `sudo nixos-install`
5. `reboot`
6. Use the admin account or ssh to log in
   - You can set the user password afterwards with `passwd`

# Setup (existing nixos machine)
1. `cd ~/.config`
2. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
3. `sudo ln -s ~/.config/nixos /etc/nixos`
4. `sudo nixos-rebuild switch`
