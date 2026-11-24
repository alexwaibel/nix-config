{
  imports = [
    ./cmp.nix
    ./conform.nix
    ./copilot.nix
    ./gitsigns.nix
    ./lsp.nix
    ./mini.nix
    ./neo-tree.nix
    ./nvim-autopairs.nix
    ./telescope.nix
    ./treesitter.nix
    ./which-key.nix
  ];

  programs.nixvim.plugins = {
    # Detect tabstop and shiftwidth automatically
    sleuth.enable = true;
    comment.enable = true;
    web-devicons.enable = true;
    todo-comments = {
      enable = true;
      settings.signs = false;
    };
  };
}
