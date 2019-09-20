-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local composer = require("composer")

-- hide status bar on most devices
display.setStatusBar( display.HiddenStatusBar )

math.randomseed( os.time() )

composer.gotoScene( "home" )
