function engine_update(dt)
  if love.keyboard.isDown("w") then
    if love.keyboard.isDown("lctrl") then
      dYV = dYV + 4
    else
      dYV = dYV + 1
    end
  end
  if love.keyboard.isDown("s") then
    if love.keyboard.isDown("lctrl") then
      dYV = dYV - 4
    else
      dYV = dYV - 1
    end
  end
  if love.keyboard.isDown("a") then
    if love.keyboard.isDown("lctrl") then
      dXV = dXV + 4
    else
      dXV = dXV + 1
    end
  end
  if love.keyboard.isDown("d") then
    if love.keyboard.isDown("lctrl") then
      dXV = dXV - 4
    else
      dXV = dXV - 1
    end
  end
  dX = dX + dXV
  dY = dY + dYV
  dXV = dXV * 0.8
  dYV = dYV * 0.8

  sX = sX + sXV
  sY = sY + sYV
  sXV = sXV * 0.8
  sYV = sYV * 0.8
  if sX < 0.125 or sY < 0.125 then
    sX = 0.125
    sY = 0.125
    sXV = 0
    sYV = 0
  end
end

function engine_draw()
  love.graphics.setColor(155, 155, 155)
  love.graphics.rectangle("fill", warp("x", 0), warp("y", 0), boardW * sX, boardH * sY)

  love.graphics.setColor(55, 55, 55)
  love.graphics.setLineWidth(sX / 2)
  if selected ~= nil then
    for across = 0, math.floor(boardW / 16) do
      love.graphics.line(warp("x", across * 16), warp("y", 0), warp("x", across * 16), warp("y", boardH))
    end
    for down = 0, math.floor(boardH / 16) do
      love.graphics.line(warp("x", 0), warp("y", down * 16), warp("x", boardW), warp("y", down * 16))
    end
  end
  love.graphics.setLineWidth(sX)

  for i, v in ipairs(players) do
    if selected == nil or selected.type ~= "player" or i ~= selected.num or onMouse ~= true then
      love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3])
      love.graphics.rectangle("fill", warp("x", v.x), warp("y", v.y), (16 * v.s) * sX, (16 * v.s) * sY)
    end
  end

  for i, v in ipairs(npcs) do
    if selected == nil or selected.type ~= "npc" or i ~= selected.num or onMouse ~= true then
      love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3])
      love.graphics.circle("fill", warp("x", v.x + 8 * v.s), warp("y", v.y + 8 * v.s), (8 * v.s) * sX, 16 * v.s + 2 * sX)
    end
  end

  for i, v in ipairs(monsters) do
    if selected == nil or selected.type ~= "monster" or i ~= selected.num or onMouse ~= true then
      love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3])
      love.graphics.polygon("fill", warp("x", v.x), warp("y", v.y + 16 * v.s), warp("x", v.x + 8 * v.s), warp("y", v.y), warp("x", v.x + 16 * v.s), warp("y", v.y + 16 * v.s))
    end
  end

  if selected ~= nil then
    if selected.type == 1 then
      local v = players[selected.num]
      love.graphics.setColor(255, 255, 255)
      love.graphics.rectangle("line", warp("x", v.x), warp("y", v.y), (16 * v.s) * sX, (16 * v.s) * sY)
    elseif selected.type == 2 then
      local v = npcs[selected.num]
      love.graphics.setColor(255, 255, 255)
      love.graphics.circle("line", warp("x", v.x + 8 * v.s), warp("y", v.y + 8 * v.s), (8 * v.s) * sX, 16 * v.s + 2 * sX)
    else
      local v = monsters[selected.num]
      love.graphics.setColor(255, 255, 255)
      love.graphics.polygon("line", warp("x", v.x), warp("y", v.y + 16 * v.s), warp("x", v.x + 8 * v.s), warp("y", v.y), warp("x", v.x + 16 * v.s), warp("y", v.y + 16 * v.s))
    end
  end

  if onMouse == true then
    if selected.type == 1 then
      local v = players[selected.num]
      love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3])
      love.graphics.rectangle("fill", love.mouse.getX() - (8 * v.s) * sX, love.mouse.getY() - (8 * v.s) * sX, (16 * v.s) * sX, (16 * v.s) * sY)
    elseif selected.type == 2 then
      local v = npcs[selected.num]
      love.graphics.setColor(125, 55, 55, 125)
      love.graphics.rectangle("fill", love.mouse.getX() - (8 * v.s) * sX, love.mouse.getY() - (8 * v.s) * sX, (16 * v.s) * sX, (16 * v.s) * sY)
      love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3])
      love.graphics.circle("fill", love.mouse.getX(), love.mouse.getY(), (8 * v.s) * sX, 16 * v.s + 2 * sX)
    else
      local v = monsters[selected.num]
      love.graphics.setColor(125, 55, 55, 125)
      love.graphics.rectangle("fill", love.mouse.getX() - (8 * v.s) * sX, love.mouse.getY() - (8 * v.s) * sX, (16 * v.s) * sX, (16 * v.s) * sY)
      love.graphics.setColor(v.rgb[1], v.rgb[2], v.rgb[3])
      love.graphics.polygon("fill", love.mouse.getX() - (8 * v.s) * sX, love.mouse.getY() + (8 * v.s) * sY, love.mouse.getX(), love.mouse.getY() - (8 * v.s) * sY, love.mouse.getX() + (8 * v.s) * sX, love.mouse.getY() + (8 * v.s) * sY)
    end
  end
