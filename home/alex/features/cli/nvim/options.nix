{
  programs.nixvim.opts = {
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
}