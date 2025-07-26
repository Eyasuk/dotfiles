return {
   -- Flutter tools
  {
    "akinsho/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      -- Flutter SDK path (update as needed)
      local flutter_sdk = "/home/user42/flutter"
      local dart_sdk = flutter_sdk .. "/bin/cache/dart-sdk"

      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        map("n", "K", vim.lsp.buf.hover, "Hover")
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gr", vim.lsp.buf.references, "References")
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")
      end

      require("flutter-tools").setup({
        flutter_path = flutter_sdk .. "/bin/flutter",
        ui = {
          border = "rounded",
          notification_style = "plugin",
        },
        outline = {
          open_cmd = "30vnew",
          auto_open = false,
        },
        closing_tags = {
          highlight = "Comment",
          prefix = "// ",
          enabled = true,
        },
        debugger = {
          enabled = true,
          run_via_dap = true,
          register_configurations = function(_)
            require("dap").adapters.dart = {
              type = "executable",
              command = vim.fn.stdpath("data") .. "/mason/bin/dart-debug-adapter",
              args = { "flutter" },
            }

            require("dap").configurations.dart = {
              {
                type = "dart",
                request = "launch",
                name = "Launch Flutter",
                dartSdkPath = dart_sdk,
                flutterSdkPath = flutter_sdk,
                program = "${workspaceFolder}/lib/main.dart",
                cwd = "${workspaceFolder}",
              },
            }
          end,
        },
        dev_log = {
          enabled = true,
          open_cmd = "tabedit",
        },
        lsp = {
          on_attach = on_attach,
          capabilities = capabilities,
          color = {
            enabled = true,
            virtual_text = true,
            virtual_text_str = "■",
          },
          settings = {
            showTodos = true,
            completeFunctionCalls = true,
            renameFilesWithClasses = "prompt",
            enableSnippets = true,
            enableSdkFormatter = true,
          },
        },
      })
    end,
  },


  { "dart-lang/dart-vim-plugin" },
}
