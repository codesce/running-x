local composer = require( "composer" )
local globals = require( "globals" )
local physics = require( "physics" )
local Background = require ( "game.background" )
local Arena = require( "game.arena.arena" )
local Character = require( "game.character" )
local UI = require( "game.ui" )
local level = require( "game.level" )

local scene = composer.newScene()

physics.start()
physics.setGravity( 0, 0 )

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local controls = {
    running = globals.controls.run,
    slow = globals.controls.slow
}

-- display groups
local background
local arena
local ui

-- local game objects
local character

local function renderNextFrame()
  arena:render()
end

local function handleKeyPress(event)
  local key = event.keyName

  if (event.phase == "down") then
    if (key == controls.running) then
      arena:move()
    elseif (key == controls.slow) then
      arena:slow()
    end
  end

end

local function registerEventListeners()
  Runtime:addEventListener("enterFrame", renderNextFrame)
  background:addEventListener("touch", character)
  Runtime:addEventListener("key", handleKeyPress)
end

local function removeEventListeners()
  Runtime:removeEventListener("enterFrame", renderNextFrame)
  background:removeEventListener("touch", character)
  Runtime:removeEventListener("key", handleKeyPress)
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:create( event )
  -- Code here runs when the scene is first created but has not yet appeared on screen
  local sceneGroup = self.view

end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
    character = Character.new()
    level.create()

    background = Background.new()
    arena = Arena.new(level, character)
    ui = UI.new()

    -- TODO: should we remove these from the sceneGroup when scene is hidden?
    sceneGroup:insert(background)
    sceneGroup:insert(arena)
    sceneGroup:insert(ui)

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen
    registerEventListeners()
    arena:addPhysics()
  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)
  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen
    removeEventListeners()

    physics.pause()
    composer.removeScene( "game" )

    -- Code here runs prior to the removal of scene's view
    character = nil
    arena = nil
    ui = nil
    background = nil

    level:destroy()
  end
end

function scene:destroy( event )
  local sceneGroup = self.view

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
