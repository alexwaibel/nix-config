# YubiKey smart card (PIV/CCID) access, needed by age-plugin-yubikey for sops-nix
{
  services.pcscd.enable = true;
}
