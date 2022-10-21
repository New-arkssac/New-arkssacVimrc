let g:vimspector_install_gadgets = [ 'vscode-cpptools', 'CodeLLDB', 'debugpy' ]
let g:vimspector_variables_display_mode = 'full'
let g:vimspector_disassembly_height = 10
let g:vimspector_enable_mappings = 'HUMAN'

nmap <C-q> :VimspectorReset<CR>
nmap l <Plug>VimspectorStepOver
nmap i :VimspectorWatch 
nmap n :VimspectorShowOutput 
nmap o <Plug>VimspectorBalloonEval
xmap o <Plug>VimspectorBalloonEval
nmap u <Plug>VimspectorDisassemble
