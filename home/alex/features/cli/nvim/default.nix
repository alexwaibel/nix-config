{
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    
    ./plugins

    ./keymaps.nix
    ./options.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes.tokyonight.enable = true;

    globals = {
      # Set <space> as leader key
      mapleader = " ";
      maplocalleader = " ";

      # TODO: Invest in setting up a nerd font for nix
      have_nerd_font = false;
    };
  };
}