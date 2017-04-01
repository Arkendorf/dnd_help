require("engine")
require("overlay")

function love.load()
  math.randomseed(os.time())
  love.graphics.setDefaultFilter("nearest", "nearest")
  players = {{x = 16, y = 16, rgb = getColor(), s = 1}}
  npcs = {{x = 32, y = 32, rgb = getColor(), s = 1}}
  monsters = {{x = 48, y = 48, rgb = getColor(), s = 3, name = "Burt", init = 0, hp = 20, atk = {2, 20}, tags = "Dragon", info = "n/a"}, {x = 128, y = 128, rgb = getColor(), s = 1}}
  objects = {players, npcs, monsters}
  w, h = love.graphics.getDimensions()
  engine_load()
  overlay_load()
end
function love.update(dt)
  engine_update(dt)
  overlay_update(dt)
end

function love.draw()
  engine_draw()
  overlay_draw()
end

function love.wheelmoved( x, y )
  engine_wheelmoved(x, y)
end



function love.mousepressed(x, y, button)
  if (x >= 0 and x <= sidebarSize) and ((selected ~= nil and y >= 0 and y <= h) or (selected == nil and y >= h - sidebarSize / 3 and y <= h)) then
    overlay_mousepressed(x, y, button)
  else
    engine_mousepressed(x, y, button)
  end
end



function love.keypressed(key)
  engine_keypressed(key)
end
