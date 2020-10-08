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

local function create(group)
  addCloseButton( group )
end

local function destroy()
  closeButton = nil
end

return {
  create = create,
  getCloseButton = getCloseButton,
  destroy = destroy
}
