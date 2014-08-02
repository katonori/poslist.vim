" Copyright (c) 2014, katonori All rights reserved.
"
" Redistribution and use in source and binary forms, with or without modification, are
" permitted provided that the following conditions are met:
"
"   1. Redistributions of source code must retain the above copyright notice, this list
"      of conditions and the following disclaimer.
"   2. Redistributions in binary form must reproduce the above copyright notice, this
"      list of conditions and the following disclaimer in the documentation and/or other
"      materials provided with the distribution.
"   3. Neither the name of the katonori nor the names of its contributors may be used to
"      endorse or promote products derived from this software without specific prior
"      written permission.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
" EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
" OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT
" SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
" INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
" TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
" BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
" CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
" ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
" DAMAGE.

if exists("g:loaded_poslist")
    finish
endif
let g:loaded_poslist = 1

let s:listMaxLen = 100
let s:posList = []

function! s:AddToList()
    call insert(s:posList, [bufnr("%"), expand("%:p"), getpos(".")], 0)
    let l:len = len(s:posList)
    if l:len > s:listMaxLen
        call remove(s:posList, s:listMaxLen)
    endif
endfunction

function! s:ShowList()
    let &errorformat="%f|%l|%c|%m"
    let l:resList = []
    for l:pos in s:posList
        let l:filename = l:pos[1]
        let l:lineNo = l:pos[2][1]
        let l:colNo = l:pos[2][2]
        let l:lines = readfile(l:filename)
        call add(l:resList, l:filename . "|" . l:lineNo . "|" . l:colNo  . "|" . l:lines[l:lineNo-1])
    endfor
    cexpr l:resList
    copen
endfunction

command! -nargs=0 PosListAdd :call <SID>AddToList()
command! -nargs=0 PosListShow :call <SID>ShowList()
