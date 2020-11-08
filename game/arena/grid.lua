local globals = require( "globals" )

local floorHeight = globals.floor.height
local screenWidth = globals.screenWidth

local lineXOffset = globals.grid.skew --how far to the right the line goes in a diagonal direction
local xGap = globals.grid.columnWidth -- space between grid lines
local gridRowCount = globals.grid.rowCount  -- number of lines going across the screen
local yGap = (floorHeight / gridRowCount)  --gap between these lines

local function draw(group)
  local lineX = 0

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

    for i=1, gridRowCount-1 do
      drawLine(0, lineY, screenWidth, lineY)
      lineY = lineY + yGap
    end
  end

  drawVerticalLines()
  drawHorizontalLines()
end

local function getCoordinates(xGridPosition, yGridPosition)
  local xPosition = xGridPosition+1
  local yPosition = yGridPosition-1

  local x = (xGap * xPosition) + ((lineXOffset / gridRowCount) * yPosition)
  local y = yGap * yPosition

  return { x = x, y = y }
end

return {
  draw = draw,
  getCoordinates = getCoordinates,
  xGap = xGap,
  yGap = yGap,
  lineXOffset = lineXOffset,
  gridRowCount = gridRowCount
}
