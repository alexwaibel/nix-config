{ config, ... }:
{
  wsl = {
    enable = true;
    defaultUser = builtins.head (builtins.attrNames config.users.users);
    startMenuLaunchers = true;
  };
}
