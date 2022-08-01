{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # learning
    exercism

    # haskell
    ghc
    stack
    hlint
    ormolu
    haskell-language-server  # for neovim

    # rust
    rustc
    clippy
    cargo
    rustfmt
    rust-analyzer


    # for spotify
    spotifyd
    spotify-tui
    pass
    gnupg1
  ];

  programs.git = {
    enable = true;
    userName = "Holger Hoefling";
    userEmail = "hhoeflin@gmail.com";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "master";
    };
  };


  # kitty
  xdg.configFile."kitty" = {
    source = ./kitty;
    recursive = true;
  };

  services.spotifyd = {
    enable = true;
  };
  xdg.configFile."spotifyd" = {
    source = ./spotifyd;
    recursive = true;
  };
}
