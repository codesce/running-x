return {
  screenWidth = display.contentWidth,
  screenHeight = display.contentHeight,
  centerX = display.contentCenterX,
  centerY = display.contentCenterY,

  level = {
    initialBlankColumns = 5
  },

  floor = {
    height = 270,
    clipObjects = true,
    marginBottom = 50,
    displayGridObjects = true
  },

  grid = {
    skew = 120,
    columnWidth = 90,
    rowCount = 5,
    displayLines = false
  },

  controls = {
    run = "s",
    slow = "a"
  },

  objects = {
    grass = "G",
    empty = "O"
  },

  character = {
    startX = 50
  }
}
