local globals = require( "globals" )

local screenWidth = globals.screenWidth
local screenHeight = globals.screenHeight
local centerX = globals.centerX
local centerY = globals.centerY

local function init(group)
  local background = display.newRect( group, centerX, centerY, screenWidth, screenHeight )
  background:setFillColor( 0.6 )
end

local function destroy()
end

return {
  init = init,
  destroy = destroy
}
