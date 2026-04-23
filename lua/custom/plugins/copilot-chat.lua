return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "nvim-lua/plenary.nvim", branch = "master" },
      {'github/copilot.vim'},
    },
    build = "make tiktoken",
    opts = {
      -- See Configuration section for options

      vim.keymap.set('n', '<leader>ac', ':CopilotChatToggle<CR>', { desc = 'Toggle Copilot chat' }),
      vim.keymap.set('v', '<leader>af', ':CopilotChatFix<CR>', { desc = 'Copilot fix' }),

      vim.keymap.set('i', "<C-a>", 'copilot#Accept("<CR>")', { silent = true, expr = true, replace_keycodes = false })
    },
  },
}
