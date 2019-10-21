local globals = require( "globals" )
local tileRenderer = require( "game.tile-renderer" )
local grid = require( "game.grid" )

local minXValue = 0
local maxXValue = globals.screenWidth

local currentFloorIndex
local currentFloorXIndex = minXValue

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

  print("finished rendering tiles")
end

local function destroy()
  currentFloorIndex = nil
  currentFloorXIndex = nil
  gridLayoutTiles = nil
end

return {
  init = init,
  render = render,
  destroy = destroy
}
