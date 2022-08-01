{ config, pkgs, ... }:

{
  # allow unfree packages
  nixpkgs.config = {allowUnfree = true;};
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    # we want nix itself to be installed by home-manager
    nix

    git # config is customized in other files
    exa
    fzf
    bat
    ripgrep
    fd
    htop
    tmux
    glow
    lazygit
    icdiff
    zoxide
    du-dust
    tldr
    broot
    duf
    which

    # task runners
    gnumake
    just
    go-task

    # python tools
    conda
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
      e=''$EDITOR `fzf -m --preview="bat --color always {}"`'';
      dtask = "task -t ~/.config/go-task/Taskfile.yml";
    };
    profileExtra = ''
      . $HOME/.nix-profile/etc/profile.d/nix.sh

      if [ -d $HOME/profile.d ]; then
        for i in $HOME/profile.d/*.sh; do
          if [ -r $i ]; then
            . $i
          fi
        done
        unset i
      fi


    '';
    initExtra = ''
      export PATH=$HOME/.local/bin:$PATH
      eval "$(zoxide init bash)"

      # ensure CTRL-S doesn't block the terminal
      if [[ -t 0 && $- = *i* ]]
      then
        stty -ixon
      fi

      export EDITOR="nvim";
      export PYTHONSTARTUP=~/.config/python/pythonrc.py
    '';
  };

  programs.mcfly = {
    enable = true;
    keyScheme = "vim";
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

  # python startup
  xdg.configFile."python/pythonrc.py".source = python/pythonrc.py;

  # neovim
  programs.neovim = import nvim/neovim.nix {pkgs=pkgs;};
  xdg.configFile."nvim/lua" = {
    source = nvim/lua;
    recursive = true;
  };

  # go-tasks
  xdg.configFile."go-task" = {
    source = ./go-task;
    recursive = true;
  };

}
