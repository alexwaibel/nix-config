{
  # All grammars are installed by Nix, so there is no ensure_installed or :TSUpdate
  programs.nixvim.plugins.treesitter = {
    enable = true;
    settings = {
      highlight = {
        enable = true;
        additional_vim_regex_highlighting = [ "ruby" ];
      };
      indent = {
        enable = true;
        disable = [ "ruby" ];
      };
    };
  };
}