end

function engine_wheelmoved(x, y)
  if love.keyboard.isDown("lctrl") then
    sXV = sXV + y / 10
    sYV = sYV + y / 10
  else
    sXV = sXV + y / 40
    sYV = sYV + y / 40
  end
end

function engine_mousepressed(x, y, button)
  if button == 1 and onMouse == false then
    local targetFound = false
    for i, v in ipairs(players) do
      if objectCollide(x, y, v.x, v.y, v.s) then
        selected = {type = 1, num = i}
        targetFound = true
        break
      end
    end
    if targetFound == false then
      for i, v in ipairs(npcs) do
        if objectCollide(x, y, v.x, v.y, v.s) then
          selected = {type = 2, num = i}
          targetFound = true
          break
        end
      end
    end
    if targetFound == false then
      for i, v in ipairs(monsters) do
        if objectCollide(x, y, v.x, v.y, v.s) then
          selected = {type = 3, num = i}
          targetFound = true
          break
        end
      end
    end
    if targetFound == false then
      selected = nil
    end
  elseif button == 2 and selected ~= nil and onMouse == false then
    if objectCollide(x, y, objects[selected.type][selected.num].x, objects[selected.type][selected.num].y, objects[selected.type][selected.num].s) then
      onMouse = true
    end
  elseif button == 1 and onMouse == true then

    local collision = false
    local oX = math.floor(((x - w / 2) / sX - objects[selected.type][selected.num].s * 16 / 2 + 8 + w / 2 - dX) / 16) * 16
    local oY = math.floor(((y - h / 2) / sY - objects[selected.type][selected.num].s * 16 / 2 + 8 + h / 2 - dY) / 16) * 16
    local oS = objects[selected.type][selected.num].s
    for i, v in ipairs(players) do
      if oX < v.x + v.s * 16 and oX + oS * 16 > v.x and oY < v.y + v.s * 16 and oY + oS * 16 > v.y  and (selected.type ~= 1 or selected.num ~= i) then
        collision = true
        break
      end
    end
    if collision == false then
      for i, v in ipairs(npcs) do
        if oX < v.x + v.s * 16 and oX + oS * 16 > v.x and oY < v.y + v.s * 16 and oY + oS * 16 > v.y and (selected.type ~= 2 or selected.num ~= i) then
          collision = true
          break
        end
      end
    end
    if collision == false then
      for i, v in ipairs(monsters) do
        if oX < v.x + v.s * 16 and oX + oS * 16 > v.x and oY < v.y + v.s * 16 and oY + oS * 16 > v.y and (selected.type ~= 3 or selected.num ~= i) then
          collision = true
          break
        end
      end
    end
    if collision == false then
      onMouse = false
      objects[selected.type][selected.num].x = oX
      objects[selected.type][selected.num].y = oY
    end
  end
end

function engine_keypressed(key)
  if key == "space" and selected ~= nil then
    if selected.type == 1 then
      dX = w / 2 - players[selected.num].x - (players[selected.num].s * 16) / 2
      dY = h / 2 - players[selected.num].y - (players[selected.num].s * 16) / 2
    elseif selected.type  == 2 then
      dX = w / 2 - npcs[selected.num].x - (npcs[selected.num].s * 16 / 2)
      dY = h / 2 - npcs[selected.num].y - (npcs[selected.num].s * 16 / 2)
    else
      dX = w / 2 - monsters[selected.num].x - (monsters[selected.num].s * 16 / 2)
      dY = h / 2 - monsters[selected.num].y - (monsters[selected.num].s * 16 / 2)
    end
    sX = 1
    sY = 1
  end
end

function warp(type, n)
  if type == "x" then
    return (n + dX - w / 2) * sX + w / 2
  else
    return (n + dY - h / 2) * sY + h / 2
  end
end

function objectCollide(x2, y2, x, y, s)
  if x2 >= warp("x", x) and x2 <= warp("x", x + 16 * s) and y2 >= warp("y", y) and y2 <= warp("y", y + 16 * s) then
    return true
  else
    return false
  end
end

function getColor()
  r = (math.random(255) + 255) / 2
  g = (math.random(255) + 255) / 2
  b = (math.random(255) + 255) / 2
  return {r, g, b}
end
