-- Just an example, supposed to be placed in /lua/custom/
local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "catppuccin_latte" },
}

M.plugins = {
  user = {
    ["goolord/alpha-nvim"] = {
      disable = false,
    },

    ["folke/which-key.nvim"] = {
      disable = false,
    },

    -- smooth scroll
    ["karb94/neoscroll.nvim"] = {
      config = function()
        require "custom.plugins.neoscroll"
      end,
    },

    -- lsp config
    ["williamboman/mason-lspconfig.nvim"] = {
      after = "mason.nvim",
      config = function()
        require "custom.plugins.mason-lspconfig"
      end,
    },

    ["neovim/nvim-lspconfig"] = {
      after = "mason-lspconfig.nvim",
      config = function()
        require "plugins.configs.lspconfig"
        require "custom.plugins.lspconfig"
      end,
    },

    -- formatter
    ["jose-elias-alvarez/null-ls.nvim"] = {
      after = "nvim-lspconfig",
      config = function()
        require "custom.plugins.null-ls"
      end,
    },
  },

  override = {
    -- Add some packages I really like
    ["williamboman/mason.nvim"] = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server",
        "stylua",

        -- web dev
        "css-lsp",
        "html-lsp",
        "typescript-language-server",
        "deno",
        "emmet-ls",
        "json-lsp",

        -- shell
        "shfmt",
        "shellcheck",
      },
    },
  },
}

return M
