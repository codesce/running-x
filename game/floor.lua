local globals = require( "globals" )
local grid = require( "game.grid" )
local floorRenderer = require( "game.floor-renderer" )

local floorHeight = globals.floorHeight
local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local displayGrid = globals.displayGrid

local function init(group, level)
  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  if (displayGrid == true) then
     grid.draw(group)
   end

   floorRenderer.init()
end

local function render(group, level)
  floorRenderer.render(group, level)
end

local function renderNext(group)
  floorRenderer.renderNext(group)
end

local function destroy()
  floorRenderer.destroy()
end

return {
  init = init,
  render = render,
  renderNext = renderNext,
  destroy = destroy
}
