----------------------------------------------------------------------------------
--
-- scenetemplate.lua
--
----------------------------------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local w = display.viewableContentWidth
local h = display.viewableContentHeight

local dw = display.pixelWidth
local dh = display.pixelHeight

local r = 22

local acc = -.2

local c
local touch
local title

local function move( event )
	c.vyy = c.vyy + acc
	c.y = c.y + c.vyy

	if (math.abs(c.vyy) > 4 ) then
		acc = -acc
	end

end

local function goToGameplay( event )
	storyboard.gotoScene( "gameplay" )
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	title = display.newText("bol", w / 2, w / 2, "Infinity", 160)
	title:setFillColor(0)
	title.x = w / 2; title.y = h * .3;

	c = display.newCircle(w / 4, h / 2, r)
	c:setFillColor(0)

	c.x = w / 2; c.y = h * .65;
	c.vyy = 0
	
	touch = display.newText("play", w / 2, w / 2, "Infinity", 40)
	touch:setFillColor(0)
	touch.x = w / 2; touch.y = h * .78;

end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view

	Runtime:addEventListener( "enterFrame", move )
	touch:addEventListener( "touch", goToGameplay )
	
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	
	transition.to( title, { time = 1000, alpha = 0 })
	transition.to( c, { time = 1000, alpha = 0 })
	transition.to( touch, { time = 1000, alpha = 0 })
	Runtime:removeEventListener("enterFrame", move)
	touch:removeEventListener( "touch", goToGameplay )
	
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
	local group = self.view
	
	
end


-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------

return scene