-- Mini.nvim: Consolidated configuration for all mini modules

return {
  'echasnovski/mini.nvim',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    -- =====================================================================
    -- Text Objects (mini.ai)
    -- Better Around/Inside textobjects
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    -- =====================================================================
    require('mini.ai').setup { n_lines = 500 }

    -- =====================================================================
    -- Surround (mini.surround)
    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    -- =====================================================================
    require('mini.surround').setup()

    -- =====================================================================
    -- Statusline (mini.statusline)
    -- Helix-style minimalist statusline
    -- =====================================================================
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }

    ---@diagnostic disable-next-line: duplicate-set-field
    MiniStatusline.section_location = function()
      return '%l:%c'
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    MiniStatusline.section_filename = function()
      local filename = vim.fn.expand '%:t'
      if filename == '' then
        filename = '[scratch]'
      end
      local modified = vim.bo.modified and ' [+]' or ''
      return filename .. modified
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    MiniStatusline.section_diagnostics = function()
      local counts = {}
      local levels = {
        { name = 'ERROR', sign = 'E' },
        { name = 'WARN', sign = 'W' },
        { name = 'INFO', sign = 'I' },
        { name = 'HINT', sign = 'H' },
      }

      for _, level in ipairs(levels) do
        local n = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity[level.name] })
        if n > 0 then
          table.insert(counts, level.sign .. n)
        end
      end

      return #counts > 0 and table.concat(counts, ' ') .. ' ' or ''
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    MiniStatusline.active = function()
      local mode, mode_hl = MiniStatusline.section_mode { trunc_width = 120 }
      local diagnostics = MiniStatusline.section_diagnostics()
      local filename = MiniStatusline.section_filename { trunc_width = 140 }
      local location = MiniStatusline.section_location { trunc_width = 75 }
      local filetype = vim.bo.filetype ~= '' and ' ' .. vim.bo.filetype or ''

      return MiniStatusline.combine_groups {
        { hl = mode_hl, strings = { mode } },
        { hl = 'MiniStatuslineInactive', strings = { diagnostics } },
        '%=',
        { hl = 'MiniStatuslineFilename', strings = { filename } },
        '%=',
        { hl = 'MiniStatuslineFileinfo', strings = { location .. filetype } },
      }
    end

    -- =====================================================================
    -- Comment (mini.comment)
    -- Toggle comments with gcc (line) and gc (motion/visual)
    -- =====================================================================
    require('mini.comment').setup()

    -- =====================================================================
    -- Pairs (mini.pairs)
    -- Automatically close brackets, quotes, etc.
    -- =====================================================================
    require('mini.pairs').setup()

    -- =====================================================================
    -- Bufremove (mini.bufremove)
    -- Better buffer deletion that preserves window layout
    -- =====================================================================
    require('mini.bufremove').setup()

    -- =====================================================================
    -- Indentscope (mini.indentscope)
    -- Visual indent scope indicator with animated line
    -- =====================================================================
    require('mini.indentscope').setup {
      symbol = '│',
      options = { try_as_border = true },
    }

    -- =====================================================================
    -- Diff (mini.diff)
    -- Git diff indicators in sign column
    -- =====================================================================
    require('mini.diff').setup {
      view = {
        style = 'sign',
        signs = {
          add = '+',
          change = '~',
          delete = '_',
        },
      },
    }

    -- =====================================================================
    -- Hipatterns (mini.hipatterns)
    -- Highlight TODO, FIXME, NOTE, etc. in comments
    -- Replaces: todo-comments.nvim
    -- =====================================================================
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
        hack = { pattern = '%f[%w]()HACK()%f[%W]', group = 'MiniHipatternsHack' },
        todo = { pattern = '%f[%w]()TODO()%f[%W]', group = 'MiniHipatternsTodo' },
        note = { pattern = '%f[%w]()NOTE()%f[%W]', group = 'MiniHipatternsNote' },
        -- Highlight hex colors
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }

    -- =====================================================================
    -- Pick (mini.pick)
    -- Fuzzy finder for files, grep, LSP, and more
    -- Replaces: telescope.nvim
    -- =====================================================================
    local pick = require 'mini.pick'
    pick.setup {
      mappings = {
        move_down = '<C-n>',
        move_up = '<C-p>',
      },
    }

    -- Use mini.pick for vim.ui.select (replaces telescope-ui-select)
    vim.ui.select = pick.ui_select

    -- =====================================================================
    -- Extra (mini.extra)
    -- Additional pickers for mini.pick (LSP, diagnostics, etc.)
    -- =====================================================================
    require('mini.extra').setup()

    -- =====================================================================
    -- Clue (mini.clue)
    -- Shows pending keybinds
    -- Replaces: which-key.nvim
    -- =====================================================================
    local clue = require 'mini.clue'
    clue.setup {
      triggers = {
        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },

        -- Surround (mini.surround uses 's' prefix)
        { mode = 'n', keys = 's' },
        { mode = 'x', keys = 's' },

        -- Brackets
        { mode = 'n', keys = '[' },
        { mode = 'n', keys = ']' },
      },

      clues = {
        -- Leader group descriptions
        { mode = 'n', keys = '<Leader>b', desc = '+[B]uffer' },
        { mode = 'n', keys = '<Leader>f', desc = '+[F]ind' },
        { mode = 'n', keys = '<Leader>l', desc = '+[L]SP' },
        { mode = 'n', keys = '<Leader>t', desc = '+[T]oggle' },

        -- Enhance built-in clues
        clue.gen_clues.builtin_completion(),
        clue.gen_clues.g(),
        clue.gen_clues.marks(),
        clue.gen_clues.registers(),
        clue.gen_clues.windows(),
        clue.gen_clues.z(),
      },

      window = {
        delay = 200,
        config = {
          width = 'auto',
        },
      },
    }

    -- =====================================================================
    -- Keymaps for mini.pick (Find/Search)
    -- =====================================================================
    local extra = require 'mini.extra'

    vim.keymap.set('n', '<leader>ff', pick.builtin.files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fg', pick.builtin.grep_live, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fw', function()
      pick.builtin.grep { pattern = vim.fn.expand '<cword>' }
    end, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fh', pick.builtin.help, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', extra.pickers.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>fd', extra.pickers.diagnostic, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', pick.builtin.resume, { desc = '[F]ind [R]esume' })
    vim.keymap.set('n', '<leader>f.', extra.pickers.oldfiles, { desc = '[F]ind Recent Files' })
    vim.keymap.set('n', '<leader>fn', function()
      pick.builtin.files({}, { source = { cwd = vim.fn.stdpath 'config' } })
    end, { desc = '[F]ind [N]eovim files' })
    vim.keymap.set('n', '<leader>f/', function()
      extra.pickers.buf_lines { scope = 'all' }
    end, { desc = '[F]ind in Open Buffers' })
    vim.keymap.set('n', '<leader>/', function()
      extra.pickers.buf_lines { scope = 'current' }
    end, { desc = 'Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader><leader>', function()
      pick.builtin.buffers({}, {
        mappings = {
          delete_buffer = {
            char = '<C-d>',
            func = function()
              local matches = pick.get_picker_matches()
              if matches and matches.current then
                local bufnr = matches.current.bufnr
                vim.api.nvim_buf_delete(bufnr, { force = false })
              end
            end,
          },
        },
      })
    end, { desc = 'Find existing buffers' })
  end,
}
