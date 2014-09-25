-------------------------------
-- map.lua
-------------------------------
-- Tiled Importer

local MapData = {}

-------------------------------
-- loadFromFile
-- Takes the path and filename for a map
-- made in Tiled and exported to a lua format
-------------------------------
function loadFromFile ( path, filename, view )
  local tiledData = require(path .. filename)

  local mapData = {
    layers = {},
    collisionMatrix = {},
    objects = {},
    objectMatrix = {},
    width = tiledData.width,
    height = tiledData.height,
    tilewidth = 32,
    tileheight = 32,
    tileQuads = {},
    tilesetImage = {},
    view = view,
    jumper = {}
  }

  view.width = math.ceil(love.graphics.getWidth() / mapData.tilewidth / view.zoomX)
  view.height = math.ceil(love.graphics.getHeight() / mapData.tileheight / view.zoomY)


  ------------------------------
  -- Creating quads from the tileset
  -- Currently only allows for 1 tileset
  -- And doesn't consider margin or spacing
  ------------------------------
  local tileset = tiledData.tilesets[1]
  mapData.tilesetImage = love.graphics.newImage(path .. tileset.image)
  mapData.tilesetImage:setFilter("nearest", "linear")

  mapData.tileQuads[0] = love.graphics.newQuad(39 * 32, 59 * 32, 32, 32,
        mapData.tilesetImage:getDimensions()) -- Blank tile for 0 - should figure out how to just not draw this tile
  
  for i=0,mapData.tilesetImage:getWidth() / tileset.tilewidth - 1 do
    for j=0,mapData.tilesetImage:getHeight() / tileset.tileheight - 1 do
      -- tileQuads is a list where the index of the quad lines up with tiled's index in the exported map index
      mapData.tileQuads[1 + i + j * mapData.tilesetImage:getWidth() / tileset.tilewidth] = love.graphics.newQuad(i * tileset.tilewidth,
        j * tileset.tileheight, tileset.tilewidth, tileset.tileheight, mapData.tilesetImage:getDimensions())
    end
  end


  ------------------------------
  -- Now creating the layers, collision matrix, and objects table
  ------------------------------
  for layer_num,tilelayer in ipairs(tiledData.layers) do
    if tilelayer.name == 'collision' then
      -- Convert from list to 2D matrix
      local collisionMatrix = {}
      for n,value in ipairs(tilelayer.data) do
        local j = math.ceil(n / mapData.width)
        local i = n - (j-1) * mapData.width
        if not collisionMatrix[j] then
          collisionMatrix[j] = {}
        end
        collisionMatrix[j][i] = value
      end
      mapData.collisionMatrix = collisionMatrix

    elseif tilelayer.type == 'tilelayer' then
      local layer = {
        map = {},
        batch = love.graphics.newSpriteBatch(mapData.tilesetImage, mapData.view.width * mapData.view.height),
        name = tilelayer.name
      }
      
      for i=1,tilelayer.width do
        layer.map[i] = {}
      end

      local n = 1
      for j=1,tilelayer.height do
        for i=1,tilelayer.width do
          layer.map[i][j] = tilelayer.data[n]
          n = n + 1
        end
      end

      mapData.layers[layer_num] = layer

    elseif tilelayer.type == 'objectgroup' then
      -- Create object table
      for i,object in ipairs(tilelayer.objects) do
        object.x = tonumber(object.x) / mapData.tilewidth + 1
        object.y = tonumber(object.y) / mapData.tileheight + 1
        object.group = tilelayer.name
        mapData.objects[object.name] = object
        if not mapData.objectMatrix[object.x] then
          mapData.objectMatrix[object.x] = {}
        end
        mapData.objectMatrix[object.x][object.y] = object.name
      end
    end
  end

  if mapData.objects["cameraOrigin"] then
    origin = mapData.objects["cameraOrigin"]
    if mapData.width - origin.x >= mapData.view.width then
      mapData.view.x = origin.x
    else
      mapData.view.x = mapData.width - mapData.view.width
    end
    if mapData.height - origin.y >= mapData.view.height then
      mapData.view.y = origin.y
    else
      mapData.view.y = mapData.height - mapData.view.height
    end
  end

  -- Value for walkable tiles
  local walkable = 0

  -- Library setup
  local Grid = require ("jumper.grid") -- The grid class
  local Pathfinder = require ("jumper.pathfinder") -- The pathfinder class
  -- Creates a grid object
  local grid = Grid(mapData.collisionMatrix) 
  -- Creates a pathfinder object using Jump Point Search
  local myFinder = Pathfinder(grid, 'JPS', walkable)
  myFinder:setMode('ORTHOGONAL')

  mapData.jumper = {
    grid = grid,
    finder = myFinder
  }

  return mapData
end

-------------------------------
-- MapData
-- Holds map layers, collision data
-- and objects and associated methods
-------------------------------
function MapData.new ( path, filename )
  -- These are basically the camera controls. Will need to make this initializable later.
  view = { -- DEFAULTS
    x = 1,
    y = 1,
    width = 25,
    height = 19,
    zoomX = 1,
    zoomY = 1
  }
  local mapData = loadFromFile (path, filename, view)

  function mapData:getObject (objectName)
    return self.objects[objectName]
  end
  function mapData:checkForObject ( x, y )
    if self.objectMatrix[x] then
      return self.objectMatrix[x][y]
    else
      return nil
    end
  end
  function mapData:checkCollision ( x, y )
    if x < 0 or y < 0 or x > self.width - 1 or y > self.height - 1 then
      return true
    end

    objectName = self:checkForObject ( x, y )
    if objectName then
      object = self:getObject(objectName)
      if object.type == 'trigger' then
        return true
      end
    end

    i = ( (self.height - y - 1) * self.width ) + x + 1
    return self.collisionMatrix[i] ~= 0
  end

  function mapData:updateTilesetBatches()
    for n,layer in ipairs(self.layers) do

      layer.batch:bind()
      layer.batch:clear()
      for i=0, self.view.width-1 do
        for j=0, self.view.height-1 do
          layer.batch:add(self.tileQuads[layer.map[i+self.view.x][j+self.view.y]],
              i*self.tilewidth, j*self.tileheight)
       end
      end
      layer.batch:unbind()
    end
  end

  -- central function for moving the map
  function mapData:move(dx, dy)
    local oldMapX = self.view.x
    local oldMapY = self.view.y
    self.view.x = math.max(math.min(oldMapX + dx, self.width - self.view.width), 1)
    self.view.y = math.max(math.min(oldMapY + dy, self.height - self.view.height), 1)
    -- only update if we actually moved
    if math.floor(self.view.x) ~= math.floor(oldMapX) or math.floor(self.view.y) ~= math.floor(oldMapY) then
      self:updateTilesetBatches()
    end
  end

  function mapData:draw()
    for i,layer in ipairs(self.layers) do
      love.graphics.draw(layer.batch)
    end
  end

  function mapData:mapToView( mapX, mapY )
    return mapX - self.view.x, mapY - self.view.y
  end

  function mapData:viewToMap( viewX, viewY )
    return viewX + self.view.x - 1, viewY + self.view.y - 1
  end

  mapData:updateTilesetBatches()

  return mapData
end


return MapData