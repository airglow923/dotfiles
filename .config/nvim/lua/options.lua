require "nvchad.options"

local g = vim.g
local o = vim.o

g.python3_host_prog = "/usr/bin/python3"
g.loaded_python3_provider = true
g.loaded_ruby_provider = true
g.loaded_node_provider = true
g.loaded_perl_provider = true
g.load_doxygen_syntax = true

o.autoindent = true
o.smartindent = true
o.encoding = "utf-8"
o.expandtab = true
o.tabstop = 4
o.softtabstop = 4
o.shiftwidth = 4
o.laststatus = 3
o.showcmd = true
o.foldenable = false
o.colorcolumn = "80,100,120"
o.background = "dark"
o.termguicolors = true
o.shell = "/bin/bash"
o.number = true
o.relativenumber = true
o.mouse = o.mouse .. "a"
o.clipboard = "unnamedplus"
o.cursorlineopt = "both"
