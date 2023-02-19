"Plug 'stevearc/vim-arduino'         "{'for': 'clang'}

" let g:arduino_dir = '/usr/share/arduino/hardware/arduino/avr'
" let g:arduino_home_dir = $HOME . '.arduino15'
let g:arduino_serial_cmd = 'picocom {port} -b {baud} -l'

nnoremap <buffer> <leader>aa :ArduinoAttach<CR>
nnoremap <buffer> <leader>av :ArduinoVerify<CR>
nnoremap <buffer> <leader>au :ArduinoUpload<CR>
nnoremap <buffer> <leader>ad :ArduinoUploadAndSerial<CR>
nnoremap <buffer> <leader>ab :ArduinoChooseBoard<CR>
nnoremap <buffer> <leader>ap :ArduinoChooseProgrammer<CR>

" StatusLine Alternativa -> pode ser customizada -> invoca-se onde está:
" %{ArduinoStatusLine()}
"
" my_file.ino [arduino:avr:uno]
function! MyStatusLine()
  return '%f [' . g:arduino_board . ']'
endfunction
"setl statusline=%!MyStatusLine()

" my_file.ino [arduino:avr:uno] [arduino:usbtinyisp] (/dev/ttyACM0:9600)
function! ArduinoStatusLine()
  let port = arduino#GetPort()
  let line = '[' . g:arduino_board . '] [' . g:arduino_programmer . ']'
  if !empty(port)
    let line = line . ' (' . port . ':' . g:arduino_serial_baud . ')'
  endif
  return line
endfunction
augroup ArduinoStatusLine
  autocmd! * <buffer>
  "autocmd BufWinEnter <buffer> setlocal stl=%f\ %h%w%m%r\ %{ArduinoStatusLine()}\ %=\ %(%l,%c%V\ %=\ %P%)
  autocmd BufNewFile,BufRead *.ino let g:airline_section_x='%{ArduinoStatusLine()}'
augroup END
