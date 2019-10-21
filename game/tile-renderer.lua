local globals = require( "globals" )
local grid = require( "game.grid" )

local function drawGrassObject(group, coordinates)
  print("drawing grass object at: " .. coordinates.x .. ", " .. coordinates.y)

  local object = display.newRect(group, coordinates.x, coordinates.y, grid.xGap, grid.yGap)
  object.anchorX = 0
  object.anchorY = 0
  object:setFillColor( 0, 1, 0 )

  object.path.x2 = (grid.lineXOffset / grid.yLineCount)
  object.path.x3 = (grid.lineXOffset / grid.yLineCount)
end

local function render(group, tile, coordinates)
    if (tile == globals.objects.grass) then
      drawGrassObject(group, coordinates)
    end
end

return {
  render = render,
  destroy = destroy
}
