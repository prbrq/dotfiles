return {
  -- Roslyn-based C# language server integration. This intentionally replaces
  -- OmniSharp; do not enable LazyVim's lang.dotnet extra unless you want OmniSharp.
  {
    "seblyng/roslyn.nvim",
    ft = { "cs", "razor", "cshtml" },
    ---@module 'roslyn.config'
    ---@type RoslynNvimConfig
    opts = {
      broad_search = true,
      lock_target = false,
    },
    config = function(_, opts)
      vim.lsp.config("roslyn", {
        settings = {
          ["csharp|background_analysis"] = {
            dotnet_analyzer_diagnostics_scope = "fullSolution",
            dotnet_compiler_diagnostics_scope = "fullSolution",
          },
          ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
          },
          ["csharp|completion"] = {
            dotnet_provide_regex_completions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
          },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
        },
      })

      require("roslyn").setup(opts)
    end,
  },

  -- C# syntax highlighting and structural parsing.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "c_sharp",
        "fsharp",
      },
    },
  },

  -- Tooling installed by Mason. Roslyn itself is installed as a dotnet tool
  -- so the same executable works outside Neovim too.
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "csharpier",
        "netcoredbg",
      },
    },
  },

  -- Format C# with CSharpier.
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        cs = { "csharpier" },
      },
    },
  },

  -- Debug .NET projects with netcoredbg.
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      if not dap.adapters.netcoredbg then
        local netcoredbg = vim.fn.exepath("netcoredbg")
        if netcoredbg == "" then
          netcoredbg = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg"
        end

        dap.adapters.netcoredbg = {
          type = "executable",
          command = netcoredbg,
          args = { "--interpreter=vscode" },
          options = {
            detached = false,
          },
        }
      end

      for _, lang in ipairs({ "cs", "fsharp", "vb" }) do
        dap.configurations[lang] = dap.configurations[lang] or {
          {
            type = "netcoredbg",
            name = "Launch .NET assembly",
            request = "launch",
            program = function()
              return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
          },
        }
      end
    end,
  },

  -- Test discovery/running for dotnet test projects.
  {
    "nvim-neotest/neotest",
    dependencies = {
      "Nsidorenco/neotest-vstest",
    },
    opts = {
      adapters = {
        ["neotest-vstest"] = {},
      },
    },
  },
}
