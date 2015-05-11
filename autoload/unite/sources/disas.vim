let s:unite_source = {
            \'name': 'disas',
            \}

function! s:unite_source.gather_candidates(args, context)
    let path = expand('#:p')
    let lines = getbufline('#', 1, '$')
    call filter(lines, "v:val =~ '^\([0-9a-f]\+\s\)\?<'")
    let funcs = lines
"    let funcs = map(lines, "substitute(substitute(v:val, '<', ''), '>', '')")
    return map(funcs, '{
                \"word": v:val,
                \"source": "disas",
                \"kind": "jump_list",
                \"action_path": path,
                \"action_line": v:key+1
                \}')
endfunction

call unite#define_source(s:unite_source)
unlet s:unite_source

