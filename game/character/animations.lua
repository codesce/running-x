-------------------------------------------------------------
------                  IDLE ANIMATION                 ------
-------------------------------------------------------------

local idleSheetData = {
  width = 100,
  height = 90,
  numFrames = 1
}

local idleImageSheet = graphics.newImageSheet( "images/character/character.png", idleSheetData )

local idleSequence = {
  name = "idle",
  sheet = idleImageSheet,
  start = 1,
  count = 1
}

-------------------------------------------------------------
------                  RUN ANIMATION                  ------
-------------------------------------------------------------

local runningSheetData = {
  width = 100,
  height = 90,
  numFrames = 5
}

local runningImageSheet = graphics.newImageSheet( "images/character/running.png", runningSheetData )

local runningSequence = {
  name = "run",
  sheet = runningImageSheet,
  start = 1,
  count = 5,
  time = 300
}

-------------------------------------------------------------
------                        OTHER                    ------
-------------------------------------------------------------

local sequences = {
  idleSequence,
  runningSequence
}

local function createSprite()
  return display.newSprite( idleImageSheet, sequences )
end

local function setSprite(name)
  sprite:setSequence(name)
end

return {
  sprites = {
    create = createSprite,
    set = setSprite
  }
}
