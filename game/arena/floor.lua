local globals = require( "globals" )
local Grid = require( "game.arena.grid" )
local FloorRenderer = require( "game.renderers.floor" )

local screenWidth = globals.screenWidth
local floorHeight = globals.floor.height
local displayGridLines = globals.grid.displayLines

local Floor = {}

-- TODO: probably best for groups to be created here and not passed in?
function Floor.new(floorGroup, floorObjectsGroup, level)
  local group = floorGroup
  local objectsGroup = floorObjectsGroup
  local renderer = FloorRenderer.new(objectsGroup, level)

  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
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

  if (displayGridLines == true) then
    local grid = Grid.new()
    grid.draw(group)
   end

   return floor
end

return Floor
