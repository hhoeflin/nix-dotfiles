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

}
