globals
endglobals

function InitGlobals takes nothing returns nothing
endfunction

function main takes nothing returns nothing
    call InitGlobals()
    call Cheat("exec-lua:war3map")
endfunction
