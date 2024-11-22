# This file (and the global directory) holds config used on all hosts
{
  inputs,
  outputs,
  ...
}: {
  imports =
    [
      (if config.darwin then
        inputs.home-manager.darwinModules.home-manager
      else
        inputs.home-manager.nixosModules.home-manager
      )
      ./fish.nix
      ./nix.nix
    ];

  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };
}