{
  description = "NixOS and home-manager configurations";

  inputs = {
    # NixOS official package source, using the nixos-26.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/nixos-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems = {
      url = "github:nix-systems/default";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      systems,
      treefmt-nix,
      ...
    }@inputs:
    let
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config = import ./shared/nixpkgs-config.nix;
        }
      );
      mkHost =
        name:
        lib.nixosSystem {
          modules = [ ./hosts/${name} ];
          specialArgs = { inherit inputs; };
        };
      # Standalone home-manager for non-NixOS machines.
      # NixOS hosts get home-manager through hosts/common/users/alex instead.
      mkHome =
        name:
        lib.homeManagerConfiguration {
          modules = [
            ./home/alex/${name}.nix
            ./home/alex/standalone.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs; };
        };
      treefmtFor = lib.genAttrs (import systems) (
        system:
        treefmt-nix.lib.evalModule pkgsFor.${system} {
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
        }
      );
    in
    {
      formatter = forEachSystem (
        pkgs: treefmtFor.${pkgs.stdenv.hostPlatform.system}.config.build.wrapper
      );

      checks = forEachSystem (pkgs: {
        formatting = treefmtFor.${pkgs.stdenv.hostPlatform.system}.config.build.check self;
      });

      devShells = forEachSystem (pkgs: {
        # Bootstrap tools for applying this config: `nix develop`
        default = pkgs.mkShell {
          NIX_CONFIG = "extra-experimental-features = nix-command flakes";
          packages = [
            pkgs.git
            pkgs.nix
            home-manager.packages.${pkgs.stdenv.hostPlatform.system}.home-manager
          ];
        };
      });

      nixosConfigurations = {
        # Desktop WSL
        desktop-wsl = mkHost "desktop-wsl";
      };

      homeConfigurations = {
        # Pop!_OS (COSMIC)
        "alex@pop-os" = mkHome "pop-os";
      };
    };
}
