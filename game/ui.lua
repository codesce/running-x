local globals = require( "globals" )

local screenWidth = globals.screenWidth

local closeButton

local function addCloseButton(group)
  closeButton = display.newText( group, "X", screenWidth-30, 30, native.systemFont, 42)
  closeButton:setFillColor( 1 )
end

local function getCloseButton()
  return closeButton
end

local function init(group)
  addCloseButton( group )
end

local function destroy()
  closeButton = nil
end

return {
  init = init,
  getCloseButton = getCloseButton,
  destroy = destroy
}
