{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [ inputs.nvf.homeManagerModules.default ];

  programs.nvf = {
    enable = true;
    enableManpages = true;

    settings.vim = {
      options = {
        number = true;
        relativenumber = true;
        incsearch = true;
        scrolloff = 3;
        textwidth = 100;
        cursorline = true;
        cursorcolumn = true;
        title = true;
        termguicolors = true;
        showmode = false;
      };

      lsp = {
        enable = true;
        formatOnSave = true;
        trouble.enable = true;
        lspSignature.enable = true;

        servers = {
          nixd.settings.nixd.formatting.command = [ (lib.getExe pkgs.nixfmt) ];
        };
      };

      languages = {
        enableTreesitter = true;
        enableFormat = true;
        enableExtraDiagnostics = true;

        nix = {
          enable = true;
          lsp.servers = [ "nixd" ];
          format.type = [ "nixfmt" ];
        };

        go.enable = true;
        rust.enable = true;
        python.enable = true;
        bash.enable = true;
        typescript.enable = true;
      };

      diagnostics.nvim-lint.linters.eslint_d.required_files = [
        "eslint.config.ts"
        "eslint.config.mts"
        "eslint.config.cts"
      ];

      visuals = {
        nvim-cursorline.enable = true;

        fidget-nvim = {
          enable = true;
        };

        highlight-undo.enable = true;
        indent-blankline.enable = true;
      };

      statusline.lualine.enable = true;

      theme.enable = false;

      autopairs.nvim-autopairs.enable = true;

      autocomplete.nvim-cmp.enable = true;

      snippets.luasnip.enable = true;

      #tabline.nvimBufferline.enable = true;

      treesitter.context.enable = true;

      binds = {
        whichKey.enable = true;
        cheatsheet.enable = true;
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      notify.nvim-notify = {
        enable = true;
      };

      ui = {
        borders.enable = true;
        noice = {
          enable = true;
          setupOpts.lsp.progress.enabled = false;
        };
        colorizer.enable = true;
        modes-nvim.enable = true;
        illuminate.enable = true;
        smartcolumn.enable = true;
        fastaction.enable = true;
      };

      comments.comment-nvim.enable = true;

      startPlugins = with pkgs.vimPlugins; [
        (pkgs.vimUtils.buildVimPlugin {
          name = "vesper";
          src = pkgs.fetchFromGitHub {
            owner = "datsfilipe";
            repo = "vesper.nvim";
            rev = "1717b1a";
            sha256 = "sha256-Tx621yTfTu3dLctXKPaJy6rZn2YvWP8eFAJoVvEeR/c=";
          };

          postInstall = ''
            	    rm $out/init.lua
            	  ''; # breaks flake build
        })
        vim-nix
      ];

      luaConfigRC.vesper = ''
        require("vesper").setup({
          transparent = false,
          italics = {
            comments = true,
            keywords = true,
            functions = true,
            strings = true,
            variables = true,
          },
        })

        vim.cmd.colorscheme("vesper")
      '';
    };
  };
}
