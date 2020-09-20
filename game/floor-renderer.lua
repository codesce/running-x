local globals = require( "globals" )
local tileRenderer = require( "game.tile-renderer" )
local grid = require( "game.grid" )

local minXValue = 0
local maxXValue = globals.screenWidth

local lastRenderedColumn = {
  index = nil,
  x = minXValue,
  object = nil
}

-- stores the tile table of the current level
local gridLayoutTiles

-- stores the tiles that are currently rendered on screen
local currentDisplayedTiles = {}

local function getXForCurrentIndex()
  return grid.getCoordinates(lastRenderedColumn.index, 1).x
end

-- given the x coordinate, determine if visible on screen
local function isVisible(x)
  return (x >= minXValue and x <= maxXValue)
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

  -- add small rect to current render point for future rendering
  display.remove(lastRenderedColumn.object)
  lastRenderedColumn.object = display.newRect( group, lastRenderedColumn.x, 0, 5, 5 )
  lastRenderedColumn.object:setFillColor( 1, 0, 0 )
end

local function init(group, level)
  lastRenderedColumn.index = 1
  lastRenderedColumn.x = getXForCurrentIndex()

  gridLayoutTiles = level.tiles

  while (isVisible(lastRenderedColumn.x)) do
    renderTileColumn(group)
  end
end

-- THIS FUNCTION WILL BE CALLED ON A GAME LOOP!
-- this should determine if the next column should be rendered (about to come on screen)
local function render(group)
  local x = lastRenderedColumn.object:localToContent(0,0)

  if (isVisible(x)) then
    renderTileColumn(group)
  end
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
