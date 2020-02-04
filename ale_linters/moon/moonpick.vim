" Author: Alexei Robyn https://github.com/Shados
" Description: moonpick for linting Moonscript files

 function! ale_linters#moon#moonpick#Handle(buffer, lines) abort
    let l:pattern = '^\(\d\+\):\(\d\+\):\(.\+\)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
      call add(l:output, {
      \   'lnum': l:match[1] + 0,
      \   'col': l:match[2] + 0,
      \   'text': l:match[3],
      \   'type': 'E',
      \})
    endfor

    return l:output
 endfunction

 call ale#linter#Define('moon', {
 \   'name': 'moonpick',
 \   'executable': 'moonpick-vim',
 \   'command': 'moonpick-vim %s',
 \   'callback': 'ale_linters#moon#moonpick#Handle',
 \   'output_stream': 'stdout',
 \})
