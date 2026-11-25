# sops-nix secrets, decrypted with YubiKey-held age identities (age-plugin-yubikey).
# ~/.config/sops/age/keys.txt only holds identity stubs, which reference the keys but can't decrypt alone.
{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];

  home.packages = with pkgs; [
    sops
    age-plugin-yubikey
  ];

  sops.age = {
    keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
    plugins = [ pkgs.age-plugin-yubikey ];
  };
}
