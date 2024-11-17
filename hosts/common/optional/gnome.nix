{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      desktopManager.gnome = {
        enable = true;
      };
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    gnome.gnome-remote-desktop.enable = true;
  };
  # Fix broken stuff
  environment.systemPackages = with pkgs; [
    gnome3.gnome-session
  ];
  services.xrdp.defaultWindowManager = "${pkgs.gnome3.gnome-session}/bin/gnome-session";
}