{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;


 #
  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    exa
    fzf
    bat
    ripgrep
    git
    htop
    tmux
    glow
    lazygit

    # learning
    exercism

    # python tools
    conda
    micromamba
    python3
    mypy
    black
    python39Packages.isort

    # haskell
    ghc
    stack
    hlint
    ormolu

    # neovim
    tree-sitter
    nodePackages.pyright
    luaPackages.lua-lsp
    haskell-language-server

    # for spotify
    spotifyd
    spotify-tui
    pass
    gnupg1
  ];

  services.spotifyd = {
    enable = true;
  };
  xdg.configFile."spotifyd" = {
    source = ./spotifyd;
    recursive = true;
  };

  programs.git = {
    enable = true;
    userName = "Holger Hoefling";
    userEmail = "hhoeflin@gmail.com";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "master";
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "exa -F";
      ll = "exa -lahF";
      lt = "exa -lahF --tree";
      lg = "lazygit";
    };
    bashrcExtra = ''
      export PATH=$HOME/.nix-profile/bin:$PATH
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };
  xdg.configFile."starship.toml".source = starship/starship.toml;

  # tmux
  xdg.configFile."tmux/tmux.conf".source = tmux/tmux.conf;
  xdg.configFile."tmux/tmuxline.conf".source = tmux/tmuxline.conf;

  # glow
  xdg.configFile."glow/glow.yml".source = glow/glow.yml;

  # lazygit
  xdg.configFile."lazygit/config.yml".source = lazygit/config.yml;

  # neovim
  programs.neovim = import nvim/neovim.nix {pkgs=pkgs;};

  xdg.configFile."nvim/lua" = {
    source = nvim/lua;
    recursive = true;
  };
}
