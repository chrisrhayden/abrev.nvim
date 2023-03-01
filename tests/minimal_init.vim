set rtp+=.
set rtp+=..
set rtp+=./plenary.nvim

runtime plugin/plenary.vim

lua require("plenary.busted")
