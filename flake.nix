{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable"; # Becomes a pain every 6 months
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    # kmonad = {
    #   url = "github:kmonad/kmonad?dir=nix";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      nemi = lib.nixosSystem rec {
        inherit system;
        specialArgs = { inherit hyprland; };
        modules = [
          ./nixos/configuration.nix # The ones in /etc/nixos don't matter much anymore.
          ./nixos/hardware-configuration.nix
          hyprland.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nemi = import ./home/home.nix;
            home-manager.extraSpecialArgs = specialArgs;
            home-manager.backupFileExtension = "backup"; # To prevent collisions. I don't know how to delete the backup shit though.
          }
        ];
      };
    };
  };
	#    homeConfigurations = {
	#      "nemi" = home-manager.lib.homeManagerConfiguration {
	#        modules = [
	#   ./home.nix
	# ];
	#      };
	#    };
	#  };
	#
	#  {
	#
	#    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
	#
	#    packages.x86_64-linux.default = self.packages.x86_64-linux.hello;
	#
	#  };
}
