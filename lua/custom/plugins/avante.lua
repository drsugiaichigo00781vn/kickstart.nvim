return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  build = vim.fn.has("win32") ~= 0
    and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
    or "make",
  version = false, -- Never set this value to "*"! Never!
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    -- add any opts here
    -- this file can contain specific instructions for your project
    -- for example
    input = {
      provider = "snacks",
      provider_opts = {
        title = "Avante Input",
        -- Other snacks.input options
      },
    },
    provider = "openrouter",
    providers = {
      openrouter = { -- Configuration for the Language Model (LLM) used by the RAG service
        __inherited_from = 'openai',
        endpoint = "https://openrouter.ai/api/v1", -- The LLM API endpoint for OpenRouter
        model = "openai/gpt-oss-120b:free", -- The LLM model name (e.g., "openai/gpt-4o-mini", "mistralai/mistral-7b-instruct")
        api_key_name = "OPENROUTER_API_KEY",
        use_ReAct_prompt = true,
      },
    },
      vim.keymap.set({'n', 'v'}, '<leader>ac', ':AvanteChat<CR>', { desc = 'Open agent chat' }),
      vim.keymap.set({'n', 'v'}, '<leader>anc', ':AvanteChatNew<CR>', { desc = 'Open new agent chat' }),
      vim.keymap.set('n', '<leader>ans', ':AvanteStop<CR>', { desc = 'Stop agent chat' }),
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "folke/snacks.nvim", -- for input provider snacks
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "Avante" },
      },
      ft = { "Avante" },
    },
  },
}
