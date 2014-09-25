-------------------------------
-- Load
-------------------------------

function love.load()
  madeScreenshot = false

  love.keyboard.setKeyRepeat( true )

  love.mouse.setVisible(false)
  love.mouse.setGrabbed(true)
  love.mouse.setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

  MapData = require "map"
  mapData = MapData.new ("Assets/", "testmap")

  -------------------------------
  -- Player Rig
  -------------------------------
  Character = require "character"
  felf = Character.newBase("Assets/felf.png")
  local p1Spawn = mapData:getObject("p1Spawn")
  felf:jumpToLoc(p1Spawn.x, p1Spawn.y)


  walkTimer = {
    walking = false,
    character = nil,
    path_iter = nil
  }
  function walkTimer:check( dt )
    if self.walking and self.path_iter then
      if not self.character.walking then
        walkPath(self.character, self.path_iter)
      end
    end
  end

  function walkPath( character, path_iter )
    walkTimer.walking = true
    local node, count = path_iter()
    if node then
      if node.x ~= character.x then
        if node.x > character.x then
          character:walkDirection('RIGHT')
        else
          character:walkDirection('LEFT')
        end
      elseif node.y ~= character.y then
        if node.y > character.y then
          character:walkDirection('DOWN')
        else
          character:walkDirection('UP')
        end
      else
        error('walkPath -- walking to same place?')
      end
      walkTimer.character = character
      walkTimer.path_iter = path_iter
    else
      walkTimer.character.activeAnim:gotoFrame(1)
      walkTimer.character = nil
      walkTimer.path_iter = nil
      walkTimer.walking = false
    end
  end

  -------------------------------
  -- Cursor
  -------------------------------  
  cursor = {
    image = love.graphics.newImage("Assets/cursors.png"),
    quads = {},
    lastX = 1,
    lastY = 1,
    reachable = false
  }
  cursor.quads['active'] = love.graphics.newQuad(0, 0, 32, 32, cursor.image:getDimensions())
  cursor.quads['inactive'] = love.graphics.newQuad(32, 0, 32, 32, cursor.image:getDimensions())

  function cursor:draw( x, y )
    local gridX = math.ceil(x / mapData.tilewidth)
    local gridY = math.ceil(y / mapData.tileheight)
    if gridX ~= self.lastX or gridY ~= self.lastY then
      local mapX, mapY = mapData:viewToMap(gridX, gridY)
      if mapX > 0 and mapX <= mapData.width and mapY > 0 and mapY <= mapData.height then
        local path, length = mapData.jumper.finder:getPath(felf.x, felf.y, mapX, mapY)
        if path and length <= 6 then
          self.reachable = true
        else
          self.reachable = false
        end
      else
        self.reachable = false
      end
    end
    local cursorType = self.reachable and "active" or "inactive"
    love.graphics.draw(self.image, self.quads[cursorType], (gridX - 1) * 32, (gridY - 1) * 32)
    self.lastX = gridX
    self.lastY = gridY
  end

  scrollMove = 0

  --[[
  -------------------------------
  -- Turn Manager
  -- Keep track of whose turn it is
  -- which turn in the battle
  -------------------------------
  turnManager = {
    turnCount = 1,
    turnOrder = {},
  }

  -------------------------------
  -- Battle UI
  -------------------------------
  battleUI = {
    elements = {},
  }

  function battleUI:addElement( x, y, sizeX, sizeY, )

  end
  --]]


end

-------------------------------
-- Draw
-------------------------------

function love.draw()
  mapData:draw()

  -- Draw cursor
  local cursorX, cursorY = love.mouse.getPosition()
  cursor:draw(cursorX, cursorY)

  if felf.visible then
    felf:draw()
  end

  --[[
  -- Draw collision
  love.graphics.setColor(255,0,128,80)
  for j,row in ipairs(mapData.collisionMatrix) do
    for i,value in ipairs(row) do
      if value ~= 0 then
        local cx, cy = mapData:mapToView(i,j)
        love.graphics.rectangle("fill", cx*32,cy*32,32,32)
      end
    end
  end
  love.graphics.setColor(255,255,255)
  --]]

  if not madeScreenshot then
    madeScreenshot = true
    makeScreenshot()
  end
end

-------------------------------
-- Update
-------------------------------
function love.update( dt )
  if scrollMove > 0 then
    scrollMove = scrollMove - dt
  end

  felf:update(dt)
  walkTimer:check(dt)

  -- Mouse scrolling
  local x, y = love.mouse.getPosition( )
  local gridX = math.ceil(x / mapData.tilewidth)
  local gridY = math.ceil(y / mapData.tileheight)

  if gridY <= 1 and scrollMove <= 0 then
    mapData:move(0, -1)
    scrollMove = .3
  end
  if gridY >= mapData.view.height and scrollMove <= 0 then
    mapData:move(0, 1)
    scrollMove = .3
  end
  if gridX <= 1 and scrollMove <= 0 then
    mapData:move(-1, 0)
    scrollMove = .3
  end
  if gridX >= mapData.view.width and scrollMove <= 0 then
    mapData:move(1, 0)
    scrollMove = .3
  end
end

function love.quit()
  makeScreenshot()
end

function makeScreenshot()
  love.graphics.newScreenshot():encode('firstlove' .. os.time() .. '.png', 'png')
end

function love.keypressed(key)
  if key == "up" then
    mapData:move(0, -1)
  end
  if key == "down" then
    mapData:move(0, 1)
  end
  if key == "left" then
    mapData:move(-1, 0)
  end
  if key == "right" then
    mapData:move(1, 0)
  end


  if key == 'f2' then
    makeScreenshot()
  end
end

function love.mousepressed( x, y, button )
  
  if button == "l" and not walkTimer.walking then
    local mapX,mapY = mapData:viewToMap(math.ceil(x / mapData.tilewidth), math.ceil(y / mapData.tileheight))
    local path, length = mapData.jumper.finder:getPath(felf.x, felf.y, mapX, mapY)
    if path and length > 0 and length <= 6 then
      path_iter = path:iter()
      path_iter()
      walkPath(felf, path_iter)
    end
  end

end



