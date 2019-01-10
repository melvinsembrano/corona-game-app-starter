-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local sounds = require( "lib.sounds" )

local scene = composer.newScene()

--------------------------------------------

-- forward declarations and other locals
local playBtn

-- 'onRelease' event listener for playBtn
local function handlePlayButtonTap()
	
	-- go to level1.lua scene
	composer.gotoScene( "level1", "crossFade", 500 )
	
	return true	-- indicates successful touch
end

local function handleSettingsButtonTap()
  composer.gotoScene( "settings", "crossFade", 500 )
  return true
end

local function handleLevelsButtonTap()
  composer.gotoScene( "levels", "crossFade", 500 )
  return true
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImageRect( "assets/images/bg.png", display.actualContentWidth, display.actualContentHeight )
	background.anchorX = 0
	background.anchorY = 0
	background.x = 0 + display.screenOriginX 
	background.y = 0 + display.screenOriginY
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "assets/images/title.png", 263, 33 )
	titleLogo.x = display.contentCenterX
	titleLogo.y = 100

  local playButton = display.newImageRect( "assets/images/play-button.png", 166, 50 )
  playButton.x = display.contentCenterX
  playButton.y = display.contentCenterY
  playButton:addEventListener( "tap", handlePlayButtonTap )

	local levelsButton = display.newImageRect( "assets/images/levels-button.png", 166, 50 )
  levelsButton.x = display.contentCenterX
  levelsButton.y = display.contentCenterY + 70
  levelsButton:addEventListener( "tap", handleLevelsButtonTap )

	local settingsButton = display.newImageRect( "assets/images/settings-button.png", 166, 50 )
  settingsButton.x = display.contentCenterX
  settingsButton.y = display.contentCenterY + 140
  settingsButton:addEventListener( "tap", handleSettingsButtonTap )


	-- all display objects must be inserted into group
	sceneGroup:insert( background )
	sceneGroup:insert( titleLogo )
	sceneGroup:insert( playButton )
	sceneGroup:insert( levelsButton )
	sceneGroup:insert( settingsButton )

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.

    -- play background music if not yet playing
    sounds.playBackgroundSound()

	end	
end

function scene:hide( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene
