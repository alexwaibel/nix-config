{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  wsl = {
    enable = true;
    startMenuLaunchers = true;
  };

  environment.systemPackages = [ pkgs.wget ];
  programs.nix-ld.enable = true;

  programs.dconf.enable = true;
}
