local globals = require( "globals" )
local Grid = require( "game.arena.grid" )
local FloorRenderer = require( "game.renderers.floor" )

local screenWidth = globals.screenWidth
local floorHeight = globals.floor.height
local displayGridLines = globals.grid.displayLines

local minFloorVelocity = 0
local maxFloorVelocity = 500

local Floor = {}

function Floor.new(floorGroup, floorObjectsGroup, level)
  local group = floorGroup
  local objectsGroup = floorObjectsGroup
  local renderer = FloorRenderer.new(objectsGroup, level)

  local floor = display.newRect( group, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor.anchorX = 0
  floor.anchorY = 0

  local currentVelocity = minFloorVelocity
  local velocityRatio = 10

  function floor:render()
    renderer:render()
  end

  function floor:move(delta)
    if (currentVelocity < maxFloorVelocity) then
      local newVelocity = currentVelocity + velocityRatio * delta

      if (newVelocity > maxFloorVelocity) then
        currentVelocity = maxFloorVelocity
      else
        currentVelocity = newVelocity
      end
    end

    objectsGroup:setLinearVelocity(currentVelocity*-1, 0)
  end

  function floor:slow(delta)
    if (currentVelocity > minFloorVelocity) then
      local newVelocity = currentVelocity - velocityRatio * delta

      if (newVelocity < minFloorVelocity) then
        currentVelocity = minFloorVelocity
      else
        currentVelocity = newVelocity
      end
    end

    objectsGroup:setLinearVelocity(currentVelocity*-1, 0)
  end

  function floor:hold()
  end

  if (displayGridLines == true) then
    local grid = Grid.new()
    grid.draw(group)
   end

   return floor
end

return Floor
