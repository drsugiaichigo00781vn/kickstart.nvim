local range_ignore_filetypes = { 'lua' }
local format_modified = function()
  local data = MiniDiff.get_buf_data()
  if not data or not data.hunks then
    vim.notify 'No hunks in this buffer'
    return
  end
  local format = require('conform').format
  -- stylua range format mass up indent, so use full format for now
  if vim.tbl_contains(range_ignore_filetypes, vim.bo.filetype) then
    format { lsp_fallback = true, timeout_ms = 500 }
    return
  end
  local ranges = {}
  for _, hunk in pairs(data.hunks) do
    if hunk.type ~= 'delete' then
      -- always insert to index 1 so format below could start from last hunk, which this sort didn't mess up range
      table.insert(ranges, 1, {
        start = { hunk.buf_start, 0 },
        ['end'] = { hunk.buf_start + hunk.buf_count, 0 },
      })
    end
  end
  for _, range in pairs(ranges) do
    format { lsp_fallback = true, timeout_ms = 500, range = range }
  end
end

return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function() require('conform').format { async = true } end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  ---@module 'conform'
  ---@type conform.setupOpts
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr) format_modified() end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { 'prettier', stop_after_first = true },
      typescript = { 'prettier', stop_after_first = true },
      ['_'] = { 'prettier' },
    },
  },
}
