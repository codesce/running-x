local globals = require( "globals" )

local floorHeight = globals.floorHeight
local screenWidth = globals.screenWidth

-- variables for the vertical lines
local lineX = 0  -- starting point of first grid line
local lineXOffset = 150 --how far to the right the line goes in a diagonal direction
local xGap = 120 -- space between grid lines

-- variables for the horizontal lines
local yLineCount = 5  -- number of lines going across the screen
local yGap = floorHeight / yLineCount  --gap between these lines

----- DRAW GRID ----
local function drawGrid(group)
  local function drawLine(x1, y1, x2, y2)
    local line = display.newLine(group, x1, y1, x2, y2)
    line:setStrokeColor(0.9)
    line.strokeWidth = 3
  end

  local function drawVerticalLines()
    while lineX < screenWidth do
      drawLine(lineX, 0, lineX + lineXOffset, floorHeight)
      lineX = lineX + xGap
    end
  end

  local function drawHorizontalLines()
    local lineY = 0 + yGap

    for i=1, yLineCount-1 do
      drawLine(0, lineY, screenWidth, lineY)
      lineY = lineY + yGap
    end
  end

  drawVerticalLines()
  drawHorizontalLines()
end
-- END --

----- DRAW OBJECT ----
local function drawObject(group, xGridPosition, yGridPosition)
  -- translate the grid position to an (x,y) position on the grid
  local x = (xGap * xGridPosition) + ((lineXOffset / 5) * yGridPosition)
  local y = yGap * yGridPosition

  -- draw the object!
  local object = display.newRect(group, x, y, xGap, yGap)
  object.anchorX = 0
  object.anchorY = 0
  object:setFillColor( 0, 1, 0 )

  -- change corners of the rectangle so it becomes a parallelogram
  object.path.x2 = (lineXOffset / yLineCount)
  object.path.x3 = (lineXOffset / yLineCount)
end
-- END --

return {
  drawGrid = drawGrid,
  drawObject = drawObject
}
