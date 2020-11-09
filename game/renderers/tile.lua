local globals = require( "globals" )
local Grid = require( "game.arena.grid" )

local grass = globals.objects.grass

local TileRenderer = {}

function TileRenderer.new()

  ---------------------------------------------
  -----             Private               -----
  ---------------------------------------------
  
  local grid = Grid.new()

  local function drawTile(group, coordinates)
    local object = display.newRect(group, coordinates.x, coordinates.y, grid.tileWidth, grid.tileHeight)
    object.anchorX = 0
    object.anchorY = 0
    object.path.x2 = grid.tileSkewWidth
    object.path.x3 = grid.tileSkewWidth
    object.fullWidth = grid.tileFullWidth

    return object
  end

  local function drawGrassObject(group, coordinates)
    local object = drawTile(group, coordinates)
    object:setFillColor( 0, 1, 0 )
  end

  ---------------------------------------------
  -----             Public                -----
  ---------------------------------------------

  local tiles = {}

  function tiles:render(group, tile, coordinates)
    if (tile == grass) then
      return drawGrassObject(group, coordinates)
    end
  end

  return tiles
end

return TileRenderer
