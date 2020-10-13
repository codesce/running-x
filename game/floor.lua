local globals = require( "globals" )
local grid = require( "game.grid" )
local floorRenderer = require( "game.floor-renderer" )

local floorHeight = globals.floor.height
local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local displayGrid = globals.grid.displayLines

local Floor = {}

function Floor.new(floorGroup, floorObjectsGroup, level)
  local group = floorGroup
  local objectsGroup = floorObjectsGroup

  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  function floor:render()
    floorRenderer.render(objectsGroup)
  end

  function floor:move()
    objectsGroup:setLinearVelocity(-300, 0)
  end

  function floor:slow()
    objectsGroup:setLinearVelocity(0, 0)
  end

  if (displayGrid == true) then
     grid.draw(group)
   end

   floorRenderer.init(objectsGroup, level)

   return floor
end

return Floor
