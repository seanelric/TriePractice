local TriePractice = {}

function CreateTrie()
    -- local starttime = os.clock();

    -- Struct:
    -- node = {
    --  @var number count: How many string end by this char
    --  @var table child { [key1] = node, [key2] = node, ... }
    -- }
    self.m_trieRoot = { count = 0, child = {} }

    local nameList = {}
    for _, v in pairs(nameList) do
        self:m_insertTrieStr(v)
    end

    -- Cost time
    -- local endtime = os.clock();
    -- print(string.format("cost time  : %.4f", endtime - starttime));
end

function InsertTrieStr(str)
    if not str then
        return
    end

    str = Utils.Trim(str)

    local current = self.m_trieRoot
    local i = 1
    local byteCount = 0
    local key = nil

    while i < #str do
        byteCount = self:m_getStrByteCount(str, i)
        key = string.sub(str, i, i + byteCount)
        i = i + byteCount

        -- Add new
        if current.child[key] == nil then
            current.child[key] = { count = 0, child = {} }
        end
        
        current = current.child[key]
    end

    current.count = current.count + 1
end

function GetStrByteCount(str, index)
    local byteCount = 0
    local curByte = string.byte(str, index)
    if curByte > 0 and curByte <= 127 then
        byteCount = 1
    elseif curByte >= 192 and curByte < 223 then
        byteCount = 2
    elseif curByte >= 224 and curByte < 239 then
        byteCount = 3
    elseif curByte >= 240 and curByte <= 247 then
        byteCount = 4
    end

    return byteCount
end

function SearchTrieStrPre(str)
    if not str or str == "" then
        return
    end

    str = Utils.Trim(str)

    local current = self.m_trieRoot
    local i = 1
    local byteCount = 0
    local key = nil

    while i < #str do
        byteCount = self:m_getStrByteCount(str, i)
        key = string.sub(str, i, i + byteCount)
        i = i + byteCount

        if current.child[key] == nil then
            return
        end
        
        current = current.child[key]
    end

    return current
end

return TriePractice