{ pkgs, ... }:
{
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "us";
        variant = "";
      };
    };
    desktopManager.gnome.enable = true;
    displayManager.gdm = {
      enable = true;
      autoSuspend = false;
    };
    gnome.gnome-remote-desktop.enable = true;
  };
  # Fix broken stuff
  environment.systemPackages = with pkgs; [ gnome-session ];
  services.xrdp.defaultWindowManager = "${pkgs.gnome-session}/bin/gnome-session";
}
