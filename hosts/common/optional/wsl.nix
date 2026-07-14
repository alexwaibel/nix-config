{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-wsl.nixosModules.wsl ];

  wsl = {
    enable = true;
    # TODO: fix hardcoded username
    defaultUser = "alex";
    startMenuLaunchers = true;
  };

  environment.systemPackages = with pkgs; [ pkgs.wget ];
  programs.nix-ld.enable = true;

  programs.dconf.enable = true;
}
