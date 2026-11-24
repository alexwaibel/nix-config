# Development tooling for machines I write code on
{ lib, pkgs, ... }:
{
  # Manual tarball install, where present
  home.sessionPath = [ "/usr/local/go/bin" ];

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    # mise installs and updates itself (`mise self-update`) so it keeps pace with the
    # version that writes repo lockfiles; Nix only wires up the shells.
    # Runs last so later PATH edits (e.g. genericLinux's nix.sh) can't shadow mise's tools.
    bash.initExtra = lib.mkAfter ''
      if command -v mise >/dev/null; then
        eval "$(mise activate bash)"
      fi
    '';
    fish.interactiveShellInit = ''
      if command -q mise
          mise activate fish | source
      end
    '';
  };

  home.packages = with pkgs; [
    fd
    moreutils # sponge, ts, vipe, ...
    nixfmt
    opencode
  ];
}
