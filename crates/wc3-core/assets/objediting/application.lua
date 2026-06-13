-- manager.lua
-- @Author : Dencer (tdaddon@163.com)
-- @Link   : https://dengsir.github.io
-- @Date   : 7/12/2019, 2:42:12 PM

---@class Application
Application = {}

---@type table<DefinitionType, integer>
local FILE_VERSIONS = {}

function Application:init()
    self:initDefinitions()
    self:execute()
    self:saveDefinitions()
end

function Application:initDefinitions()
    for _, defType in pairs(DefinitionType) do
        local name = args.map .. '/war3map.' .. defType
        local file = io.open(name, 'rb')
        if file then
            local data = file:read('a')
            file:close()
            local reader = ObjectReader:new(defType, data)
            local defs = reader:read()
            FILE_VERSIONS[defType] = reader.version

            for id, def in pairs(defs) do
                DEFINITIONS[id] = def
                TYPED_DEFINITIONS[defType][id] = def
            end

            if args.dump then
                local dummper = Dummper:new(defType)
                dummper:exec(defs)
            end
        end
    end
end

function Application:execute()
    for _, file in ipairs(args.files) do
        local dir = file:gsub('[%\\%/][^%/%\\]+$', '')
        os.chdir(dir)
        dofile(file)
    end
end

function Application:saveDefinitions()
    for defType, defs in pairs(TYPED_DEFINITIONS) do
        local writer = ObjectWriter:new(defType, FILE_VERSIONS[defType])
        writer:write(defs)
        local buf = writer:getBuffer()

        local file = assert(io.open(args.output .. '/war3map.' .. defType, 'wb'))
        file:write(buf)
        file:close()
    end
end

Application:init()
