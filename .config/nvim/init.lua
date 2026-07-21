-- Minimal Neovim config focused on Markdown reading/editing.

-- Bootstrap lazy.nvim without hardcoded paths.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop

if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

-- Markdown-friendly buffer defaults.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true
    vim.opt_local.conceallevel = 2
    vim.opt_local.concealcursor = ""
    pcall(vim.treesitter.start)
  end,
})

require("lazy").setup({
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local treesitter = require("nvim-treesitter")

      treesitter.setup()
      treesitter.install({ "markdown", "markdown_inline" }):wait(300000)
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {},
  },
}, {
  -- Keep generated lockfile out of the stowed dotfiles repo.
  lockfile = vim.fn.stdpath("state") .. "/lazy-lock.json",
  checker = {
    enabled = false,
  },
  change_detection = {
    notify = false,
  },
})
