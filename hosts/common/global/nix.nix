{ inputs, ... }:
{
  imports = [ (inputs.self + "/shared/nix.nix") ];

  nix.optimise.automatic = true;
}
