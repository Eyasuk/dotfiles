return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "rust_analyzer",
          "somesass_ls",
          "lua_ls",
          "cssls",
          "dockerls",
          "elixirls",
          "grammarly",
          "html",
          "solidity",
          "ts_ls",
          "pyright",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.solargraph.setup({
        capabilities = capabilities,
      })
      lspconfig.html.setup({
        capabilities = capabilities,
      })
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.grammarly.setup({
        capabilities = capabilities,
      })
      lspconfig.solidity.setup({
        capabilities = capabilities,
      })
      lspconfig.pyright.setup({
        capabilities = capabilities,
      })
      lspconfig.astro.setup({
        capabilities = capabilities,
      })
      lspconfig.somesass_ls.setup({
        capabilities = capabilities,
      })
      lspconfig.cssls.setup({
        capabilities = capabilities,
      })
      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          format = function(diagnostic)
            local msg = diagnostic.message
            if #msg > 40 then
              return msg:sub(1, 37) .. "..."
            else
              return msg
            end
          end,
        },
        float = {
          border = "rounded",
          source = "always",
          focusable = false,
        },
        signs = true,
        underline = true,
        update_in_insert = false,
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show full diagnostics" })
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics to location list" })

      vim.keymap.set("n", "<leader>y", function()
        local line = vim.api.nvim_win_get_cursor(0)[1] - 1 -- 0-based line number
        local diagnostics = vim.diagnostic.get(0, { lnum = line })

        if #diagnostics == 0 then
          print("No diagnostics under cursor")
          return
        end

        -- Find the diagnostic closest to the cursor column (optional)
        local col = vim.api.nvim_win_get_cursor(0)[2]
        local closest_diag = diagnostics[1]
        local min_distance = math.abs(diagnostics[1].col - col)

        for _, diag in ipairs(diagnostics) do
          local dist = math.abs(diag.col - col)
          if dist < min_distance then
            min_distance = dist
            closest_diag = diag
          end
        end

        vim.fn.setreg("+", closest_diag.message)
        print("Copied diagnostic: " .. closest_diag.message)
      end, { desc = "Copy diagnostic under cursor" })
    end,
  },
}
