local globals = require( "globals" )
local grid = require( "game.grid" )
local FloorRenderer = require( "game.renderers.floor" )

local Floor = {}

-- TODO: probably best for groups to be created here and not passed in?
function Floor.new(floorGroup, floorObjectsGroup, level)
  local group = floorGroup
  local objectsGroup = floorObjectsGroup
  local renderer = FloorRenderer.new(objectsGroup, level)

  local floor = display.newRect( group, 0, 0, globals.screenWidth, globals.floor.height )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  function floor:render()
    renderer:render()
  end

  function floor:move()
    objectsGroup:setLinearVelocity(-300, 0)
  end

  function floor:slow()
    objectsGroup:setLinearVelocity(0, 0)
  end

  if (globals.grid.displayLines == true) then
     grid.draw(group)
   end

   return floor
end

return Floor
