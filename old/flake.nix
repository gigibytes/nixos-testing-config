{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-23.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations = { 
      nixos-testing = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
          ./configuration.nix

	  # Home Manager Module
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;

	    home-manager.users.gigi = import ./flakes/home.nix;

	  }
        ];
      };
    };
  };
}
