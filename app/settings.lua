local composer = require( "composer" )
local widget = require( "widget" )
local settingsStore = require( "store.settings")
local sounds = require( "lib.sounds" )
local logger = require( "lib.logger" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

local function handleBgMusicSwitchRelease( event )
  settingsStore:setBgMusicStatus( event.target.isOn )
  if event.target.isOn then
    sounds.playBackgroundSound()
  else
    sounds.stopBackgroundSound()
  end
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    --
    -- display a background image
    local background = display.newImageRect( "assets/images/bg.png", display.actualContentWidth, display.actualContentHeight )
    background.anchorX = 0
    background.anchorY = 0
    background.x = 0 + display.screenOriginX
    background.y = 0 + display.screenOriginY

    sceneGroup:insert( background )

    local settingsLabel = display.newImageRect( "assets/images/text-settings.png", 111, 33 )
    settingsLabel.x = display.contentCenterX
    settingsLabel.y = 10
    sceneGroup:insert( settingsLabel )

    local yOffset = 40

    local bgMusicSwitch = widget.newSwitch( {
        style = "onOff",
        initialSwitchState = settingsStore:getBgMusicStatus(),
        onRelease = handleBgMusicSwitchRelease
    } )

    bgMusicSwitch.x = display.contentCenterX
    bgMusicSwitch.anchorY = 0
    bgMusicSwitch.y = yOffset + 60
    sceneGroup:insert( bgMusicSwitch )

    local bgMusicLabel = display.newImageRect( "assets/images/text-bg-music.png", 180, 28 )
    bgMusicLabel.x = bgMusicSwitch.x
    bgMusicLabel.y = bgMusicSwitch.y - 16
    sceneGroup:insert( bgMusicLabel )

    local fxSoundSwitch = widget.newSwitch( {
        style = "onOff",
        onRelease = handleBgMusicSwitchRelease
    } )
    fxSoundSwitch.x = display.contentCenterX
    fxSoundSwitch.anchorY = 0
    fxSoundSwitch.y = yOffset + 160
    sceneGroup:insert( fxSoundSwitch )

    local fxSoundLabel = display.newImageRect( "assets/images/text-sound-effects.png", 140, 25 )
    fxSoundLabel.x = fxSoundSwitch.x
    fxSoundLabel.y = fxSoundSwitch.y - 16
    sceneGroup:insert( fxSoundLabel )
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene

