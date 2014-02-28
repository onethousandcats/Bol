-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local storyboard = require "storyboard"

local w = display.viewableContentWidth
local h = display.viewableContentHeight

local dw = display.pixelWidth
local dh = display.pixelHeight

local g = graphics.newGradient(
	{ 72, 112, 101 },
	{ 71, 60, 89 },
	"up"
	)

background = display.newRect(0, 0, dw, dh)
background:setFillColor(g)
background.x = dw/2; background.y = dh/2
background.width = dw; background.height = dh;

-- load scenetemplate.lua
storyboard.gotoScene( "menu" )

-- Add any objects that should appear on all scenes below (e.g. tab bar, hud, etc.):