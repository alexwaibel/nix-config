{ inputs, ... }:
{
  wsl = {
    enable = true;
    # TODO: fix hardcoded username
    defaultUser = "alex";
    startMenuLaunchers = true;
  };
}
