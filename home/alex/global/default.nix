{ config, lib, ... }:
{
  imports = [ ../features/cli ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      settings.user = {
        name = "Alex Waibel";
        email = "alexwaibel@users.noreply.github.com";
      };
    };
  };

  home = {
    username = lib.mkDefault "alex";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };
}
