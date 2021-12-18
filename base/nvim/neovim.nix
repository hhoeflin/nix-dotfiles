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
  in with pkgs.vimPlugins; [
    # various
    lualine-nvim
    alpha
    ale
    bufstop
    dracula-vim
    telescope-nvim

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
    nvim-treesitter

    # highlighting
    semshi
    haskell-vim
  ];
}
