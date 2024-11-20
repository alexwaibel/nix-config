{
  description = "NixOS configuration";

  inputs = {
    # NixOS official package source, using the nixos-24.05 branch here
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    systems,
    ...
  } @ inputs: let
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
  in {
    inherit lib;
    
    nixosConfigurations = {
      # Devbox VM
      devbox = lib.nixosSystem {
        modules = [./hosts/devbox];
        specialArgs = {
          inherit inputs outputs;
        };
      };
      
      # Media center mini PC
      media-center = lib.nixosSystem {
        modules = [./hosts/media-center];
        specialArgs = {
          inherit inputs outputs;
        };
      };

      # Desktop WSL
      desktop-wsl = lib.nixosSystem {
        modules = [./hosts/desktop-wsl];
        specialArgs = {
          inherit inputs outputs;
        };
      };
    };

    homeConfigurations = {
      # devbox
      "alex@devbox" = lib.homeManagerConfiguration {
        modules = [./home/alex/devbox.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # media-center
      "alex@media-center" = lib.homeManagerConfiguration {
        modules = [./home/alex/media-center.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # desktop wsl
      "alex@desktop-wsl" = lib.homeManagerConfiguration {
        modules = [./home/alex/desktop-wsl.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };

      # fedora - home-manager standalone
      "alex@fedora" = lib.homeManagerConfiguration {
        modules = [./home/alex/fedora.nix ./home/alex/nixpkgs.nix];
        pkgs = pkgsFor.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
      };
    };
  };
}

