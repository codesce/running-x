local composer = require( "composer" )
local globals = require( "globals" )
local physics = require( "physics" )

local background = require ( "game.background" )
local floor = require( "game.floor" )
local character = require( "game.character" )
local ui = require( "game.ui" )

local floorObjectsMatrix = require( "game.level.A00001" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local floorHeight = globals.floorHeight

local backgroundGroup
local floorGroup
local floorObjectsGroup
local gameObjectsGroup
local uiGroup

local function goToHome()
  composer.gotoScene( "home", { time=800, effect="crossFade" } )
end

local function registerEventListeners()
  backgroundGroup:addEventListener('touch', character.move)
  ui.getCloseButton():addEventListener('tap', goToHome)
end

local function moveFloor(event)
  floorObjectsGroup:setLinearVelocity(-300, 0)
end

local function copyCoordinates (object1, object2)
  object2.x = object1.x
  object2.y = object1.y
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

  sceneGroup:insert(backgroundGroup)
  sceneGroup:insert(floorGroup)
  sceneGroup:insert(floorObjectsGroup)
  sceneGroup:insert(gameObjectsGroup)
  sceneGroup:insert(uiGroup)

  -- set these groups to all have the same (x,y) start point
  floorGroup.x = 0
  floorGroup.y = (screenHeight - floorHeight)
  copyCoordinates(floorGroup, floorObjectsGroup)
  copyCoordinates(floorGroup, gameObjectsGroup)

  background.init(backgroundGroup)
  floor.init(floorGroup)
  character.init(gameObjectsGroup, 0, floorHeight/2)
  ui.init(uiGroup)
end


function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
    registerEventListeners()
    floor.render(floorObjectsGroup, floorObjectsMatrix)
  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen
    physics.start()
    physics.addBody(floorObjectsGroup, 'dynamic')

    floorObjectsGroup.gravityScale = 0
    --timer.performWithDelay( 1000, moveFloor )
  end
end


function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)
  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen
    physics.pause()
    composer.removeScene( "game" )
  end
end


function scene:destroy( event )
  local sceneGroup = self.view

  -- Code here runs prior to the removal of scene's view
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
