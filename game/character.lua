local globals = require( "globals" )

local floorHeight = globals.floor.height

local standingAnimation = {
  imagePath = "images/character/stationary.png"
}

local runningAnimation = {
  imagePath = "images/character/running.png",
  sheetOptions = {
    width = 100,
    height = 90,
    numFrames = 5
  },
  sequence = {
    {
      name = "run",
      start = 1,
      count = 5,
      time = 300,
      loopCount = 0,
      loopDirection = "forward"
    }
  }
}

-- how fast does the character move up and down
local characterMovementRatio = 1.3

-- y-coordinate of character
local currentCharacterPosition = 0

 -- caused by bottom of image having 8 pixels of space
local characterBottomOffset = 8

-- the displayed character image
local sprite

local function run()
  sprite:play()
end

local function stop()
  sprite:pause()
end

local function init(group, x, y)
  local runningImageSheet = graphics.newImageSheet( runningAnimation.imagePath, runningAnimation.sheetOptions )
  local imageRunning = display.newSprite( runningImageSheet, runningAnimation.sequence )

  sprite = imageRunning

  sprite.anchorX = 0
  sprite.anchorY = 1
  sprite.x = x
  sprite.y = y

  group:insert(sprite)
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
  stop = stop,
  destroy = destroy
}
