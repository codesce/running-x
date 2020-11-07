local globals = require( "globals" )
local tileRenderer = require( "game.tile-renderer" )
local grid = require( "game.grid" )

local displayCurrentTileObject = globals.floor.displayGridObjects
local minXValue = 0
local maxXValue = globals.screenWidth

local FloorRenderer = {}

function FloorRenderer.new(group, level)
  local tiles = level.getTiles()
  local currentDisplayedTiles = {}
  local lastRenderedColumn

  local function isVisible(x)
    return (x >= minXValue and x <= maxXValue)
  end

  local function isOffScreen(x)
    return (x <= minXValue)
  end

  local function getXForCurrentIndex()
    return grid.getCoordinates(lastRenderedColumn.index, 1).x
  end

  local function renderTileColumn()
    if (lastRenderedColumn.index > #tiles) then
      return
    end

    for rowIndex=1,5 do
      local tile = tiles[lastRenderedColumn.index][rowIndex]
      local coordinates = grid.getCoordinates(lastRenderedColumn.index, rowIndex)
      local renderedTile = tileRenderer.render( group, tile, coordinates )
      table.insert(currentDisplayedTiles, renderedTile)
    end

    lastRenderedColumn.index = lastRenderedColumn.index + 1
    lastRenderedColumn.x = getXForCurrentIndex()
    lastRenderedColumn:renderObject(group)
  end

  local function renderIncoming ()
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
    lastRenderedColumn = {
     index = 1,
     x = minXValue,
     object = nil,
     renderObject = function (self, group)
       if (self) then display.remove(self.object) end
       self.object = display.newRect( group, self.x, 0, 5, 5 )
       self.object:setFillColor( 1, 0, 0,  displayCurrentTileObject and 1 or 0 )
     end
   }

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
