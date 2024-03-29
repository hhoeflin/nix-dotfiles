{
  description = "Home Manager NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/release-22.05";
    nixpkgs-patched.url = "github:hhoeflin/nixpkgs/release-22.05-patched";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    home-manager-patched.url = "github:nix-community/home-manager/release-22.05";
    home-manager-patched.inputs.nixpkgs.follows = "nixpkgs-patched";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, nixpkgs-patched, home-manager-patched, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = {allowUnfree = true; };
      };
      pkgs-patched = import nixpkgs-patched {
        inherit system;
        config = {allowUnfree = true; };
      };
    in {
      homeConfigurations = {
        hhoeflin = inputs.home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          # Home Manager needs a bit of information about you and the
          # paths it should manage.
          username = "hhoeflin";
          homeDirectory = "/home/hhoeflin";
          # This value determines the Home Manager release that your
          # configuration is compatible with. This helps avoid breakage
          # when a new Home Manager release introduces backwards
          # incompatible changes.
          # You can update Home Manager without changing this value. See
          # the Home Manager release notes for a list of state version
          # changes in each release.
          stateVersion = "21.11";

          configuration = { config, pkgs, ... }:
            {
              nixpkgs.overlays = [ ]; #overlay-unstable ];
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };

              imports = [
                ./base/home.nix ./hhoeflin/home.nix
              ];

            };
        };
        hoeflho1 = inputs.home-manager-patched.lib.homeManagerConfiguration {
          inherit system;
          pkgs = pkgs-patched;
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
          stateVersion = "21.11";

          configuration = { config, pkgs, ... }:
            let
              overlay-brotli = self: super: {
                python39 = super.python39.override {
                  packageOverrides = python-self: python-super: {
                    brotli = python-super.brotli.overrideAttrs (oldAttrs: rec {
                      src = pkgs.fetchFromGitHub {
                        owner = "google";
                        repo = oldAttrs.pname;
                        rev = "v${oldAttrs.version}";
                        sha256 = "0idl29gghsbi1gikp86j423hdq30jcwglwi9mzvwg25db4rlwy02";
                        # for some reason, the test data isn't captured in releases, force a git checkout
                        deepClone = true;
                      };
                    });
                  };
                };
              };
            in
            {
              nixpkgs.overlays = [ overlay-brotli];
              nixpkgs.config = {
                allowUnfree = true;
                allowBroken = true;
              };

              imports = [
                ./base/home.nix ./hoeflho1/home.nix
              ];

            };
        };
      };
      hhoeflin = self.homeConfigurations.hhoeflin.activationPackage;
      hoeflho1 = self.homeConfigurations.hoeflho1.activationPackage;
      defaultPackage.x86_64-linux = self.hhoeflin;
    };
}
