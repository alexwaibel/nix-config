{
  imports = [
    ./global
  ];

  home.homeDirectory = lib.mkForce "/Users/${config.home.username}";
}
