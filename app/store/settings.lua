local Base = require( 'store.base' )

local settings = Base:extend( "settings", {
  id = "INTEGER PRIMARY KEY",
  name = "",
  value = ""
} )
setings:addIndex( 'name' )

function settings:getValue( name )
  local value = ""
  for _, row in ipairs( self:rows( { "value" }, "name = '" .. name .. "' LIMIT 1" ) ) do
    value  = tonumber( row.value )
  end
  return value
end

function settings:setValue( name, value )
  self:updateAttribute("value", tostring( value ), "NAME = '" .. name .. "'")
end

function settings:getBgMusicStatus()
  return self:getValue( 'bg-music-status' )
end

function settings:setBgMusicStatus( value )
  return self:setValue( 'bg-music-status', value )
end

return setings

