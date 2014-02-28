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

local circle
local wall
local topWall
local acceleration = .3
local wallSpeed = 4

local alive = true
local isFirst = true

local r = 12

local score = 0

local function detectCollision( event )
	if ( (circle.x >= wall.x - (wall.width / 2) - r) and (circle.x <= wall.x + (wall.width / 2) + r) ) then
		if ((circle.y <= topWall.y + (topWall.height / 2) + r) or (circle.y >= wall.y - (wall.height / 2) - r)) then
			print("bang")
			alive = false
			acceleration = (math.abs(acceleration))
		end 
	end

	if (circle.y >= h - r or circle.y <= r) then
		print("out of bounds")
	end
end

local function fall( event )
	detectCollision()

	wallSpeed = wallSpeed + .001
	circle.vy = circle.vy + acceleration
	circle.y = circle.y + circle.vy

	wall.x = wall.x - wallSpeed
	topWall.x = topWall.x - wallSpeed

	if ( wall.x < -20 ) then
		wall.x = w + 20
		topWall.x = w + 20

		local newHeight = ( dh / 2 ) + math.random( -(dh/6 - 20), (dh/6 - 20) )
		wall.y = newHeight - 40
		topWall.y = wall.y - wall.height - 80

		if (alive == true) then
			score = score + 1
			scoreTxt.text = score

			if (score == 100) then
				scoreTxt.fontSize = 100
			end

			if (score == 1000) then
				scoreTxt.fontSize = 50
			end
		end
		
		print(score)
	end

end

local function touched( event )
	
	if (isFirst == true) then
		isFirst = false
		return
	end

	if ( (event.phase == "began" or event.phase == "ended" or event.phase == "cancelled") and alive == true ) then
		acceleration = -acceleration
	end
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	local newHeight = ( dh / 3 ) + math.random( -(dh/8 - 20), (dh/8 - 20) )

	circle = display.newCircle(w / 4, h / 2, r)
	wall = display.newRect(w + 60, newHeight - 40, 30, 400)
	topWall = display.newRect(w + 60, newHeight - 540, 30, 400)

	scoreTxt = display.newText(score, w / 4, h * .2, native.systemFont, 200)
	scoreTxt:setFillColor(0)
	scoreTxt.alpha = .2

	circle:setFillColor(0)
	wall:setFillColor(0)
	topWall:setFillColor(0)	

	circle.vy = 0
end


-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	Runtime:addEventListener( "enterFrame", fall )
	Runtime:addEventListener( "touch", touched )
	
	acceleration = .3
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	

	
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