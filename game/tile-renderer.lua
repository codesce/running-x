local globals = require( "globals" )
local grid = require( "game.grid" )

local tileSkewWidth = (grid.lineXOffset / grid.yLineCount)

-- This module is responsible for renderering the tiles onto the floor

local function drawGrassObject(group, coordinates)
  local object = display.newRect(group, coordinates.x, coordinates.y, grid.xGap, grid.yGap)
  object.anchorX = 0
  object.anchorY = 0
  object:setFillColor( 0, 1, 0 )

  object.path.x2 = tileSkewWidth
  object.path.x3 = tileSkewWidth

  object.fullWidth = grid.xGap + tileSkewWidth

  return object
end

---------------------------------------------
-----             Public                -----
---------------------------------------------

-- creates the tile object on the display group and returns it
local function render(group, tile, coordinates)
    if (tile == globals.objects.grass) then
      return drawGrassObject(group, coordinates)
    end
end

return {
  render = render,
  destroy = destroy
}
