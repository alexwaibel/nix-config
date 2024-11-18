{ config, lib, ... }:
{
  imports = [
    ../features/cli
  ];

  programs = {
    home-manager.enable = true;
    git = {
      enable = true;
      userName = "Alex Waibel";
      userEmail = "alexwaibel@users.noreply.github.com";
    };
  };

  home = {
    username = lib.mkDefault "alex";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    # This value determines the home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = lib.mkDefault "24.05";
  };
}
