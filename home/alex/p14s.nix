# ThinkPad P14s (NixOS, COSMIC)
{
  imports = [
    ./global
    ./features/copilot
    ./features/desktop/common
    ./features/dev
    ./features/hardware
  ];

  # Same YubiKey 5C Nano as pop-os.nix; it moves to whichever laptop is in use.
  # Identity stub, not a secret: it only tells age-plugin-yubikey which key/slot to ask (touch to decrypt).
  xdg.configFile."sops/age/keys.txt".text = ''
    AGE-PLUGIN-YUBIKEY-1MDEW2QYZCDGK6ACHCEWNX
  '';

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
