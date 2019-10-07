local composer = require( "composer" )
local globals = require( "globals" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local centerX = globals.centerX
local centerY = globals.centerY

local function goToGame()
  composer.gotoScene( "game", { time=800, effect="crossFade" } )
end

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen

  -- Add home background
  local background = display.newRect( sceneGroup, centerX, centerY, screenWidth, screenHeight )
  background:setFillColor( 0, 0.68, 0.8 )

  local title = display.newEmbossedText(sceneGroup, "RunningX", centerX, centerY/2, native.systemFont, 100 )
  title:setFillColor( 1 )

  local playButtonY = screenHeight - (screenHeight / 3)
  local playButton = display.newText( sceneGroup, "Start", centerX, playButtonY, native.systemFont, 42)
  playButton:addEventListener( "tap", goToGame )

end


-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen

  end
end


-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)

  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen

  end
end


-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view

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
