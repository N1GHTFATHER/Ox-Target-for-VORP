local utils = require 'client.utils'

local function getCharacterData()
    return Player(PlayerId()).state.Character or {}
end

---@diagnostic disable-next-line: duplicate-set-field
function utils.hasPlayerGotGroup(filter)
    local character = getCharacterData()
    local job = character.Job or ''
    local jobgrade = character.Grade or 0
    local _type = type(filter)

    if _type == 'string' then
        return job == filter
    elseif _type == 'table' then
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            for name, grade in pairs(filter) do
                if job == name and grade <= jobgrade then
                    return true
                end
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                if filter[i] == job then
                    return true
                end
            end
        end
    end
end
