# Copilot CLI: MCP servers with credentials from sops, plus managed settings.
{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (config.sops) placeholder;

  # Deep-merged into ~/.copilot/settings.json at activation; Copilot owns (and writes) everything else.
  managedSettings = {
    sandbox.userPolicy.filesystem.deniedPaths = [
      # Keep sandboxed commands away from rendered secrets (Copilot itself reads its config outside the sandbox)
      "~/.copilot/mcp-config.json"
      "~/.config/sops-nix"
      "\${XDG_RUNTIME_DIR}/secrets.d"
    ];
  };
in
{
  imports = [ ../secrets ];

  programs.github-copilot-cli = {
    enable = true;
    # Self-updating install outside Nix; nixpkgs pins an old release with --no-auto-update
    package = null;
  };

  sops = {
    defaultSopsFile = ../../../../secrets/copilot.sops.yaml;
    secrets = {
      home_assistant_url = { };
      # Long-lived access token: OAuth refresh failures count as failed logins and can get the IP banned
      home_assistant_token = { };
    };
    # Rendered outside the Nix store at activation. `copilot mcp add` can't edit it; declare servers here.
    templates."copilot-mcp-config.json" = {
      path = "${config.home.homeDirectory}/.copilot/mcp-config.json";
      content = builtins.toJSON {
        mcpServers.home-assistant = {
          type = "http";
          url = placeholder.home_assistant_url;
          headers.Authorization = "Bearer ${placeholder.home_assistant_token}";
        };
      };
    };
  };

  home.activation.copilotSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    settings=${config.home.homeDirectory}/.copilot/settings.json
    run mkdir -p "$(dirname "$settings")"
    [ -s "$settings" ] || run sh -c "echo '{}' > '$settings'"
    merged=$(${lib.getExe pkgs.jq} --argjson m ${lib.escapeShellArg (builtins.toJSON managedSettings)} '. * $m' "$settings")
    run sh -c 'printf "%s\n" "$1" > "$2"' _ "$merged" "$settings"
  '';
}
