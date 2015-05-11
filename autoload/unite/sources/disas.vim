let s:unite_source = {
            \'name': 'disas',
            \}

function! s:unite_source.gather_candidates(args, context)
    let path = expand('#:p')
    let lines = getbufline('%', 1, '$')
    let funcs = {}
    for i in range(len(lines))
       let funcs[i] = get(lines, i)
    endfor
    call filter(funcs, "v:val =~ '^\\([0-9a-f]\\+\\s\\)\\?<'")
    call map(funcs, "matchstr(v:val, '<.\\+>')")
    let res = []
    for i in keys(funcs)
        call insert(res, {
                \"word": funcs[i],
                \"source": "disas",
                \"kind": "jump_list",
                \"action__path": path,
                \"action__line": i + 1
                \} )
    endfor
    return res
endfunction

function! unite#sources#disas#define()
  return s:unite_source
endfunction
