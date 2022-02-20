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
        rev = "23d90298d0ede40e80ed45db7acedc8981ae62e4";
        sha256 = "1iqz5lhzs60468jldgq910dvirk56gcx55qg0cpvd3ga38mfbns5";
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
      name = "catpuccin";
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "nvim";
        rev = "22b34eb9f93430bc010dee1523743b62cd2700fc";
        sha256 = "sha256-ZcKHpQDcI2jNLhs5VYsVjAUpnM8Jwdo/1O0zo/k1DLM=";
      };
    };

    vim-nightfly = pkgs.vimUtils.buildVimPlugin {
      name = "vim-nightfly-guicolors";
      src = pkgs.fetchFromGitHub {
        owner = "bluz71";
        repo = "vim-nightfly-guicolors";
        rev = "d75a30e3874a9746d563634010accae4c463dc22";
        # sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-JhHjM9pyMnDd8Pkl5VWxn/aeY3b+oiBJh20wsIGYxLk=";
      };
    };
    neogen = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "neogen";
      version = "2022-02-11";
      src = pkgs.fetchFromGitHub {
        owner = "danymat";
        repo = "neogen";
        rev = "218e0a63fd28fe3fcd34477e198193f26e0863ce";
        # sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-rKVQ7bO8d19GaVAF00FOOd8ORBNZmhGu0XuJR1n2FvU=";
      };
      #src = pkgs.fetchurl {
      #  url = "https://github.com/danymat/neogen/archive/d3e0168e1eb4c0a84b132fd0b554427e62a49552.tar.gz";
      #  sha256 = "04ljl0jscff0xzrmd1ay0d78wjcs4xqc7fzcgkslimzm1yqpc71l";
      #};
    };
    #neogen = pkgs.vimUtils.buildVimPlugin {
    #  name = "nvim-neogen";
    #};
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
