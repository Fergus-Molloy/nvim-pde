vim.cmd([[
	filetype on
	autocmd BufNew,BufRead *.md set filetype=markdown
	au Filetype markdown
		\ setlocal tw=80  |
		\ set wrap linebreak nolist nofoldenable
]])
