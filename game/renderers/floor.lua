local globals = require( "globals" )
local TileRenderer = require( "game.renderers.tile" )
local Grid = require( "game.arena.grid" )

local displayCurrentTileObject = globals.floor.displayGridObjects
local minXValue = 0
local maxXValue = globals.screenWidth

---------------------------------------------
-----   Column - used by FloorRenderer  -----
---------------------------------------------

local Column = {}

function Column.new()
  local column = {}

  column.index = 1
  column.x = minXValue
  column.object = nil

  function column:renderObject(group)
    if (self) then
      display.remove(self.object)
    end
    self.object = display.newRect( group, self.x, 0, 5, 5 )
    self.object:setFillColor( 1, 0, 0,  displayCurrentTileObject and 1 or 0 )
  end

  return column
end

---------------------------------------------
-----            FloorRenderer          -----
---------------------------------------------

local FloorRenderer = {}

function FloorRenderer.new(group, level)
  local tileRenderer = TileRenderer.new()
  local grid = Grid.new()
  local tiles = level.getTiles()
  local currentDisplayedTiles = {}

  local lastRenderedColumn = Column.new()

  ---------------------------------------------
  -----             Private               -----
  ---------------------------------------------

  local function isVisible(x)
    return (x >= minXValue and x <= maxXValue)
  end

  local function isOffScreen(x)
    return (x <= minXValue)
  end

  local function getXForCurrentIndex()
    return grid:getCoordinates(lastRenderedColumn.index, 1).x
  end

  local function renderTileColumn()
    if (lastRenderedColumn.index > #tiles) then
      return
    end

    for rowIndex=1,5 do
      local tile = tiles[lastRenderedColumn.index][rowIndex]
      local coordinates = grid:getCoordinates(lastRenderedColumn.index, rowIndex)
      local renderedTile = tileRenderer:render( group, tile, coordinates )
      table.insert(currentDisplayedTiles, renderedTile)
    end

    lastRenderedColumn.index = lastRenderedColumn.index + 1
    lastRenderedColumn.x = getXForCurrentIndex()
    lastRenderedColumn:renderObject(group)
  end

  local function renderIncoming()
    local x = lastRenderedColumn.object:localToContent(0,0)

    if (isVisible(x)) then
      renderTileColumn()
    end
  end

  local function removeOutbound()
    for i = #currentDisplayedTiles, 1, -1 do
      local currentTile = currentDisplayedTiles[i]
      local currentTileBottomRightX = currentTile:localToContent(0,0) + currentTile.fullWidth

      if (isOffScreen(currentTileBottomRightX)) then
        display.remove(currentDisplayedTiles[i])
        table.remove(currentDisplayedTiles, i)
      end
    end
  end

  local function init()
    lastRenderedColumn.x = getXForCurrentIndex()

    while (isVisible(lastRenderedColumn.x)) do
      renderTileColumn()
    end
  end

  ---------------------------------------------
  -----             Public                -----
  ---------------------------------------------

  function group:render()
    renderIncoming()
    removeOutbound()
  end

  init()

  return group
end

return FloorRenderer
