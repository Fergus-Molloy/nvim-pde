require('impatient').enable_profile()

require('alpha').setup(require('alpha.themes.dashboard').config)
-- Set lualine as statusline
-- See `:help lualine.txt`
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'gruvbox_dark',
    component_separators = '|',
    section_separators = '',
  },
}

require('Comment').setup()

-- Gitsigns
-- See `:help gitsigns.txt`
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

require('bufferline').setup {
  options = {
    separator_style = 'slant',
    diagnostics = "nvim_lsp",
    sort_by = 'directory',
    hover = {
      enabled = true,
      delay = 200,
      reveal = { 'close', 'pin' }
    }
  }
}

require('toggleterm').setup {
  open_mapping = [[<c-t>]],
  hide_numbers = true,
  shade_terminals = false,
  autochdir = true,
  direction = 'float',
  float_opts = {
    border = 'curved',
    winblend = 3
  }
}

require('todo-comments').setup {
  search = {
    pattern = [[\b(KEYWORDS):?]]
  }
}

require("luasnip.loaders.from_vscode").lazy_load({ paths = "./snippets" })
-- to write lua snippets put them in $MYVIMRC/lua/user/snippets/<lang>.lua
-- then uncomment the line below changing the module to the appropriate paths
-- in those lua files simply `return { <snippets> }`
-- require('luasnip').add_snippets("<lang>" , require('user.snippets.<lang>'))
vim.keymap.set('i', '<c-c>', require('luasnip.extras.select_choice'), { noremap = true })
vim.keymap.set("i", "<C-f>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("s", "<C-f>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("i", "<C-d>", "<Plug>luasnip-prev-choice", {})
vim.keymap.set("s", "<C-d>", "<Plug>luasnip-prev-choice", {})

require('nvim-tree').setup { -- BEGIN_DEFAULT_OPTS
  view = {
    mappings = {
      list = {
        -- user mappings go here
      },
    },
  },
  renderer = {
    icons = {
      git_placement = "before",
      modified_placement = "after",
      glyphs = {
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
        },
        git = {
          untracked = "?",
          staged = "+",
          renamed = "»",
          unstaged = "!",
          unmerged = "",
          deleted = "✗",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
  diagnostics = {
    enable = true,
    show_on_dirs = false,
    show_on_open_dirs = false,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
}


vim.keymap.set('n', '<leader>fb', require('nvim-tree.api').tree.toggle, { noremap = true, desc = "[F]ile [B]rowser" })
