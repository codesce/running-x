local globals = require( "globals" )

local G = globals.objects.grass
local O = globals.objects.empty

-- return {
--   { O, O, O, O, O, O, O, G, G, G, O, O, O, O, O, O, O, O, O, O, O, O, O, G, O, O, G, O, O, G, O, O, O, O, O, G, O, O, O, G },
--   { O, O, O, O, O, O, O, O, O, O, O, O, G, G, G, G, G, O, O, O, O, G, O, G, O, O, G, O, O, G, O, O, O, G, O, O, O, O, O, G },
--   { O, O, O, O, G, O, O, G, O, O, O, G, O, O, O, O, O, G, O, O, O, G, O, G, O, O, G, O, O, G, O, G, O, O, O, O, G, G, G, G },
--   { O, O, O, O, O, O, O, O, O, O, G, O, O, O, O, O, O, O, G, O, O, G, O, G, O, O, G, O, O, G, O, O, O, O, G, O, O, O, O, G },
--   { O, O, O, O, O, O, O, G, G, G, O, O, O, O, O, O, O, O, O, O, O, O, O, G, O, O, G, O, O, G, O, O, O, O, O, G, O, O, O, G },
-- }

local tiles = {
  { O,O,O,O,G,O,O },
  { O,O,O,G,O,O,O },
  { O,O,G,O,O,O,O },
  { O,O,O,G,O,O,O },
  { O,O,O,O,G,O,O },
}

return {
  tiles = tiles
}
