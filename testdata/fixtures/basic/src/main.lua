local util = require('lib.util')
local strutil = require 'strutil'
RESULT = RESULT or {}
RESULT.mode = 'common'
--@debug@
RESULT.debug = true
--@end-debug@
--@release@
RESULT.release = true
--@end-release@
--[[@release@
RESULT.release_uncommented = true
--@end-release@]]
--@non-debug@
RESULT.non_debug = true
--@end-non-debug@
--@non-release@
RESULT.non_release = true
--@end-non-release@
--@classic@
RESULT.classic = true
--@end-classic@
--@reforge@
RESULT.reforge = true
--@end-reforge@
--@non-classic@
RESULT.non_classic = true
--@end-non-classic@
--@non-reforge@
RESULT.non_reforge = true
--@end-non-reforge@
--@remove@
RESULT.removed = true
--@end-remove@
RESULT.sum = util.add(1, 2)
RESULT.cn = require('中文目录.数据').value
RESULT.modwho = require('mod').who
RESULT.sugar = strutil.tag
dofile('lib/extra.lua')
--@classic@
require('jass.common')
--@end-classic@
return RESULT
