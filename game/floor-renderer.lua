local globals = require( "globals" )
local tileRenderer = require( "game.tile-renderer" )
local grid = require( "game.grid" )

local displayCurrentTileObject = globals.floor.displayGridObjects
local minXValue = 0
local maxXValue = globals.screenWidth

local lastRenderedColumn

-- stores the tile table of the current level
local gridLayoutTiles

-- stores the tiles that are currently rendered on screen
local currentDisplayedTiles

local function getXForCurrentIndex()
  return grid.getCoordinates(lastRenderedColumn.index, 1).x
end

-- given the x coordinate, determine if visible on screen
local function isVisible(x)
  return (x >= minXValue and x <= maxXValue)
end

local function isOffScreen(x)
  return (x <= minXValue)
end

-- renders all the tiles in the current column
local function renderTileColumn(group)
  if (lastRenderedColumn.index > #gridLayoutTiles) then
    return
  end

  for rowIndex=1,5 do
    local tile = gridLayoutTiles[lastRenderedColumn.index][rowIndex]
    local coordinates = grid.getCoordinates(lastRenderedColumn.index, rowIndex)
    local renderedTile = tileRenderer.render( group, tile, coordinates )
    table.insert(currentDisplayedTiles, renderedTile)
  end

  lastRenderedColumn.index = lastRenderedColumn.index + 1
  lastRenderedColumn.x = getXForCurrentIndex()
  lastRenderedColumn:renderObject(group)
end

local function renderIncoming (group)
  local x = lastRenderedColumn.object:localToContent(0,0)

  if (isVisible(x)) then
    renderTileColumn(group)
  end
end

local function removeOutbound(group)
  for i = #currentDisplayedTiles, 1, -1 do
    local currentTile = currentDisplayedTiles[i]
    local currentTileBottomRightX = currentTile:localToContent(0,0) + currentTile.fullWidth

    if (isOffScreen(currentTileBottomRightX)) then
      display.remove(currentDisplayedTiles[i])
      table.remove(currentDisplayedTiles, i)
    end
  end
end

local function initLastRenderedColumn()
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
end

---------------------------------------------
-----             Public                -----
---------------------------------------------

local function init(group, level)
  initLastRenderedColumn()

  lastRenderedColumn.x = getXForCurrentIndex()
  currentDisplayedTiles = {}
  gridLayoutTiles = level.getTiles()

  --render the initial view
  while (isVisible(lastRenderedColumn.x)) do
    renderTileColumn(group)
  end
end

-- THIS FUNCTION WILL BE CALLED ON A GAME LOOP!
local function render(group)
  renderIncoming(group)
  removeOutbound(group)
end

local function destroy()
  lastRenderedColumn = nil
  gridLayoutTiles = nil
  currentDisplayedTiles = nil
end

return {
  init = init,
  render = render,
  renderNext = renderNext,
  destroy = destroy
}
