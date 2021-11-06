{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "hhoeflin";
  home.homeDirectory = "/home/hhoeflin";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    exa
    fzf
    bat
    ripgrep
    git
    htop
    tmux

    # python tools
    conda
    micromamba
    python3
    mypy
    black
    python39Packages.isort

    # neovim
    tree-sitter
    nodePackages.pyright
    luaPackages.lua-lsp

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
    };
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      ls = "exa -F";
      ll = "exa -lahF";
      lt = "exa -lahF --tree";
    };
    bashrcExtra = ''
      export PATH=$HOME/.nix-profile/bin:$PATH
    '';
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # tmux
  xdg.configFile."tmux/tmux.conf".source = tmux/tmux.conf;
  xdg.configFile."tmux/tmuxline.conf".source = tmux/tmuxline.conf;

  # neovim
  programs.neovim = import nvim/neovim.nix {pkgs=pkgs;};

  xdg.configFile."nvim/lua" = {
    source = nvim/lua;
    recursive = true;
  };
}
