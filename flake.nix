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
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
      treefmtFor = lib.genAttrs (import systems) (
        system:
        treefmt-nix.lib.evalModule pkgsFor.${system} {
          projectRootFile = "flake.nix";
          programs.nixfmt.enable = true;
        }
      );
    in
    {
      inherit lib;

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
        # Devbox VM
        devbox = lib.nixosSystem {
          modules = [ ./hosts/devbox ];
          specialArgs = { inherit inputs outputs; };
        };

        # Media center mini PC
        media-center = lib.nixosSystem {
          modules = [ ./hosts/media-center ];
          specialArgs = { inherit inputs outputs; };
        };

        # Desktop WSL
        desktop-wsl = lib.nixosSystem {
          modules = [ ./hosts/desktop-wsl ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Standalone home-manager for non-NixOS machines.
      # NixOS hosts get home-manager through hosts/common/users/alex instead.
      homeConfigurations = {
        # fedora - home-manager standalone
        "alex@fedora" = lib.homeManagerConfiguration {
          modules = [
            ./home/alex/fedora.nix
            ./home/alex/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };

        # Pop!_OS (COSMIC) - home-manager standalone
        "alex@pop-os" = lib.homeManagerConfiguration {
          modules = [
            ./home/alex/pop-os.nix
            ./home/alex/nixpkgs.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
