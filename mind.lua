local threads = {}
local function masterUpdateAll(...)
    for i = 1, #threads do
        pcall(threads[i], ...)
    end
end

local queue = {}
local function receiveEvent(e)
    if e[1] == "submit" then
        local t = {table.unpack(e)}
        table.remove(t, 1)
        masterUpdateAll(table.unpack(t))
    end
end

local function submit(...)
    os.queueEvent("submit", ...)
end
