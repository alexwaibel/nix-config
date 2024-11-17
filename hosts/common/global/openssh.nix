{
  outputs,
  lib,
  ...
}: let
  hosts = lib.attrNames outputs.nixosConfigurations;
in {
  services.openssh = {
    enable = true;
    settings = {
      # Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}