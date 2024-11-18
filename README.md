# nixos
My personal nixos config using [flakes](https://nixos.wiki/wiki/Flakes) and [home-manager](https://nix-community.github.io/home-manager/)

# Setup 
## If installing fresh nixos
1. `cd ~/.config`
2. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
3. `cd nixos`
4. `sudo cp -r ~/.config/nixos/* /mnt/etc/nixos/`
5. `sudo nixos-install --flake .#<hostname>`. During install you'll be prompted to set an admin password
6. `reboot`
7. Use the admin to log in, either directly or by SSH into the `alex` user and running `su`
8. Set `alex` user password with `password alex`

## If configuring an existing nixos machine
1. `cd ~/.config`
2. Clone the repo. You can use `nix-shell -p git` to launch a shell with `git` installed
3. `cd nixos`
4. `sudo ln -s ~/.config/nixos /etc/nixos`
5. `sudo nixos-rebuild switch --flake .#<hostname>`

# Usage
## Making system changes
1. Modify the `~/.config/nixos` config files
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
