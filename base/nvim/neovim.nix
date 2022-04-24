{pkgs}:
{
  enable = true;
  extraConfig = builtins.concatStringsSep "\n" [
    ''
    :lua require('init')
    ''
  ];
  extraPackages = with pkgs; [
    rnix-lsp
  ];
  plugins = let
    alpha = pkgs.vimUtils.buildVimPlugin {
      name = "alpha-nvim";
      src = pkgs.fetchFromGitHub {
        owner = "goolord";
        repo = "alpha-nvim";
        rev = "4781fcfea5ddc1a92d41b32dc325132ed6fce7a8";
        sha256 = "sha256-GA+fIfVlHOllojGyErYGC0+zyYTl9rOxendqOgApJw4=";
      };
    };
    bufstop = pkgs.vimUtils.buildVimPlugin {
      name = "bufstop";
      src = pkgs.fetchFromGitHub {
        owner = "mihaifm";
	repo = "bufstop";
	rev = "51a87fb1fb3031778b465c5c92007ebd1ac677f6";
        sha256 = "1q2z52pkfas4s8lq4bfcpadq5fr18635kv5l8hggr7fzrdccjv45";
      };
    };

    my-catppuccin-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "catppuccin";
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "nvim";
        rev = "8a67df6da476cba68ecf26a519a5279686edbd2e";
        sha256 = "sha256-KSjPg/93YzprFyAFKOcGYZXlm2kjxMIYTZOeuu7OJvE=";
      };
    };

    vim-nightfly = pkgs.vimUtils.buildVimPlugin {
      name = "vim-nightfly-guicolors";
      src = pkgs.fetchFromGitHub {
        owner = "bluz71";
        repo = "vim-nightfly-guicolors";
        rev = "2d8d5194ee45826a2994264e220d53546e608b4c";
        # sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-/l5ZIgD4etiQU5hSnVw06YZySReLNHiG/nrST0QZ0Zg=";
      };
    };
    neogen = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "neogen";
      version = "2022-02-11";
      src = pkgs.fetchFromGitHub {
        owner = "danymat";
        repo = "neogen";
        rev = "f249a70ee598bdf8d015c10536c0dcd97c79b3aa";
        # sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-x2jpJ49G6fJhwE2I2FA4wZy/moZokvApJhzUav+fzqA=";
      };
    };
  in with pkgs.vimPlugins; [
    # various
    lualine-nvim
    alpha
    ale
    bufstop
    telescope-nvim
    indent-blankline-nvim

    # themes in use
    dracula-vim
    palenight-vim
    my-catppuccin-nvim
    papercolor-theme
    vim-nightfly

    # smart indentation
    vim-sleuth
    # File tree
    nvim-web-devicons
    nvim-tree-lua

    # nix
    vim-nix

    # completion engine
    # compe-tmux
    nvim-compe
    luasnip
    compe-tabnine

    # lsp
    nvim-lspconfig
    lsp_signature-nvim

    # treesitter
    (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))

    # highlighting
    #semshi
    haskell-vim

    # doc generation
    neogen
  ];
}
