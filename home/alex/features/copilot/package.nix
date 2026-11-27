# Copilot CLI's self-contained (SEA) binary. Unlike nixpkgs' github-copilot-cli (the JS package, which can't
# self-update), this binary downloads updates into ~/.cache/copilot/pkg and runs the newest one from there,
# so the version pinned here is only the bootstrap. It also tries to replace itself, which fails in the
# read-only store (`copilot update` prints an EROFS error) after the update has already been installed.
# Not patched: it runs natively on other distros and via nix-ld on NixOS.
{ stdenvNoCC, fetchurl }:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "github-copilot-cli";
  version = "1.0.116";

  src = fetchurl {
    url = "https://github.com/github/copilot-cli/releases/download/v${finalAttrs.version}/copilot-linux-x64.tar.gz";
    hash = "sha256-/+qDOYCpdnoYr/f9hFkIWgRCZsJspqntr+Wc3P9xjHk=";
  };
  sourceRoot = ".";

  # Patching or stripping would corrupt the embedded application blob
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 copilot "$out/bin/copilot"
    runHook postInstall
  '';

  meta = {
    description = "GitHub Copilot CLI (self-updating binary)";
    homepage = "https://github.com/github/copilot-cli";
    mainProgram = "copilot";
    platforms = [ "x86_64-linux" ];
  };
})
