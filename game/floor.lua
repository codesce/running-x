local globals = require( "globals" )
local grid = require( "game.grid" )

local floorHeight = globals.floorHeight
local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local displayGrid = globals.displayGrid

local currentFloorIndex = 1
local currentFloorLayout

local function init(group)
  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  if (displayGrid == true) then
     grid.drawGrid(group)
   end
end

local function render(group, matrix)
  currentFloorLayout = matrix

  -- for now, render all tiles (regardless of whether they're on screen)
  for columnIndex=1,#currentFloorLayout[1] do
    for rowIndex=1,#currentFloorLayout do -- 1 to 5
      local tile = matrix[rowIndex][columnIndex]
      if (tile == globals.objects.grass) then
        grid.drawGrassObject(group, columnIndex, rowIndex)
      end
    end
  end
end

local function destroy()
  currentFloorIndex = 0
  currentFloorLayout = nil
end

return {
  init = init,
  render = render,
  destroy = destroy
}
