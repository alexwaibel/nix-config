{
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;
      settings.filesystem.window.mappings."\\" = "close_window";
    };

    keymaps = [
      {
        mode = "n";
        key = "\\";
        action = "<cmd>Neotree reveal<CR>";
        options.desc = "NeoTree reveal";
      }
    ];
  };
}
