-- faster load times
require('impatient').enable_profile()

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
