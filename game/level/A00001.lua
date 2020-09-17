local globals = require( "globals" )

local G = globals.objects.grass
local O = globals.objects.empty

local tiles = {
    { O, O, O, O, O },
    { O, O, O, O, O },
    { O, O, O, O, G },
    { O, O, O, G, O },
    { O, O, G, O, O },
    { O, G, O, O, O },
    { G, O, O, O, O },
    { O, O, O, O, G },
    { O, O, O, G, O },
    { O, O, G, O, O },
    { O, G, O, O, O },
    { G, O, O, O, O },
}

return {
  tiles = tiles
}
