{ inputs, ... }:
{
  imports = [
    inputs.nixos-wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    # TODO: fix hardcoded username
    defaultUser = "alex";
    startMenuLaunchers = true;
  };

  programs.dconf.enable = true;
}
