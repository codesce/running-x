local composer = require( "composer" )
local globals = require( "globals" )
local physics = require( "physics" )

local utils = require ( "utils" )
local background = require ( "game.background" )
local floor = require( "game.floor" )
local character = require( "game.character" )
local ui = require( "game.ui" )
local level = require( "game.level.A00001" )

local scene = composer.newScene()

physics.start()
physics.setGravity( 0, 0 )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local floorHeight = globals.floor.height
local floorMarginBottom = globals.floor.marginBottom
local clipFloorObjects = globals.floor.clipObjects

local backgroundGroup
local floorGroup
local floorObjectsGroup
local gameObjectsGroup
local uiGroup

local gameTimer

local function goToHome()
  composer.gotoScene( "home", { time=800, effect="crossFade" } )
end

local function renderNextFrame()
  floor.render()
end

local function registerEventListeners()
  backgroundGroup:addEventListener("touch", character.move)
  ui.getCloseButton():addEventListener("tap", goToHome)
  Runtime:addEventListener("enterFrame", renderNextFrame)
end

local function moveFloor(event)
  floor.move()
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:create( event )
  -- Code here runs when the scene is first created but has not yet appeared on screen
  local sceneGroup = self.view

  backgroundGroup = display.newGroup()
  floorGroup = display.newGroup()
  floorObjectsGroup = display.newGroup()
  gameObjectsGroup = display.newGroup()
  uiGroup = display.newGroup()

  local container

  if (clipFloorObjects) then
    container = display.newContainer(screenWidth, screenHeight)
  else
    container = display.newGroup()
  end

  container.anchorX = 0
  container.anchorY = 0
  container.anchorChildren = false
  container:insert(floorGroup)
  container:insert(floorObjectsGroup)
  container:insert(gameObjectsGroup)

  -- set these groups to all have the same (x,y) start point
  floorGroup.x = 0
  floorGroup.y = ((screenHeight - floorHeight) - floorMarginBottom)
  utils.copyCoordinates(floorGroup, floorObjectsGroup)
  utils.copyCoordinates(floorGroup, gameObjectsGroup)

  sceneGroup:insert(backgroundGroup)
  sceneGroup:insert(container)
  sceneGroup:insert(uiGroup)

  background.init(backgroundGroup)
  floor.init(floorGroup, floorObjectsGroup, level)
  character.init(gameObjectsGroup, 0, floorHeight/2)
  ui.init(uiGroup)
end


function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
    registerEventListeners()

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen
    physics.addBody(floorObjectsGroup, "dynamic")
    floorObjectsGroup.gravityScale = 0
    gameTimer = timer.performWithDelay( 1000, moveFloor )
  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)
  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen
    Runtime:removeEventListener("enterFrame", doThis)
    physics.pause()
    composer.removeScene( "game" )
  end
end


function scene:destroy( event )
  local sceneGroup = self.view

  -- Code here runs prior to the removal of scene's view
  Runtime:removeEventListener("enterFrame", renderNextFrame)
  backgroundGroup:removeEventListener("touch", character.move)
  timer.cancel(gameTimer)

  character:destroy()
  floor:destroy()
  ui:destroy()
  background:destroy()

  character = nil
  floor = nil
  background = nil
  ui = nil
end


-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
