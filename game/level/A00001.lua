local globals = require( "globals" )

local G = globals.objects.grass
local O = globals.objects.empty

local tiles = {
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { O, O, G, O, O },
    { O, O, G, O, O },
    { O, O, G, O, O },
    { O, O, G, O, O },
    { O, O, G, O, O },
    { O, O, G, O, O },
    { O, O, G, O, O },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
    { G, O, O, O, G },
}

return {
  tiles = tiles
}
