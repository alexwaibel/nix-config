{
  pkgs,
  ...
}: {
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    optimise.automatic = true;
    gc = {
      automatic = true;
      ${if !pkgs.stdenv.isDarwin then "dates" else null} = "weekly";
      options = "--delete-older-than 2w";
    };
  };
}
