local globals = require( "globals" )
local grid = require( "game.grid" )
local tileRenderer = require( "game.tile-renderer" )

local floorHeight = globals.floorHeight
local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local displayGrid = globals.displayGrid

local function init(group)
  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  if (displayGrid == true) then
     grid.draw(group)
   end
end

local function render(group, level)
  tileRenderer.render(group, level)
end

local function destroy()
  tileRenderer:destroy()
end

return {
  init = init,
  render = render,
  destroy = destroy
}
