# Tools for poking at physical hardware; for bare-metal machines, not VMs/WSL
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ethtool
    lm_sensors # `sensors`
    pciutils # lspci
    usbutils # lsusb
  ];
}
