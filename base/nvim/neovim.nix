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
        rev = "d688f46090a582be8f9d7b70b4cf999b780e993d";
        sha256 = "sha256-7WBfJ0jTroFTrKVP0bLZtv3bCVWGBT/W2jBZFJiUioE=";
      };
    };

    my-catppuccin-nvim = pkgs.vimUtils.buildVimPlugin {
      name = "catppuccin";
      src = pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "catppuccin";
        rev = "6251a800441b7155e3236aefeab8307546d492c9";
        sha256 = "sha256-dr+l8XjlaEkSJz72zHNv7eoq7y5DAQ+cixiSuy57fIY=";
      };
    };

    vim-nightfly = pkgs.vimUtils.buildVimPlugin {
      name = "vim-nightfly-guicolors";
      src = pkgs.fetchFromGitHub {
        owner = "bluz71";
        repo = "vim-nightfly-guicolors";
        rev = "83f27e09df7c78d8d1a00c67ff53786d66c23568";
        # sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-ibF4gTmyITiaUIcPGrFSmmN398p6Xw6DTi8onbrKvNE=";
      };
    };

    neogen = pkgs.vimUtils.buildVimPluginFrom2Nix {
      pname = "neogen";
      version = "2022-02-11";
      src = pkgs.fetchFromGitHub {
        owner = "danymat";
        repo = "neogen";
        rev = "c5a0c39753808faa41dea009d41dd686732c6774";
        # sha256 = pkgs.lib.fakeSha256;
        sha256 = "sha256-0RTnOEnorb53yHhk7MePeDhQbi4xsCCXObNi8+Bjjqc=";
      };
    };
  in with pkgs.vimPlugins; [
    # various
    lualine-nvim
    alpha
    ale
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
