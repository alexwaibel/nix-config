{
  programs.nixvim.plugins = {
    # Autocompletion
    cmp = {
      enable = true;
      autoEnableSources = true;
      
      settings = {
        snippet = {
          expand = ''
            function(args)
              require('luasnip').luasnip.lsp_expand(ags.body)
            end
          '';
        };

        completion = {
          completeopt = "menu,menuone,noinsert";
        };

        # See `:help ins-completion` for why these mappings are chosen
        mapping = {
          # Select the [n]ext item
          "<C-n>" = "cmp.mapping.select_next_item()";

          # Select the [p]revious item
          "<C-p>" = "cmp.mapping.select_prev_item()";

          # Scroll the documentation window [b]ack / [f]orward
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";

          # Accept ([y]es) the completion.
          #  This will auto-import if your LSP supports it.
          #  This will expand snippets if the LSP sent a snippet.
          "<C-y>" = "cmp.mapping.confirm({ select = true })";

          # Manually trigger a completion from nvim-cmp.
          #  Generally you don't need this, because nvim-cmp will display
          #  completions whenever it has completion options available.
          "<C-Space>" = "cmp.mapping.complete({})";

          # Think of <C-l> as moving to the right of your snippet expansion.
          #  So if you have a snippet that's like:
          #  function $name($args)
          #    $body
          #  end
          #
          # <C-l> will move you to the right of each of the expansion locations.
          # <C-h> is similar, except moving you backwards.
          "<C-l>" = ''
            cmp.mapping(function()
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' })
          '';
          "<C-h>" = ''
            cmp.mapping(function()
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' })
          '';
        };

        sources = [
          { name = 'copilot' }
          { name = 'nvim_lsp' }
          { name = 'luasnip' }    # snippets
          { name = 'path' }       # file system paths
        ];
      };
    };
  };
}