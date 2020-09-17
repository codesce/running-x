local globals = require( "globals" )
local tileRenderer = require( "game.tile-renderer" )
local grid = require( "game.grid" )

local minXValue = 0
local maxXValue = globals.screenWidth

local currentFloorIndex
local currentFloorXIndex = minXValue
local currentFloorXObject

local gridLayoutTiles

local function getXForCurrentIndex()
  return grid.getCoordinates(currentFloorIndex, 1).x
end

local function init()
  currentFloorIndex = 1
  currentFloorXIndex = getXForCurrentIndex()
end

-- given the x coordinate, determine if visible
local function isVisible(x)
  return (x >= minXValue and x <= maxXValue)
end

-- this essentially renders initial tiles!
local function render(group, level)
  gridLayoutTiles = level.tiles

-- only render currently viewable tile columns
  while (isVisible(currentFloorXIndex)) do
    print("floor is visible at current floor index: " .. currentFloorIndex .. " (x: " .. currentFloorXIndex .. ")")

    for rowIndex=1,#gridLayoutTiles do -- 1 to 5
      local tile = gridLayoutTiles[rowIndex][currentFloorIndex]
      local coordinates = grid.getCoordinates(currentFloorIndex, rowIndex)
      tileRenderer.render( group, tile, coordinates )
    end

    currentFloorIndex = currentFloorIndex + 1
    currentFloorXIndex = getXForCurrentIndex()
  end

  -- add small rect to current render point for future rendering
  currentFloorXObject = display.newRect( group, currentFloorXIndex, 0, 5, 5 )
  currentFloorXObject:setFillColor( 1, 0, 0 )

  print("finished rendering tiles")
end

-- this function will be called on a game loop!
-- this should determine:
--     1. if the next line should be rendered (about to come on screen)
--     2. if any blocks should be removed
local function renderNext(group)
  local x = currentFloorXObject:localToContent(0,0)

  if (isVisible(x)) then
    -- render next line!
    for rowIndex=1,#gridLayoutTiles do
    end

    -- reset the current x index point!
  end
end


local function destroy()
  currentFloorIndex = nil
  currentFloorXIndex = nil
  gridLayoutTiles = nil
end

return {
  init = init,
  render = render,
  renderNext = renderNext,
  destroy = destroy
}
