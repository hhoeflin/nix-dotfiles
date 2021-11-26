{
  description = "Home Manager NixOS configuration";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/nixos-21.05";
    nixpkgs.url = "github:nixos/nixpkgs/4789953e5c1";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-21.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    {
      homeConfigurations = {
        hhoeflin = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          # Home Manager needs a bit of information about you and the
          # paths it should manage.
          homeDirectory = "/home/hhoeflin";
          username = "hhoeflin";
          # This value determines the Home Manager release that your
          # configuration is compatible with. This helps avoid breakage
          # when a new Home Manager release introduces backwards
          # incompatible changes.
          # You can update Home Manager without changing this value. See
          # the Home Manager release notes for a list of state version
          # changes in each release.
          stateVersion = "21.05";

          configuration = { config, pkgs, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in
            {
              nixpkgs.overlays = [ overlay-unstable ];
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };

              imports = [
                ./base/home.nix ./hhoeflin-only/home.nix
              ];

            };
        };
        hoeflho1 = inputs.home-manager.lib.homeManagerConfiguration {
          system = "x86_64-linux";
          # Home Manager needs a bit of information about you and the
          # paths it should manage.
          homeDirectory = "/home/hoeflho1";
          username = "hoeflho1";
          # This value determines the Home Manager release that your
          # configuration is compatible with. This helps avoid breakage
          # when a new Home Manager release introduces backwards
          # incompatible changes.
          # You can update Home Manager without changing this value. See
          # the Home Manager release notes for a list of state version
          # changes in each release.
          stateVersion = "21.05";

          configuration = { config, pkgs, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
            in
            {
              nixpkgs.overlays = [ overlay-unstable ];
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };

              imports = [
                ./base/home.nix ./hoeflho1-only/home.nix
              ];

            };
        };
      };
      hhoeflin = self.homeConfigurations.hhoeflin.activationPackage;
      hoeflho1 = self.homeConfigurations.hoeflho1.activationPackage;
      defaultPackage.x86_64-linux = self.hhoeflin;
    };
}
