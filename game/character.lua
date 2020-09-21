local globals = require( "globals" )

local floorHeight = globals.floor.height

local image = "images/character.png"

-- how fast does the character move up and down
local characterMovementRatio = 1.3
-- y-coordinate of character
local currentCharacterPosition = 0
 -- caused by bottom of image having 8 pixels of space
local characterBottomOffset = 8

local character

local function init(group, x, y)
  character = display.newImage( group, image, x, y )

  -- for now, we are initialising the anchor points here, but should it go here??
  character.anchorX = 0
  character.anchorY = 1
end


local function move(event)
  local phase = event.phase

  if ("began" == phase) then
    currentCharacterPosition = event.y

  elseif ("moved" == phase) then
    local newPosition = character.y + ((event.y - currentCharacterPosition) * characterMovementRatio)

    if (newPosition > characterBottomOffset and (newPosition < floorHeight+characterBottomOffset)) then
      character.y = newPosition
    end

    currentCharacterPosition = event.y
  elseif ("ended" == phase or "cancelled" == phase) then
    currentCharacterPosition = character.y
    display.currentStage:setFocus(nil)
  end

  return true -- prevents touch propagation to underlying objects
end

local function destroy()
  display.remove(character)
  character = nil
end


return {
  init = init,
  move = move,
  destroy = destroy
}
