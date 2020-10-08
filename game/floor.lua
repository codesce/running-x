local globals = require( "globals" )
local grid = require( "game.grid" )
local floorRenderer = require( "game.floor-renderer" )

local floorHeight = globals.floor.height
local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local displayGrid = globals.grid.displayLines

local group
local objectsGroup

local function create(floorGroup, floorObjectsGroup, level)
  group = floorGroup
  objectsGroup = floorObjectsGroup

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

local function move()
  objectsGroup:setLinearVelocity(-300, 0)
end

local function slow()
  objectsGroup:setLinearVelocity(0, 0)
end

local function destroy()
  floorRenderer.destroy()
  group = nil
  objectsGroup = nil
end

return {
  create = create,
  render = render,
  move = move,
  slow = slow,
  destroy = destroy
}
