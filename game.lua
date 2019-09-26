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
local floorHeight = 420

local floorGroup
local gameGroup
local uiGroup

local character


-- local anchorPoint = display.newRect(screenWidth, screenHeight, 5, 5)
-- anchorPoint:setFillColor( 0, 0, 1 )
-- display:insert(floorGroup)


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

function scene:create( event )
  -- Code here runs when the scene is first created but has not yet appeared on screen
  local sceneGroup = self.view

  local backgroundGroup = display.newGroup()
	floorGroup = display.newGroup()
	gameGroup = display.newGroup()
	uiGroup = display.newGroup()

  sceneGroup:insert(backgroundGroup)
	sceneGroup:insert(floorGroup)
	sceneGroup:insert(gameGroup)
	sceneGroup:insert(uiGroup)

  -- background
	local background = display.newRect( backgroundGroup, globals.centerX, globals.centerY, screenWidth, screenHeight )
  background:setFillColor( 0.6 )

  -- floor
	local floor = display.newRect( floorGroup, screenWidth, screenHeight, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
	floor.anchorX = 1
	floor.anchorY = 1

  -- game images
  character = display.newImage( gameGroup, "images/character.png", 100, globals.centerY )

  -- TODO: should probably put the close button on a different group to the base group?
  local closeButton = display.newText( uiGroup, "X", screenWidth-30, 30, native.systemFont, 42)
	closeButton:setFillColor( 1 )
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
