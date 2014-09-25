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

--[[ - non-AnAL sprites with margins and paddings
function rowOfSprites ( spritesheet, spritewidth, spriteheight, row_num, xmargin, ymargin, xpadding, ypadding )
  local numSprites = (spritesheet:getWidth() - xmargin * 2) / (spritewidth - xpadding * 2)
  
  for i=1, numSprites do
    sprites[i] = love.graphics.newQuad(xmargin + (i - 1) * (spritewidth + xpadding) + xpadding, ymargin + (row_num - 1) * (spriteheight + ypadding) + ypadding,
        spritewidth, spriteheight, spritesheet:getDimensions())
--]]

function Character.newBase ( spritesheetPath )
  local spritesheet = love.graphics.newImage(spritesheetPath)
  spritesheet:setFilter("nearest", "linear")
  
  character = {
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
    speed = 3
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
    local viewX, viewY = mapData:mapToView(self.x, self.y)
    local windowX = viewX * 32 - 16
    local windowY = viewY * 32 - 32

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

    self.activeAnim:draw(self.sheet, math.floor(windowX), math.floor(windowY))
  end

  function character:update( dt )
    self.activeAnim:update(dt)
    self:moveUpdate(dt)
  end

  character:faceDirection(character.facingDirection)
  return character
end

-------------------------------
-- Character
-- Extends Base Character
-- Implements Move, MoveQueue methods
-- and the walk animations
-------------------------------
--[[
function Character.newMoving( deck, mapData )
  local character = Character.newBase ( deck )
  character.mapData = mapData
  character.SPEED = 6
  character.WALK_FRAME_RATE = 12
  character.FRAMES_PER_STEP =  character.WALK_FRAME_RATE / character.SPEED -- should be a whole number for now

  character.moving = false
  character.lastDir = nil
  character.startFrame = 1

  character.moveQueue = Utils.Queue.new ()

  function character:walkAnim ( startFrame, dirMod )
    local walkAnim = MOAIAnimCurve.new ()
    walkAnim:reserveKeys ( self.FRAMES_PER_STEP )
    for i = 0, character.FRAMES_PER_STEP - 1, 1 do
      walkAnim:setKey ( i + 1, i / self.WALK_FRAME_RATE, dirMod + (startFrame + i) % 9, MOAIEaseType.FLAT)
    end
    self.startFrame = self.startFrame + self.FRAMES_PER_STEP
    return walkAnim
  end

  function character:addToMoveQueue ( direction )
    self.moveQueue:push( direction )
  end

  function character:checkMoveQueue ()
    local direction = ''
    if not self.moveQueue:isEmpty () then -- if on queue, move
      direction = self.moveQueue:pop ()
      if not self.moving or self.lastDir ~= direction then
        self.startFrame = 1
      end
      return self:move ( direction )
    else
      self.moving = false
      self:faceDirection ( self.lastDir )
    end
  end

  function character:move ( direction ) -- returns seekLoc action
    x , y = self.x , self.y
    local animIndex = self.directions[direction]
    if direction == 'UP' then
      y = y + 1
    elseif direction == 'LEFT' then
      x = x - 1
    elseif direction == 'DOWN' then
      y = y - 1
    elseif direction == 'RIGHT' then
      x = x + 1
    else
      error('character asked to moved without proper direction')
    end

    self.lastDir = direction

    if self.mapData:checkCollision ( x, y ) then
      self.moving = false
      self:faceDirection ( direction )
      return
    end

    self.moving = true
    anim = MOAIAnim:new ()
    anim:reserveLinks ( 1 )
    anim:setMode ( MOAITimer.NORMAL )
    anim:setSpan ( 1 / self.SPEED )
    anim:setLink ( 1, self:walkAnim( self.startFrame, animIndex ), self, MOAIProp2D.ATTR_INDEX )
    anim:start ()
    self.x, self.y = x, y

    return self:seekLoc ( x, y, 1 / self.SPEED, MOAIEaseType.LINEAR )
  end

  return character
end
--]]
return Character
