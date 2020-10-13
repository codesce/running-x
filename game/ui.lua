local globals = require( "globals" )
local composer = require( "composer" )

local screenWidth = globals.screenWidth

local UI = {}

function UI.new()
  local group = display.newGroup()

  local closeButton = display.newText(group, "X", screenWidth-30, 30, native.systemFont, 42)
  closeButton:setFillColor( 1 )

  local function goToHome()
    composer.gotoScene( "home", { time=800, effect="crossFade" } )
  end

  function group:finalize()
    Runtime:removeEventListener ( "tap", goToHome )
  end

  closeButton:addEventListener( "tap", goToHome )
  group:addEventListener( "finalize" )

  return group
end

return UI
