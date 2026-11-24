{ inputs, ... }:
{
  imports = [
    inputs.nixvim.homeModules.nixvim

    ./plugins

    ./keymaps.nix
    ./options.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Use the flake's single nixpkgs (inputs.nixvim follows it).
    nixpkgs.source = inputs.nixpkgs;

    colorschemes.tokyonight = {
      enable = true;
      settings = {
        style = "night";
        styles.comments.italic = false;
      };
    };

    globals = {
      # Set <space> as leader key
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };
  };
}
