{
  description = "NixOS configuration";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix

      	# Make home-manager a nixos module
      	# so that home-manager config is deployed automatically when executing `nixos-rebuild switch`
      	home-manager.nixosModules.home-manager
      	{
      	  home-manager.useGlobalPkgs = true;
      	  home-manager.useUserPackages = true;
      
      	  home-manager.users.alex = import ./home.nix;
      	}
      ];
    };
  };
}

