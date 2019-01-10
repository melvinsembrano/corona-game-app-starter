local Base = require( 'store.base' )
local logger = require( 'lib.logger' )

local settings = Base:extend( "settings", {
  id = "INTEGER PRIMARY KEY",
  name = "",
  value = ""
} )
settings:addIndex( 'name' )

function settings:getValue( name )
  local value = nil
  for _, row in ipairs( self:rows( { "value" }, "name = '" .. name .. "' LIMIT 1" ) ) do
    value  = row.value
  end
  return value
end

function settings:setValue( name, value )
  self:updateAttribute("value", tostring( value ), "name = '" .. name .. "'")
end

function settings:getBgMusicStatus()
  local value = self:getValue( "bg-music-status" )
  if value == nil then
    value = "on"
    self:insert( {
      name = "bg-music-status",
      value = value
    } )
  end
  return value == "on"
end

function settings:setBgMusicStatus( value )
  local saveValue = value and "on" or "off"
  return self:setValue( "bg-music-status",  saveValue )
end

function settings:getFxMusicStatus()
  local value = self:getValue( "fx-music-status" )
  if value == nil then
    value = "on"
    self:insert( {
      name = "fx-music-status",
      value = value
    } )
  end
  return value == "on"
end

function settings:setFxMusicStatus( value )
  local saveValue = value and "on" or "off"
  return self:setValue( "fx-music-status",  saveValue )
end

return settings

