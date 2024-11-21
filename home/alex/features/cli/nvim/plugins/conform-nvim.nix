{
  programs.nixvim.plugins = {
    # Autoformat
    conform-nvim = {
			enable = true;
			settings = {
				notify_on_error = false;
				formatters_by_ft = {
					javascript =  [ "prettierd" ];
					typescript =  [ "prettierd" ];
					yaml =  [ "prettierd" ];
					json = [ "jq" ];
					lua = [ "stylua" ];
					scss = [ "prettierd" ];
					css = [ "prettierd" ];
					python = [ "isort" "black" ];
					rust = [ "rustfmt" ];
					sh = [ "shfmt" ];
				};
				format_on_save = ''
          function(bufnr)
						-- Disable "format_on_save lsp_fallback" for languages that don't
						-- have a well standardized coding style. You can add additional
						-- languages here or re-enable it for the disabled ones.
						local disable_filetypes = { c = true, cpp = true }
						return {
							timeout_ms = 500,
							lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
						}
					end
        '';
			};
    };

		keymaps = [
      {
        key = "<leader>f";
				options.desc = "[F]ormat buffer";
        action.__raw = ''
					function()
						require('conform').format { async = true, lsp_fallback = true }
					end
				'';
      }
		];
  };
}