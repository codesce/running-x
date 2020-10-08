local globals = require( "globals" )
local animations = require ( "game.character.animations" )

local floorHeight = globals.floor.height

-- how fast does the character move up and down
local characterMovementRatio = 1.3

-- y-coordinate of character
local currentCharacterPosition = 0

 -- caused by bottom of image having 8 pixels of space
local characterBottomOffset = 8

-- the displayed character image
local sprite

---------------------------------------------
-----             Public                -----
---------------------------------------------

local function init(group, x, y)
  sprite = animations.sprites.create()

  sprite.anchorX = 0
  sprite.anchorY = 1
  sprite.x = x
  sprite.y = y

  group:insert(sprite)

  sprite:play()
end


-- this is the function that moves the character along the Y axis
local function move(event)
  local phase = event.phase

  if ("began" == phase) then
    currentCharacterPosition = event.y

  elseif ("moved" == phase) then
    local newPosition = sprite.y + ((event.y - currentCharacterPosition) * characterMovementRatio)

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

local function run()
  sprite:setSequence("run")
  sprite:play()
end

local function slow()
  sprite:pause()
end

local function destroy()
  display.remove(sprite)
  display.remove(imageRunning)
  sprite = nil
  imageRunning = nil
end


return {
  init = init,
  move = move,
  run = run,
  slow = slow,
  destroy = destroy
}
