function Pop_Waring(msg)
  let l:pop_dict = {
   \ "line": 1,
   \ "col": 200, 
   \ "minwidth": 5,
   \ "pos": "topright",
   \ "time": 2000,
   \ "highlight": "WarningMsg",
   \ "close": "click",
   \}
  call popup_notification(a:msg, l:pop_dict)
endfunction

function Pop_Done(msg)
  let l:pop_dict = {
   \ "line": 1,
   \ "col": 200, 
   \ "minwidth": 5,
   \ "time": 2000,
   \ "pos": "topright",
   \ "highlight": "DiffAdd",
   \ "close": "click",
   \}
  call popup_notification(a:msg, l:pop_dict)
endfunction

function CheckCtags(chann, msg)
  if !filereadable(".tags") || a:msg != 0
    call Pop_Waring("make .tags error")
   return
  endif
  call Pop_Done("make .tags Done")
endfunction
