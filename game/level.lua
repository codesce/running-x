local globals = require( "globals" )
-- TODO: load level dynamically
local level = require( "game.level.A00001" )

local numBlankColumns = globals.level.initialBlankColumns

local tiles

-- TODO: replace this with extensions from Penlight or stdlib
local function copyTable(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in pairs(orig) do
            copy[orig_key] = orig_value
        end
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

local function addBlankColumns(aTable)
  for i=1,numBlankColumns do
    table.insert(aTable, 1, { 0, 0, 0, 0, 0 })
  end
end

---------------------------------------------
-----             Public                -----
---------------------------------------------

local function create()
  tiles = copyTable(level.tiles)
  addBlankColumns(tiles)
end

local function getTiles()
  return tiles
end

local function destroy()
  tiles = nil
end

return {
  create = create,
  getTiles = getTiles,
  destroy = destroy
}
