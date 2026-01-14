-- LSP Configuration: Language servers for all your languages
-- Provides code intelligence, diagnostics, and navigation

return {
  -- Lazydev: Configures Lua LSP for Neovim config development
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },

  -- Main LSP Configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason: Automatically install LSPs and related tools
      { 'mason-org/mason.nvim', opts = {} },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP
      { 'j-hui/fidget.nvim', opts = {} },

      -- Schema information for JSON files
      'b0o/schemastore.nvim',


    },
    config = function()
      -- This function gets run when an LSP attaches to a particular buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper function for defining keymaps
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = '[L]SP ' .. desc })
          end

          -- Rename the variable under your cursor
          map('<leader>lr', vim.lsp.buf.rename, '[R]ename')

          -- Execute a code action
          map('<leader>la', vim.lsp.buf.code_action, '[A]ctions', { 'n', 'x' })

          -- Find references for the word under your cursor
          map('<leader>lR', function()
            require('mini.extra').pickers.lsp { scope = 'references' }
          end, '[R]eferences')

          -- Jump to the implementation of the word under your cursor
          map('<leader>li', function()
            require('mini.extra').pickers.lsp { scope = 'implementation' }
          end, '[I]mplementation')

          -- Jump to the definition of the word under your cursor
          map('<leader>ld', function()
            require('mini.extra').pickers.lsp { scope = 'definition' }
          end, '[D]efinition')

          -- Jump to declaration
          map('<leader>lD', function()
            require('mini.extra').pickers.lsp { scope = 'declaration' }
          end, '[D]eclaration')

          -- Fuzzy find all the symbols in your current document
          map('gO', function()
            require('mini.extra').pickers.lsp { scope = 'document_symbol' }
          end, 'Open Document Symbols')

          -- Fuzzy find all the symbols in your current workspace
          map('gW', function()
            require('mini.extra').pickers.lsp { scope = 'workspace_symbol' }
          end, 'Open Workspace Symbols')

          -- Jump to the type of the word under your cursor
          map('<leader>lt', function()
            require('mini.extra').pickers.lsp { scope = 'type_definition' }
          end, '[T]ype Definition')

          -- Helper function to check if client supports a method
          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          -- Highlight references of the word under cursor when idle
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Toggle inlay hints if the language server supports them
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- Auto-organize imports on save for TypeScript/JavaScript files
      -- Runs synchronously BEFORE formatting to avoid race conditions
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = { '*.ts', '*.tsx', '*.js', '*.jsx' },
        group = vim.api.nvim_create_augroup('ts-organize-imports', { clear = true }),
        callback = function(args)
          local clients = vim.lsp.get_clients({ bufnr = args.buf, name = 'ts_ls' })
          if #clients == 0 then
            return
          end

          local params = {
            command = '_typescript.organizeImports',
            arguments = { vim.api.nvim_buf_get_name(args.buf) },
            title = 'Organize Imports',
          }
          -- Use request_sync to wait for completion before save/formatting
          clients[1]:request_sync('workspace/executeCommand', params, 1000, args.buf)
        end,
      })

      -- Diagnostic configuration
      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = '󰅚 ',
            [vim.diagnostic.severity.WARN] = '󰀪 ',
            [vim.diagnostic.severity.INFO] = '󰋽 ',
            [vim.diagnostic.severity.HINT] = '󰌶 ',
          },
        } or {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            return diagnostic.message
          end,
        },
      }

      -- LSP capabilities for completion
      local capabilities = vim.lsp.protocol.make_client_capabilities()

      -- Language server configurations
      local servers = {
        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        -- TypeScript/JavaScript
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all',
                includeInlayFunctionParameterTypeHints = true,
              },
            },
          },
        },

        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'basic',
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- YAML
        yamlls = {
          settings = {
            yaml = {
              schemas = {
                ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*',
                ['https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json'] = 'docker-compose*.yml',
              },
            },
          },
        },

        -- JSON
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- Terraform
        terraformls = {},

        -- TOML
        taplo = {},
      }

      -- Ensure the servers and tools are installed
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Lua formatter
        'eslint_d', -- ESLint linter for TypeScript/JavaScript
        'ruff', -- Python linter
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        ensure_installed = {}, -- Explicitly set to empty (populated via mason-tool-installer)
        automatic_installation = false,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- Override capabilities
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
