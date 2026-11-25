# Pop!_OS (COSMIC) - home-manager standalone
{
  imports = [
    ./global
    ./features/copilot
    ./features/dev
  ];

  targets.genericLinux.enable = true;

  # YubiKey 5C Nano 15037147 (lives in this laptop), "nix-config" slot. Identity stub, not a secret:
  # it only tells age-plugin-yubikey which key/slot to ask (touch to decrypt).
  xdg.configFile."sops/age/keys.txt".text = ''
    AGE-PLUGIN-YUBIKEY-1MDEW2QYZCDGK6ACHCEWNX
  '';
}
