{
  description = "Home Manager NixOS configuration";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs/release-21.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    #home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, home-manager, ... }:
    {
      homeConfigurations = {
        hhoeflin = inputs.home-manager.lib.homeManagerConfiguration rec {
          system = "x86_64-linux";
          # Home Manager needs a bit of information about you and the
          # paths it should manage.
          username = "hhoeflin";
          homeDirectory = "/home/" + username;
          # This value determines the Home Manager release that your
          # configuration is compatible with. This helps avoid breakage
          # when a new Home Manager release introduces backwards
          # incompatible changes.
          # You can update Home Manager without changing this value. See
          # the Home Manager release notes for a list of state version
          # changes in each release.
          stateVersion = "21.11";

          configuration = { config, pkgs, username, ... }:
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
                ./base/home.nix ./hhoeflin/home.nix
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
          stateVersion = "21.11";

          configuration = { config, pkgs, ... }:
            let
              overlay-unstable = final: prev: {
                unstable = inputs.nixpkgs-unstable.legacyPackages.x86_64-linux;
              };
              overlay-nix = final: prev:
	      	let prefix = "/home/hoeflho1/nix";
		in
	        {
                  nix_2_3 = (prev.nix_2_3.override {
                    storeDir = "${prefix}/store";
                    stateDir = "${prefix}/var";
                    confDir = "${prefix}/etc";
		  }).overrideAttrs (oldAttrs: rec {
    	            patches = (oldAttrs.patches or []) ++ [./hoeflho1/patches/nix_patch_2_3.patch];
                  });
                  nix = (prev.nix.override {
                    storeDir = "${prefix}/store";
                    stateDir = "${prefix}/var";
                    confDir = "${prefix}/etc";
		  }).overrideAttrs (oldAttrs: rec {
    	            patches = (oldAttrs.patches or []) ++ [./hoeflho1/patches/nix_patch_2_5.patch];
                  });
              };
              overlay-go = final: prev: {
                  go_1_16 = prev.go_1_16.overrideAttrs (oldAttrs: rec {
    	          patches = (oldAttrs.patches or []) ++ [./hoeflho1/patches/skip-chown-tests-1.16.patch];
                });
              };
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
              nixpkgs.overlays = [ overlay-unstable overlay-nix overlay-go overlay-brotli];
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
