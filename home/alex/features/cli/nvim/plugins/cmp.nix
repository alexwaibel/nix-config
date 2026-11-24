{
  programs.nixvim.plugins = {
    luasnip.enable = true;

    # Autocompletion
    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';

        completion.completeopt = "menu,menuone,noinsert";

        # See `:help ins-completion` for why these mappings are chosen
        mapping = {
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
          "<C-b>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          # Accept ([y]es) the completion
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          "<C-Space>" = "cmp.mapping.complete({})";

          # Move forward/backward through snippet expansion locations
          "<C-l>" = ''
            cmp.mapping(function()
              local luasnip = require('luasnip')
              if luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              end
            end, { 'i', 's' })
          '';
          "<C-h>" = ''
            cmp.mapping(function()
              local luasnip = require('luasnip')
              if luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              end
            end, { 'i', 's' })
          '';
        };

        sources = [
          { name = "copilot"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          { name = "path"; }
        ];
      };
    };
  };
}
