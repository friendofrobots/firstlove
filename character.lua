-------------------------------
-- character.lua
-- requires anim8.lua
-------------------------------
-- Utils = require "utils"
local anim8 = require 'anim8'
-------------------------------
-- Character
-- Moving and non-moving characters
-------------------------------

local Character = {}

-------------------------------
-- Base Character
-------------------------------

function Character.newBase ( name, spritesheetPath )
  local spritesheet = love.graphics.newImage(spritesheetPath)
  spritesheet:setFilter("nearest", "linear")
  
  character = {
    name = name,
    sheet = spritesheet,
    grid = {},
    facingDirection = 'DOWN',
    walkAnims = {},
    activeAnim = {},
    visible = true,
    x = 1, -- on the grid
    y = 1, -- on the grid
    walking = false,
    moveDelta = 0,
    speed = 3,
    status = 'ready'
  }

  character.grid = anim8.newGrid(64, 64, character.sheet:getDimensions())
  -- Assumes a spritesheet with 4 rows, one for each walk direction, in this order
  character.walkAnims['UP'] = anim8.newAnimation(character.grid('1-9',1), 0.08)
  character.walkAnims['LEFT'] = anim8.newAnimation(character.grid('1-9',2), 0.08)
  character.walkAnims['DOWN'] = anim8.newAnimation(character.grid('1-9',3), 0.08)
  character.walkAnims['RIGHT'] = anim8.newAnimation(character.grid('1-9',4), 0.08)

  function character:faceDirection ( direction )
    if self.walkAnims[direction] then
      self.activeAnim = self.walkAnims[direction]
      self.activeAnim:gotoFrame(1)
      self.activeAnim:pause()
      self.facingDirection = direction
    else
      error ('Character -- invalid face direction')
    end
  end

  function character:walkDirection ( direction )
    if self.walkAnims[direction] then
      self.walking = true
      if direction ~= self.facingDirection then
        self:faceDirection(direction)
      end
      self.moveDelta = 1
      self.activeAnim:resume()
      if direction == 'UP' then
        self.y = self.y - 1
      elseif direction == 'LEFT' then
        self.x = self.x - 1
      elseif direction == 'DOWN' then
        self.y = self.y + 1
      elseif direction == 'RIGHT' then
        self.x = self.x + 1
      else
        error ('still wrong direction')
      end
    else
      error ('Character -- invalid walk direction')
    end
  end

  function character:jumpToLoc ( mapX, mapY )
    self.x = mapX
    self.y = mapY
    self.moveDelta = 0
  end

  function character:moveUpdate (dt)
    if self.walking then
      if self.moveDelta <=0 then
        self:jumpToLoc(self.x, self.y)
        self.walking = false
        self.activeAnim:pause()
      else
        self.moveDelta = self.moveDelta - dt * self.speed
      end
    end
  end

  function character:draw()
    love.graphics.setColor(255,255,255,255)
    local viewX, viewY = mapData:mapToView(self.x, self.y)
    local windowX = (viewX - 1) * 32 - 16
    local windowY = (viewY - 1) * 32 - 32

    if self.moveDelta > 0 then
      if self.facingDirection == 'UP' then
        windowY = windowY + self.moveDelta * 32
      elseif self.facingDirection == 'LEFT' then
        windowX = windowX + self.moveDelta * 32
      elseif self.facingDirection == 'DOWN' then
        windowY = windowY - self.moveDelta * 32
      elseif self.facingDirection == 'RIGHT' then
        windowX = windowX - self.moveDelta * 32
      else
        error ('incorrect direction in self.facingDirection')
      end
    end

    if self.visible then
      self.activeAnim:draw(self.sheet, math.floor(windowX), math.floor(windowY))
    end
  end

  function character:update( dt )
    self.activeAnim:update(dt)
    self:moveUpdate(dt)
  end

  function character:updateTurn()
    self.status = 'ready'
    -- Manage cooldowns
  end

  function character:performMove( moveNumber )
    -- lookup move in the table and execute it
    return false -- if move not ready, true if executed
  end


  character:faceDirection(character.facingDirection)
  return character
end

-------------------------------
-- Player Character
-- Extends Base Character
-- Implements Move, MoveQueue methods
-- and the walk animations
-------------------------------

function Character.newAI( name, spritesheetPath )
  local character = Character.newBase ( name, spritesheetPath )

  

  return character
end
--]]
return Character
