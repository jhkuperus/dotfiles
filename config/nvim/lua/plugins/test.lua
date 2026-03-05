return {
  {
    "rcasia/neotest-java",
    ft = "java",
    dependencies = {
      "mfussenegger/nvim-jdtls",
      "mfussenegger/nvim-dap", -- for the debugger
      "rcarriga/nvim-dap-ui", -- recommended
      "theHamsta/nvim-dap-virtual-text", -- recommended
    },
    init = function()
      -- override the default keymaps.
      -- needed until neotest-java is integrated in LazyVim
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- run test file
      keys[#keys + 1] = {
        "<leader>tt",
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        mode = "n",
      }
      -- run nearest test
      keys[#keys + 1] = {
        "<leader>tr",
        function()
          require("neotest").run.run()
        end,
        mode = "n",
      }
      -- debug test file
      keys[#keys + 1] = {
        "<leader>tD",
        function()
          require("neotest").run.run({ strategy = "dap" })
        end,
        mode = "n",
      }
      -- debug nearest test
      keys[#keys + 1] = {
        "<leader>td",
        function()
          require("neotest").run.run({ vim.fn.expand("%"), strategy = "dap" })
        end,
        mode = "n",
      }
    end,
  },
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      adapters = {
        ["neotest-java"] = {
          -- config here
        },
      },
    },
  },
}
