return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    workspaces = {
      {
        name = "notes",
        path = "~/Documents/notes",
      },
    },

    daily_notes = {
      folder = "daily",
      date_format = "%Y-%m-%d",
    },

    templates = {
      folder = "templates", -- optional, useful later
    },

    completion = {
      nvim_cmp = false,
    },

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        suffix = title:gsub(" ", "-"):lower()
      else
        suffix = tostring(os.time())
      end

      if title and title:lower():find("project") then
        return "projects/" .. suffix
      elseif title and title:lower():find("book") then
        return "books/" .. suffix
      elseif title and title:lower():find("code") then
        return "code/" .. suffix
      else
        return suffix
      end
    end,

    follow_url_func = function(url)
      vim.fn.jobstart({ "xdg-open", url })
    end,

    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true },
      },
    },
  },

  keys = {
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "New note (auto-folder)" },
    { "<leader>od", "<cmd>ObsidianToday<CR>", desc = "Today's daily note" },
    { "<leader>oy", "<cmd>ObsidianYesterday<CR>", desc = "Yesterday's note" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Quick switch" },
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search notes" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Backlinks" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "List links" },
    { "<leader>or", "<cmd>ObsidianRename<CR>", desc = "Rename note" },
    { "<leader>ox", "<cmd>ObsidianExtractNote<CR>", desc = "Extract to note" },
    { "<leader>otc", "<cmd>ObsidianTOC<CR>", desc = "Table of contents" },
  },
}

