local globals = require( "globals" )

local floorHeight = globals.floor.height

local imageStandingPath = "images/character/stationary.png"
local imageRunningPath = "images/character/running.png"

local runningSheetOptions = {
    width = 100,
    height = 90,
    numFrames = 5
}

local runningSequence = {
    {
        name = "run",
        start = 1,
        count = 5,
        time = 300,
        loopCount = 0,
        loopDirection = "forward"
    }
}

-- how fast does the character move up and down
local characterMovementRatio = 1.3
-- y-coordinate of character
local currentCharacterPosition = 0
 -- caused by bottom of image having 8 pixels of space
local characterBottomOffset = 8

local character


local function run()
  character:play()
end

local function stop()
  character:pause()
end

local function init(group, x, y)
  local runningImageSheet = graphics.newImageSheet( imageRunningPath, runningSheetOptions )
  local imageRunning = display.newSprite( runningImageSheet, runningSequence )

  character = imageRunning

  character.anchorX = 0
  character.anchorY = 1
  character.x = x
  character.y = y

  group:insert(character)
end

-- this is the function that moves the character along the Y axis
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
  display.remove(imageRunning)
  character = nil
  imageRunning = nil
end


return {
  init = init,
  move = move,
  run = run,
  stop = stop,
  destroy = destroy
}
