vim.diagnostic.config({
  virtual_text = false,
})
-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', '<cmd>Lspsaga rename<cr>', '[R]e[n]ame')
  nmap('<leader>ca', '<cmd>Lspsaga code_action<cr>', '[C]ode [A]ction')
  vim.keymap.set('n', '<leader>do', '<cmd>Lspsaga show_line_diagnostics<cr>',
    { noremap = true, silent = true, desc = "[D]iagnostic [O]pen" })
  vim.keymap.set('n', '<leader>ad', '<cmd>Lspsaga show_buf_diagnostics',
    { noremap = true, silent = true, desc = "[A]ll [D]iagnostics" })

  nmap('ho', '<cmd>Lspsaga lsp_finder<cr>', 'Open [Ho]ver')
  nmap('pd', '<cmd>Lspsaga peek_definition<cr>', '[P]eek [D]efinition')
  nmap('gd', '<cmd>Lspsaga goto_definition<cr>', '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  nmap("<leader>o", "<cmd>Lspsaga outline<CR>", "Toggle [O]utline")

  -- See `:help K` for why this keymap
  nmap('K', "<cmd>Lspsaga hover_doc<CR>", 'Hover Documentation')
  nmap('KK', "<cmd>Lspsaga hover_doc ++keep<CR>", 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  rust_analyzer = {
    ["rust-analyzer"] = {
      checkOnSave = true,
      check = {
        -- overrideCommand = "cargo clippy --workspaces --message-format=json --all-targets -- -W clippy::pedantic",
        command = "clippy",
        extraArgs = { "--", "-W", "clippy::pedantic" },
      },
    },
  },
  omnisharp = {
    cmd = { "dotnet", "/usr/bin/dotnet" },
  },
  -- tsserver = {},
  -- 'lua-language-server' = {},
}

-- Setup neovim lua configuration
require('neodev').setup()
--
-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- Turn on lsp status information
require('fidget').setup()

require('nvim-autopairs').setup({})
-- nvim-cmp setup
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup {
  preselect = cmp.PreselectMode.None,
  completion = { completeopt = 'menu,menuone,noinsert,noselect' },
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-n>'] = function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end,
    ['<C-p>'] = function()
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      end
    end,
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
  },
}
