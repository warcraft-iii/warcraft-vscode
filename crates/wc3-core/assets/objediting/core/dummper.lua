---@class Dummper
Dummper = class('Dummper')

function Dummper:constructor(defType)
    self.defType = defType
    self:prepareAPIs(defType)
end

function Dummper:prepareAPIs(defType)

    if not sourcecode[defType] then
        print('Not find APIs with', defType)
        return
    end

    self.file = io.open(string.format([[%s.lua]], defType), 'w')

end

---@param defs table<string, Definition>
function Dummper:exec(defs)

    if not self.file then
        print('Not find APIs with', self.defType)
        return
    end

    local info = {'local u'}
    for id, def in pairs(defs) do
        local index = #info + 1
        local sub = {}
        for k, v in pairs(def.fields) do
            local api = sourcecode[self.defType][v.id]
            if not api then
                -- print('Miss API with', self.defType, def.id, v.id, v.value)
            else
                local value = v.value
                if type(value) == 'string' then
                    if value ~= '' then
                        value = '[[' .. value .. ']]'
                    else
                        value = '""'
                    end
                end
                if v.level and v.level > 0 then
                    table.insert(sub, string.format('u:%s(%s, %s)', api.func,
                                                     v.level, value))
                else
                    table.insert(sub, string.format('u:%s(%s)', api.func, value))
                end
            end
        end
        local cls = sourcecode[self.defType].super[def.superId or def.id]
        if cls then
            table.insert(info, index, string.format('\nu=%s:new("%s")', cls, def.id))
        else
            cls = sourcecode[self.defType].super["0"]
            table.insert(info, index, string.format('\nu=%s:new("%s", "%s")', cls, def.id, def.superId or def.id))
        end
        if #sub > 0 then
            table.insert(info, table.concat(sub, '\n'))
        end
    end

    table.insert(info, '\n')
    self.file:write(table.concat(info, '\n'))

end

