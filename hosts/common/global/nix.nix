{
  darwin ? false,
  ...
}: {
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      ${if !darwin then "dates" else null} = "weekly";
      options = "--delete-older-than 2w";
    };
  };
}