{
  keymaps = [
    # Clear search highlight by pressing <Esc> in normal mode
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }

    # Diagnostic keymaps
    {
      mode = "n";
      key = "[d";
      options.desc = "Go to previous [D]iagnostic message";
      action.__raw = "vim.diagnostic.goto_prev";
    }
    {
      mode = "n";
      key = "]d";
      options.desc = "Go to next [D]iagnostic message";
      action.__raw = "vim.diagnostic.goto_next";
    }
    {
      mode = "n";
      key = "<leader>e";
      options.desc = "Show diagnostic [E]rror messages";
      action.__raw = "vim.diagnostic.open_float";
    }
    {
      mode = "n";
      key = "<leader>q";
      options.desc = "Open diagnostic [Q]uickfix list";
      action.__raw = "vim.diagnostic.setloclist";
    }
    {
      mode = "n";
      key = "<leader>q";
      options.desc = "Open diagnostic [Q]uickfix list";
      action.__raw = "vim.diagnostic.setloclist";
    }

    # Exit terminal mode in builtin terminal with double escape. Easier to discover than default <C-\><C-n>
    # Won't work in all terminal emulators/tmux/etc
    {
      mode = "t";
      key = "<Esc><Esc>";
      options.desc = "Exit terminal mode";
      action = "<C-\\><C-n>";
    }
    # Make split navigation Easier
    {
      mode = "n";
      key = "<C-h>";
      options.desc = "Move focus to the left window";
      action = "<C-w><C-h>";
    }
    {
      mode = "n";
      key = "<C-l>";
      options.desc = "Move focus to the right window";
      action = "<C-w><C-l>";
    }
    {
      mode = "n";
      key = "<C-j>";
      options.desc = "Move focus to the lower window";
      action = "<C-w><C-j>";
    }
    {
      mode = "n";
      key = "<C-k>";
      options.desc = "Move focus to the upper window";
      action = "<C-w><C-k>";
    }
  ];

  autoGroups = {
    kickstart-highlight-yank = {
      clear = true;
    };
  };

  autoCmd = [
    {
      event = "TextYankPost";
      desc = "Highlight when yanking (copying) text";
      group = "kickstart-highlight-yank";
      callback.__raw = ''
        function()
          vim.highlight.on_yank()
        end
      '';
    }
  ];
}