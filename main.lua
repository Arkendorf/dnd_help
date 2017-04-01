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
  dXV = 0
  dYV = 0
  sX = 1
  sY = 1
  sXV = 0
  sYV = 0
  boardW = 320
  boardH = 320
  dX = w / 2 - boardW / 2
  dY = h / 2 - boardH / 2
  mX = 1
  mY = 1
  onMouse = false
end
function love.update(dt)
  engine_update(dt)
end

function love.draw()
  engine_draw()

  overlay_draw()
end

function love.wheelmoved( x, y )
  engine_wheelmoved(x, y)
end



function love.mousepressed(x, y, button)
  engine_mousepressed(x, y, button)
end



function love.keypressed(key)
  engine_keypressed(key)
end
