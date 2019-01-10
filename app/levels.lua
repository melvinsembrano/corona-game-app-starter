local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

 local function handleCloseBUttonTap( event )
  composer.gotoScene( "menu", "crossFade", 500 )
  return true
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

    local closeButton = display.newImageRect( "assets/images/close-button.png", 28, 28 )
    closeButton.x = 6
    closeButton.anchorX = 0
    closeButton.y = 0
    closeButton.anchorY = 1
    closeButton:addEventListener( "tap", handleCloseBUttonTap )
    sceneGroup:insert( closeButton )
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

