local globals = require( "globals" )
local grid = require( "game.grid" )
local floorRenderer = require( "game.floor-renderer" )

local floorHeight = globals.floorHeight
local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local displayGrid = globals.displayGrid

local group
local objectsGroup
local level

local function init(floorGroup, floorObjectsGroup, aLevel)
  group = floorGroup
  objectsGroup = floorObjectsGroup
  level = aLevel

  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  if (displayGrid == true) then
     grid.draw(group)
   end

   floorRenderer.init(objectsGroup, level)
end

local function render()
  floorRenderer.render(objectsGroup)
end

local function move(event)
  objectsGroup:setLinearVelocity(-300, 0)
end

local function destroy()
  floorRenderer.destroy()
  group = nil
  level = nil
  objectsGroup = nil
end

return {
  init = init,
  render = render,
  renderNext = renderNext,
  move = move,
  destroy = destroy
}
