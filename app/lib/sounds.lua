local audio = require( "audio" )
local settingsStore = require( "store.settings" )

local backgroundMusic = audio.loadStream( "assets/sounds/bensound-sunny.mp3" )
_G.backgroundMusicChannel = -1

local sounds = {}

sounds.playBackgroundSound = function()
  if settingsStore:getBgMusicStatus() then
    if not audio.isChannelPlaying( _G.backgroundMusicChannel ) then
      _G.backgroundMusicChannel = audio.play( backgroundMusic, { channel=1, loops=-1, fadein=5000 } )
    end
  end
end

sounds.stopBackgroundSound = function()
  if audio.isChannelPlaying( _G.backgroundMusicChannel ) then
    audio.stop( _G.backgroundMusicChannel )
  end
end

return sounds
