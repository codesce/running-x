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
local currentCharacterPosition = 0
local characterBottomOffset = 8  -- caused by bottom of image having 8 pixels of space

local function moveCharacter(event)
  local phase = event.phase

  if ("began" == phase) then
		currentCharacterPosition = event.y
    display.currentStage:setFocus(backgroundGroup)
  elseif ("moved" == phase) then
		local newPosition = character.y + ((event.y - currentCharacterPosition) * 1.3)

		if (newPosition > characterBottomOffset and (newPosition < floorHeight+characterBottomOffset)) then
    	character.y = newPosition
		end

		currentCharacterPosition = event.y
  elseif ("ended" == phase or "cancelled" == phase) then
		currentCharacterPosition = character.y
    display.currentStage:setFocus(nil)
  end

  return true -- prevents touch propagation to underlying objects
end

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

	backgroundGroup:addEventListener('touch', moveCharacter)

  -- floor
	floorGroup.x = 0
	floorGroup.y = (screenHeight - floorHeight)

	local floor = display.newRect( floorGroup, 0, 0, screenWidth, floorHeight )
  floor:setFillColor( 0.8 )
	floor.anchorX = 0
	floor.anchorY = 0

  -- game images (set group 0,0 to be same as the floor)
	gameGroup.x = floorGroup.x
	gameGroup.y = floorGroup.y

  -- render character centrally (by feet!) to the floor
  character = display.newImage( gameGroup, "images/character.png", 0, floorHeight/2 )
	character.anchorX = 0
	character.anchorY = 1

  -- ui elements
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
