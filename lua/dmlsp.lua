local util = require 'lspconfig.util'

local bin_name = 'dm-langserver'
local cmd = { bin_name }

if vim.fn.has 'win32' == 1 then
  cmd = { 'cmd.exe', '/C', bin_name }
end

return {
  default_config = {
    cmd = cmd,
    filetypes = { 'dm', 'dme' },
    root_dir = util.root_pattern('SpacemanDMM.toml', '.git'),
  },
  docs = {
    description = [[
https://github.com/SpaceManiac/SpacemanDMM/tree/master/crates/dm-langserver

Language Server for BYOND DreamMaker code

`dm-langserver` can be installed via cargo:
cargo install --git https://github.com/SpaceManiac/SpacemanDMM.git dm-langserver
]],
  },
}
