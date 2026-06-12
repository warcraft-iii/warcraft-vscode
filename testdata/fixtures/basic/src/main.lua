local util = require('lib.util')
RESULT = RESULT or {}
RESULT.mode = 'common'
--@debug@
RESULT.debug = true
--@end-debug@
--@release@
RESULT.release = true
--@end-release@
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
return RESULT
