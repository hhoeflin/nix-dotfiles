{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git # config is customized in other files
    exa
    fzf
    bat
    ripgrep
    htop
    tmux
    glow
    lazygit

    # python tools
    conda
    micromamba
    python3
    poetry
    mypy
    black
    python39Packages.isort

    # neovim
    tree-sitter
    nodePackages.pyright
    luaPackages.lua-lsp
  ];

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