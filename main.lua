-------------------------------
-- Load
-------------------------------

function love.load()
  madeScreenshot = false

  love.keyboard.setKeyRepeat( true )

  love.mouse.setVisible(false)
  love.mouse.setGrabbed(true)
  love.mouse.setPosition(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)

  droidSansFonts = {
    tiny = {},
    scriptsize = {},
    footnotesize = {},
    small = love.graphics.newFont( 'Assets/Fonts/Droid_Sans/DroidSans-Bold.ttf', 15),
    normalsize = {},
    large = {},
    Large = love.graphics.newFont( 'Assets/Fonts/Droid_Sans/DroidSans-Bold.ttf', 45),
    LARGE = {},
    huge = {},
    Huge = {}
  }

  MapData = require "map"
  mapData = MapData.new ("Assets/", "testmap")

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

  function cursor:draw( x, y, state )
    local gridX = math.ceil(x / mapData.tilewidth)
    local gridY = math.ceil(y / mapData.tileheight)

    local cursorColor = {127,127,127,255}
    if state == 'READY' then
      if gridX ~= self.lastX or gridY ~= self.lastY then
        self.reachable = false
        local mapX, mapY = mapData:viewToMap(gridX, gridY)
        if mapX > 0 and mapX <= mapData.width and mapY > 0 and mapY <= mapData.height then
          local active = turnManager.activeCharacter
          local path, length = mapData.jumper.finder:getPath(active.x, active.y, mapX, mapY)
          if path and length <= 6 then
            self.reachable = true
          end
        end
      end
      if self.reachable then
        cursorColor = {0, 255, 255, 255}
      else
        cursorColor = {255, 0, 0, 255}
      end
    elseif state == 'ACTION' then
      cursorColor = {255, 127, 0, 255}
    end
    love.graphics.setColor(cursorColor)
    love.graphics.rectangle("line", (gridX - 1) * 32, (gridY - 1) * 32, 32, 32)
    cursorColor[4] = 63
    love.graphics.setColor(cursorColor)
    love.graphics.rectangle("fill", (gridX - 1) * 32, (gridY - 1) * 32, 32, 32)

    self.lastX = gridX
    self.lastY = gridY
  end

  scrollMove = 0

  -------------------------------
  -- Turn Manager
  -- Keep track of whose turn it is
  -- which turn in the battle
  -------------------------------
  turnManager = {
    turnCount = 0,
    activeCharacter = '',
    phase = 1,
    transitionTimer = 2
  }

  function turnManager:characterRests( character )
    character.status = 'exhausted'
    local allCharactersExhausted = true
    if self.phase == 1 then
      for i, char in ipairs(characterManager.players) do
        if char.status ~= 'exhausted' then
          allCharactersExhausted = false
          break
        end
      end
    elseif self.phase == 2 then
      for i, char in ipairs(characterManager.players) do
        if char.status ~= 'exhausted' then
          allCharactersExhausted = false
          break
        end
      end
    else
      error ('invalid phase '.. self.phase)
    end

    if allCharactersExhausted then
      print('next phase')
      self:nextPhase()
    end
  end

  function turnManager:getCursorState()
    if not self:ready() then
      return 'INACTIVE'
    end
    if self.activeCharacter.status == 'ready' then
      return 'READY'
    elseif self.activeCharacter.status == 'walked' then
      return 'ACTION'
    else
      return 'INACTIVE'
    end
  end

  function turnManager:nextPhase()
    if self.phase == 1 then
      self.phase = 2
      characterManager:newPhase('enemies')
      self.activeCharacter = characterManager.enemies[1]
      aiManager:yourTurn()
    else
      self.phase = 1
      characterManager:newPhase('players')
      self.activeCharacter = characterManager.players[1]
      self:newTurn()
    end
    self.transitionTimer = 2
  end

  function turnManager:newTurn()
    self.turnCount = self.turnCount + 1
    for i, character in ipairs(characterManager.players) do
      character:updateTurn()
      character.status = 'ready'
    end
    self.activeCharacter = characterManager.players[1]
  end

  function turnManager:ready()
    if self.transitionTimer > 0 or self.walkTimer.walking then
      return false
    else
      return true
    end
  end

  function turnManager:draw()
    love.graphics.setColor(255,127,0,255)
    if self.transitionTimer > 0 then
      local announcement = ''
      if self.phase == 1 then
        announcement = "Your Turn"
      else
        announcement = "Enemy Turn"
      end
      love.graphics.setFont(droidSansFonts['Large'])
      if self.transitionTimer < 1 then
        love.graphics.print(announcement, 300, 300)
      else
        love.graphics.print(announcement, 300 - (self.transitionTimer - 1) * 500, 300)
      end
    else
      love.graphics.setFont(droidSansFonts['small'])
      love.graphics.print("Turn " .. self.turnCount, 650, 20)
    end

    love.graphics.setColor(0,255,255,255)
    love.graphics.setFont(droidSansFonts['small'])
    if self.activeCharacter then
      love.graphics.print(self.activeCharacter.name .. " :: " .. self.activeCharacter.status, 20, 20)
    else
      love.graphics.print("No Active Character", 20, 20)
    end
  end

  function turnManager:update(dt)
    if self.transitionTimer <= 0 then
      self.transitionTimer = 0
    else
      self.transitionTimer = self.transitionTimer - dt
    end

    self:checkWalkTimer(dt)
  end

  -- Turn Manager Actions
 turnManager.walkTimer = {
    walking = false,
    path_iter = nil
  }
  function turnManager:checkWalkTimer( dt )
    if self.walkTimer.walking and self.walkTimer.path_iter then
      if not self.activeCharacter.walking then
        self:walkPath(self.walkTimer.path_iter)
      end
    end
  end

  function turnManager:walkPath( path_iter )
    self.walkTimer.walking = true
    local node, count = path_iter()
    if node then
      if node.x ~= self.activeCharacter.x then
        if node.x > self.activeCharacter.x then
          self.activeCharacter:walkDirection('RIGHT')
        else
          self.activeCharacter:walkDirection('LEFT')
        end
      elseif node.y ~= self.activeCharacter.y then
        if node.y > self.activeCharacter.y then
          self.activeCharacter:walkDirection('DOWN')
        else
          self.activeCharacter:walkDirection('UP')
        end
      else
        error('walkPath -- walking to same place?')
      end
      self.walkTimer.path_iter = path_iter
    else
      self.activeCharacter.activeAnim:gotoFrame(1)
      self.walkTimer.path_iter = nil
      self.walkTimer.walking = false
      self.activeCharacter.status = 'walked'
    end
  end

  function turnManager:walkTo( mapX, mapY )
    if self.activeCharacter.status == 'ready' then
      local path, length = mapData.jumper.finder:getPath(self.activeCharacter.x, self.activeCharacter.y, mapX, mapY)
      if path and length > 0 and length <= 6 then
        path_iter = path:iter()
        path_iter()
        self:walkPath(path_iter)
      end
    end
  end

  function turnManager:rest()
    if self.activeCharacter.status ~= 'exhausted' then
      self:characterRests(self.activeCharacter)
    end
  end

  function turnManager:performMove( key )
    if key == " " then
      self:rest()
    end
  end
  --[[
  -------------------------------
  -- Battle UI
  -------------------------------
  battleUI = {
    elements = {},
  }

  function battleUI:addElement( x, y, sizeX, sizeY, )

  end
  --]]

  -------------------------------
  -- Character Manager
  -------------------------------
  Character = require "character"

  characterManager = {
    players = {},
    enemies = {},
  }

  function characterManager:allCharacters()
    local state = 0
    local p_iter, ptable, pvar = pairs(self.players)
    local e_iter, etable, evar = pairs(self.enemies)
    local which_iter = function( t, var )
      if state == 1 then
        return e_iter(etable, var)
      end
      local var1 = p_iter(t, var)
      if var1 == nil then
        state = 1
        return e_iter(etable, evar)
      end
      return p_iter(t, var)
    end
    return which_iter, ptable, pvar
  end

  function characterManager:loadCharacter(name, spritesheetPath, spawnName, team)
    local character = Character.newBase(name, spritesheetPath)
    local spawn = mapData:getObject(spawnName)
    character:jumpToLoc(spawn.x, spawn.y)
    if team == 'player' then
      table.insert(self.players, character)
    elseif team == 'enemy' then
      table.insert(self.enemies, character)
    else
      error ('Invalid team name')
    end
    return character
  end

  function characterManager:draw()
    for i, character in ipairs(self.players) do
      character:draw()
    end
    for i, character in ipairs(self.enemies) do
      character:draw()
    end
  end

  function characterManager:update( dt )
    for i, character in ipairs(self.players) do
      character:update(dt)
    end
    for i, character in ipairs(self.enemies) do
      character:update(dt)
    end
  end

  function characterManager:newPhase( team )
    if team == 'players' then
      for i, player in ipairs(self.players) do
        player:updateTurn()
      end
    elseif team == 'enemies' then
      for i, enemy in ipairs(self.enemies) do
        enemy:updateTurn()
      end        
    end
  end

  characterManager:loadCharacter('felf', "Assets/felf.png", "p1Spawn", 'player')
  characterManager:loadCharacter('enemy1', "Assets/malesoldiernormal.png", "npc1Spawn", 'enemy')

  aiManager = {
    sleepTimer = 0,
    acting = false,
    character = nil
  }

  function aiManager:yourTurn()
    self:takeTurn(turnManager.activeCharacter)
  end

  function aiManager:takeTurn( character )
    local path = nil
    local length = 0
    local x, y = 0,0
    while not path and length < 6 do
      x = math.random(-6,6)
      local n = 6 - math.abs(x)
      y = math.random(-n,n)

      path, length = mapData.jumper.finder:getPath(character.x, character.y, character.x + x, character.y + y)
    end

    self.acting = true
    self.character = character
    turnManager:walkTo( x, y )
  end

  function aiManager:update(dt)
    if self.sleepTimer <= 0 then
      self.sleepTimer = 0
    else
      self.sleepTimer = self.sleepTimer - dt
    end

    if self.acting then
      if not self.character.walking then
        turnManager:rest()
        self.acting = false
        self.character = nil
      end
    end
  end

  turnManager:newTurn()

end

-------------------------------
-- Draw
-------------------------------

function love.draw()
  love.graphics.setColor(255,255,255,255)
  mapData:draw()

  -- Draw cursor
  local cursorX, cursorY = love.mouse.getPosition()
  cursor:draw(cursorX, cursorY, turnManager:getCursorState())

  characterManager:draw()
  turnManager:draw()

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

  characterManager:update(dt)
  turnManager:update(dt)

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

  if key == '1' or key == '2' or key == '3' or key == '4' or key == " " then
    if turnManager:ready() then
      turnManager:performMove( key )
    end
  end

  if key == 'f2' then
    makeScreenshot()
  end
end

function love.mousepressed( x, y, button )
  
  if button == "l" then
    if turnManager:ready() then
      local mapX,mapY = mapData:viewToMap(math.ceil(x / mapData.tilewidth), math.ceil(y / mapData.tileheight))
      turnManager:walkTo(mapX, mapY)
    end
  end

end



