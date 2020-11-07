local globals = require( "globals" )

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local centerX = globals.centerX
local centerY = globals.centerY

local Background = {}

function Background.new()
  local group = display.newGroup()

  local background = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
  background:setFillColor( 0.6 )

  return group
end

return Background
