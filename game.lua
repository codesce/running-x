local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function goToHome()
	composer.gotoScene( "home", { time=800, effect="crossFade" } )
end

local CENTER_X = display.contentCenterX
local CENTER_Y = display.contentCenterY
local TOP_X = display.contentWidth+120
local TOP_Y = 0

local gameGroup
local uiGroup

local character

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:create( event )
  -- Code here runs when the scene is first created but has not yet appeared on screen
  local sceneGroup = self.view

  local backgroundGroup = display.newGroup()
	gameGroup = display.newGroup()
	uiGroup = display.newGroup()

  sceneGroup:insert(backgroundGroup)
	sceneGroup:insert(gameGroup)
	sceneGroup:insert(uiGroup)

  -- background
	local background = display.newRect( backgroundGroup, CENTER_X, CENTER_Y, 1400, 800)
	background.x = CENTER_X
	background.y = CENTER_Y
  background:setFillColor( 0.6 )

  local closeButton = display.newText( sceneGroup, "X", TOP_X, TOP_Y+50, native.systemFont, 60)
  closeButton:addEventListener( "tap", goToHome )

  character = display.newImage( gameGroup, "images/character.png", -50, CENTER_Y )
end


function scene:show( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is still off screen (but is about to come on screen)

	elseif ( phase == "did" ) then
		-- Code here runs when the scene is entirely on screen

	end
end


function scene:hide( event )

	local sceneGroup = self.view
	local phase = event.phase

	if ( phase == "will" ) then
		-- Code here runs when the scene is on screen (but is about to go off screen)

	elseif ( phase == "did" ) then
		-- Code here runs immediately after the scene goes entirely off screen
    composer.removeScene( "game" )
	end
end


function scene:destroy( event )

	local sceneGroup = self.view
	-- Code here runs prior to the removal of scene's view

  character:removeSelf()
  character = nil
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
