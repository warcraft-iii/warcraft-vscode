RESULT = RESULT or {}
--@debug@
RESULT.ct_debug = true
--@end-debug@
--@release@
RESULT.ct_release = true
--@end-release@
RESULT.table = compiletime(function()
    return { name = 'wc3', count = 3, list = { 'a', 'b' }, flag = true }
end)
RESULT.str = compiletime(function()
    return 'hello ]] world'
end)
RESULT.num = compiletime(function()
    return 40 + 2
end)
RESULT.f = compiletime(function()
    return -0.5
end)
RESULT.a, RESULT.b = compiletime(function()
    return 1, 'x'
end)
RESULT.gen = require('lib.gen').value
return RESULT
