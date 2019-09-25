local composer = require( "composer" )
local globals = require("globals")

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local function goToHome()
	composer.gotoScene( "home", { time=800, effect="crossFade" } )
end

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight

local topX = 1200
local topY = 0
local floorHeight = 500

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
	local background = display.newRect( backgroundGroup, globals.centerX, globals.centerY, screenWidth, screenHeight )
  background:setFillColor( 0.6 )

  local floorMovementY = (screenHeight - floorHeight) / 2

  -- arena floor
  local floor = display.newRect( gameGroup, globals.centerX, globals.centerY+floorMovementY, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
  floor:setStrokeColor( 1, 0, 0 )
  floor.strokeWidth = 5

  character = display.newImage( gameGroup, "images/character.png", -50, globals.centerY )

  -- TODO: should probably put the close button on a different group to the base group?
  local closeButton = display.newText( sceneGroup, "X", topX-20, topY, native.systemFont, 60)
  closeButton.anchorX = 1
  closeButton.anchorY = 0
  closeButton:addEventListener( "tap", goToHome )
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
