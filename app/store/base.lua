-- SQLite Base object
-- Extracted from: Melvin Sembrano <melvinsembrano@gmail.com>

local sqlite3 = require( "sqlite3" )

local Base = {}
Base.__index = Base

function Base:extend( tablename, fields, dbFilename )
  local base = {}
  setmetatable(base, Base)
  base.tablename = tablename
  base.fields = fields
  if dbFilename then
    base.dbFilename = dbFilename
  else
    -- TODO: update default database filename
    base.dbFilename = "myapp.db"
  end
  base:setupTable()
  return base
end

function Base:open()
  local path = system.pathForFile( "myapp.db", system.DocumentsDirectory )
  self.db = sqlite3.open(path)
  return self.db
end

function Base:close()
  self.db:close()
end

function Base:setupTable()
  local arr = {}
  for key,value in pairs(self.fields) do
    table.insert(arr, key .. " " .. value)
  end
  local str = ""
  for i,v in ipairs(arr) do
    str = str .. v
    if i < #arr then
      str = str .. ","
    end
  end
  self:open()
  local tableSetup = [[CREATE TABLE IF NOT EXISTS ]] .. self.tablename .. [[ (]] .. str .. [[);]]
  self.db:exec(tableSetup)
  self:close()
end

function Base:addIndex(field, unique)
  self:open()
  local uniqueStr = ""
  if unique then
    uniqueStr = "UNIQUE"
  end
  local indexName = self.tablename .. "_" .. field
  local indexStmt = [[CREATE ]] .. uniqueStr .. [[ INDEX IF NOT EXISTS ]]  .. indexName .. [[ ON ]] .. self.tablename .. [[(]] .. field .. [[)]] .. [[;]]
  print( indexStmt )
  self.db:exec( indexStmt )
  self:close()
end

local function wrapValue(value)
  if type(value) == "string" then
    return [[']] .. value:gsub("'", "''") .. [[']]
  else
    return value
  end
end

function Base:insert(attributes, db)
  local fields, values = "", ""
  for key,value in pairs(attributes) do
    if fields ~= "" then
      fields = fields .. ", "
      values = values .. ", "
    end
    fields = fields .. key
    values = values .. wrapValue(value)
  end
  local sql = [[INSERT INTO ]] .. self.tablename .. [[(]] .. fields ..[[) VALUES (]] .. values .. [[);]]
  if db then
    db:exec( sql )
  else
    self:open()
    self.db:exec( sql )
    self:close()
  end
end

function Base:updateAttribute(col, value, filter, db)
  local sql = "UPDATE " .. self.tablename .. " SET " .. col .. " = " .. wrapValue( value )
  if filter then
    sql = sql .. " WHERE " .. filter
  end
  sql = sql .. ";"

  print( sql )

  if db then
    db:exec( sql )
  else
    self:open()
    self.db:exec( sql )
    self:close()
  end
end

function Base:rows(cols, filter)
  local ret = {}
  local sql = "SELECT " .. table.concat( cols, ", " ) .. " FROM " .. self.tablename
  if filter then
    sql = sql .. " WHERE " .. filter
  end
  sql = sql .. ";"

  print( "SQL: " .. sql)
  local db = self:open()
  for row in db:nrows( sql ) do
    local r = {}
    for i, c in ipairs(cols) do
      r[c] = row[c]
      table.insert( ret, r )
    end
  end
  db:close()
  return ret
end

return Base
