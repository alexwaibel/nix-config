{
  pkgs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      # Set <space> as leader key
      mapleader = " ";
      maplocalleader = " ";

      # TODO: Invest in setting up a nerd font for nix
      have_nerd_font = false;
    };

    opts = {
      # Make line numbers default
      number = true;

      # Enable mouse mode, for resizing splits etc.
      mouse = "a";

      # Don't show the mode, it's already in the status line
      showmode = false;

      # Sync clipboard between OS and Neovim
      clipboard = "unnamedplus";

      # Enable break indent
      breakindent = true;

      # Save undo history
      undofile = true;

      # Case-insensitive searching UNLESS \C or one or more capital letters in the search term
      ignorecase = true;
      smartcase = true;

      # Keep signcolumn on by default
      signcolumn = "yes";

      # Decrease update time
      updatetime = 250;

      # Decrease mapped sequence wait time
      # Displays which-key popup sooner
      timeoutlen = 300;

      # Configure how new splits should be opened
      splitright = true;
      splitbelow = true;

      # Sets how Neovim will display certain whitespace characters in the editor
      # See `:help 'list'` and `:help 'listchars'`
      list = true;
      listchars = {
        tab = "» ";
        trail = "·";
        nbsp = "␣";
      };

      # Preview substitutions live as you type
      inccommand = "split";

      # Show which line your cursor is on
      cursorline = true;

      # Minimal number of screen lines to keep above and below the cursor
      scrolloff = 10;

      # Set highlight on search
      hlsearch = true;
    };

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
        action = vim.diagnostic.goto_prev;
      }
      {
        mode = "n";
        key = "]d";
        options.desc = "Go to next [D]iagnostic message";
        action = vim.diagnostic.goto_next;
      }
      {
        mode = "n";
        key = "<leader>e";
        options.desc = "Show diagnostic [E]rror messages";
        action = vim.diagnostic.open_float;
      }
      {
        mode = "n";
        key = "<leader>q";
        options.desc = "Open diagnostic [Q]uickfix list";
        action = vim.diagnostic.setloclist;
      }
      {
        mode = "n";
        key = "<leader>q";
        options.desc = "Open diagnostic [Q]uickfix list";
        action = vim.diagnostic.setloclist;
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

    extraConfigLua = ''
      -- Highlight when yanking (copying) text
      vim.api.nvim_create_autocmd('TextYankPost', {
        desc = 'Highlight when yanking (copying) text',
        group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
        callback = function()
          vim.highlight.on_yank()
        end,
      })
    '';
  };
}