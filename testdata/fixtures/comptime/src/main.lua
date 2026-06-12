RESULT = RESULT or {}
RESULT.table = compiletime(function()
    return { name = 'wc3', count = 3, list = { 'a', 'b' }, flag = true }
end)
RESULT.str = compiletime(function()
    return 'hello ]] world'
end)
RESULT.num = compiletime(function()
    return 40 + 2
end)
return RESULT
