{
  programs.nixvim = {
    plugins.mini = {
      enable = true;
      modules = {
        # Better around/inside textobjects
        ai.n_lines = 500;
        # Add/delete/replace surroundings (brackets, quotes, etc.)
        surround = { };
        statusline.use_icons = true;
      };
    };

    # Show LINE:COLUMN in the statusline
    extraConfigLua = ''
      require('mini.statusline').section_location = function()
        return '%2l:%-2v'
      end
    '';
  };
}
