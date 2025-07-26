return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",  -- set the flavor here
        transparent_background = true,
        integrations = {
          treesitter = true,
          native_lsp = { enabled = true },
          telescope = true,
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          notify = true,
          mini = false,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  }
}
