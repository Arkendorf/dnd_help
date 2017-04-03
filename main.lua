require("engine")
require("overlay")

function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest", "nearest")
  players = {{x = 16, y = 16, rgb = getColor(), s = 1, name = "", tags = "", info = ""}}
  npcs = {{x = 32, y = 32, rgb = getColor(), s = 1, name = "", tags = "", info = ""}}
  monsters = {{x = 48, y = 48, rgb = getColor(), s = 3, name = "Burt", init = 0, hp = 20, atk = {2, 20}, tags = "Dragon", info = "n/a"}}
  objects = {players, npcs, monsters}
  w, h = love.graphics.getDimensions()
  engine_load()
  overlay_load()
  gamestate = "engine"
end
function love.update(dt)
  x, y = love.mouse.getPosition()
  if (x >= 0 and x <= sidebarSize) and ((selected ~= nil and y >= 0 and y <= h) or (selected == nil and y >= h - sidebarSize / 3 and y <= h)) then
    gamestate = "overlay"
  else
    gamestate = "engine"
  end
  engine_update(dt)
  overlay_update(dt)
end

function love.draw()
  engine_draw()
  overlay_draw()
end

function love.wheelmoved( x, y )
  if textBox == "" then
    engine_wheelmoved(x, y)
  end
end

function love.mousepressed(x, y, button)
  if gamestate == "overlay" then
    overlay_mousepressed(x, y, button)
  else
    engine_mousepressed(x, y, button)
  end
end

function love.keypressed(key)
  engine_keypressed(key)
  if gamestate == "overlay" then
    overlay_keypressed(key)
  end
end

function getWrapSize(str, limit)
  local font = love.graphics.getFont()
  local width, lines = font:getWrap(str, limit)
  return #lines * font:getHeight()
end

function love.textinput(text)
  overlay_textinput(text)
end
