return {
  "barrett-ruth/live-server.nvim",
  build = function()
    vim.fn.system({ 'npm', 'install', '-g', 'live-server' })
  end,
  cmd = { 'LiveServerStart', 'LiveServerStop' },
  config = function()
    require('live-server').setup()
  end
}
