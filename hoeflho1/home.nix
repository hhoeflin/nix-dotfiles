{ config, pkgs, ... }:

{

  programs.git = {
    enable = true;
    userName = "Holger Hoefling";
    userEmail = "holger.hoefling@novartis.com";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "master";
    };
  };

  # load the nix-vars to configure correctly
  home.file."profile.d/nix_vars.sh".source = profile/nix_vars.sh;

}
