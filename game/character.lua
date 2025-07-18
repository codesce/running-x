local globals = require( "globals" )
local Animation = require ( "game.animation.character" )

local Character = {}

function Character.new()
  local floorHeight = globals.floor.height
  local characterMovementRatio = 1.3  -- how fast does the character move up and down
  local currentCharacterPosition = 0  -- y-coordinate of character
  local characterBottomOffset = 8     -- caused by bottom of image having 8 pixels of space
  local sprite                        -- the displayed character image

  sprite = Animation.new()

  -- this is the function that moves the character along the Y axis
  function sprite:touch(event)
    local phase = event.phase

    if ("began" == phase) then
      currentCharacterPosition = event.y

    elseif ("moved" == phase) then
      local newPosition = sprite.y + ((event.y - currentCharacterPosition) * characterMovementRatio)

      -- check bounds and force character to stay on floor area
      if (newPosition > characterBottomOffset and (newPosition < floorHeight+characterBottomOffset)) then
        sprite.y = newPosition
      end

      currentCharacterPosition = event.y

    elseif ("ended" == phase or "cancelled" == phase) then
      currentCharacterPosition = sprite.y
      display.currentStage:setFocus(nil)
    end

    return true -- prevents touch propagation to underlying objects
  end

  function sprite:run()
    sprite:setSequence("run")
    sprite:play()
  end

  function sprite:slow()
    sprite:pause()
  end

  function sprite:add(group, x, y)
    sprite.anchorX = 0
    sprite.anchorY = 1
    sprite.x = x
    sprite.y = y

    group:insert(sprite)

    sprite:play()
  end

  return sprite
end

return Character
