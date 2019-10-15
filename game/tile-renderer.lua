local globals = require( "globals" )
local grid = require( "game.grid" )

local currentFloorIndex = 1
local currentTileLayout

local function drawGrassObject(group, xGridPosition, yGridPosition)
  print("drawing grass object at: " .. xGridPosition .. ", " .. yGridPosition)

  local coordinates = grid.getCoordinates(xGridPosition, yGridPosition)

  local object = display.newRect(group, coordinates.x, coordinates.y, grid.xGap, grid.yGap)
  object.anchorX = 0
  object.anchorY = 0
  object:setFillColor( 0, 1, 0 )

  object.path.x2 = (grid.lineXOffset / grid.yLineCount)
  object.path.x3 = (grid.lineXOffset / grid.yLineCount)
end

local function render(group, level)
  currentTileLayout = level.tiles

  for columnIndex=1,#currentTileLayout[1] do -- 1 to X
    for rowIndex=1,#currentTileLayout do -- 1 to 5
      local tile = currentTileLayout[rowIndex][columnIndex]
      if (tile == globals.objects.grass) then
        drawGrassObject(group, columnIndex, rowIndex)
      end
    end
  end
end

local function destroy()
  currentFloorIndex = 0
  currentTileLayout = nil
end

return {
  render = render,
  destroy = destroy
}
