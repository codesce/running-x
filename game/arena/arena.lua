local globals = require( "globals" )
local utils = require ( "utils" )
local physics = require( "physics" )
local Floor = require ( "game.arena.floor" )

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local floorHeight = globals.floor.height
local floorMarginBottom = globals.floor.marginBottom
local clipFloorObjects = globals.floor.clipObjects

local Arena = {}

function Arena.new(levelIn, characterIn)
  -- this should be responsible for the display groups and rendering the floor + tiles + objects
  local floorGroup = display.newGroup()
  local floorObjectsGroup = display.newGroup()
  local gameObjectsGroup = display.newGroup()

  local character = characterIn
  local level = levelIn
  local floor = Floor.new(floorGroup, floorObjectsGroup, level)

  local group

  if (clipFloorObjects) then
    group = display.newContainer(screenWidth, screenHeight)
  else
    group = display.newGroup()
  end

  group.anchorX = 0
  group.anchorY = 0
  group.anchorChildren = false
  group:insert(floorGroup)
  group:insert(floorObjectsGroup)
  group:insert(gameObjectsGroup)

  -- set these groups to all have the same (x,y) start point
  floorGroup.x = 0
  floorGroup.y = ((screenHeight - floorHeight) - floorMarginBottom)
  utils.copyCoordinates(floorGroup, floorObjectsGroup)
  utils.copyCoordinates(floorGroup, gameObjectsGroup)

  character:add(gameObjectsGroup, globals.character.startX, floorHeight/2)

  function group:render()
    floor:render()
  end

  function group:move()
    character:run()
    floor:move()
  end

  function group:slow()
    character:slow()
    floor:slow()
  end

  function group:addPhysics()
    floorObjectsGroup.gravityScale = 0
    physics.addBody(floorObjectsGroup, "dynamic")
  end

  return group
end


return Arena
