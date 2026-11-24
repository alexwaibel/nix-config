{ lib, pkgs, ... }:
{
  programs.nixvim = {
    # nixos-26.05 pins copilot.lua v2.0.4, whose upstream tag was rewritten (hash mismatch).
    # Matches nixpkgs master; drop once the release branch catches up.
    nixpkgs.overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins.extend (
          _: vprev: {
            copilot-lua = vprev.copilot-lua.overrideAttrs {
              version = "3.2.5";
              name = "vimplugin-copilot.lua-3.2.5";
              src = final.fetchFromGitHub {
                owner = "zbirenbaum";
                repo = "copilot.lua";
                tag = "v3.2.5";
                hash = "sha256-B4CI5Ix18w+dn1JPtUIU/2C7sQbBa5yAGpzNMhvGUtc=";
              };
            };
          }
        );
      })
    ];

    plugins = {
      # Suggestions only show up through cmp
      copilot-lua = {
        enable = true;
        settings = {
          suggestion.enabled = false;
          panel.enabled = false;
          # Use the Nix-packaged server instead of a runtime download
          server = {
            type = "binary";
            custom_server_filepath = lib.getExe pkgs.copilot-language-server;
          };
        };
      };
      copilot-cmp.enable = true;
    };
  };
}
