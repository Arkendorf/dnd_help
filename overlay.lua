require("engine")
function overlay_load()
  sidebarPos = 0
  sidebarSize = w / 4
  sidebar = love.graphics.newCanvas(sidebarSize, h)
end

function overlay_draw()

  if selected ~= nil then
    love.graphics.setCanvas(sidebar)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, sidebarSize, h)
    love.graphics.setColor(55, 55, 55)
    if objects[selected.type][selected.num].name ~= nil and objects[selected.type][selected.num].tags ~= nil then
      love.graphics.print(objects[selected.type][selected.num].name.." ("..objects[selected.type][selected.num].tags..")")
    elseif objects[selected.type][selected.num].name ~= nil then
      love.graphics.print(objects[selected.type][selected.num].name)
    end
    if objects[selected.type][selected.num].hp ~= nil then
      love.graphics.print(objects[selected.type][selected.num].hp, 0, 14)
    end
    if objects[selected.type][selected.num].atk ~= nil then
      love.graphics.print(tostring(objects[selected.type][selected.num].atk[1]).."d"..tostring(objects[selected.type][selected.num].atk[2]), 0, 28)
    end
    love.graphics.setCanvas()
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(sidebar, sidebarPos - sidebarSize, 0)
  -- add buttons
  love.graphics.setColor(255, 255, 255)
  love.graphics.setLineWidth(2)
  love.graphics.rectangle("fill", 0, h - sidebarSize / 3, sidebarSize, sidebarSize / 3)
  love.graphics.setColor(155, 155, 155)
  love.graphics.rectangle("line", sidebarSize / 24, h - sidebarSize / 3.45, sidebarSize / 4, sidebarSize / 4)
  love.graphics.circle("line", sidebarSize / 2, h - sidebarSize / 6, sidebarSize / 8, sidebarSize / 8)
  love.graphics.polygon("line", sidebarSize / 1.41, h - sidebarSize / 24, sidebarSize - sidebarSize / 6, h - sidebarSize / 3.45, sidebarSize / 1.04, h - sidebarSize / 24)
end

function overlay_update(dt)
  if selected ~= nil and sidebarPos < sidebarSize then
    sidebarPos = sidebarPos + (sidebarSize - sidebarPos) / 4
  elseif selected == nill and sidebarPos > 0 then
    sidebarPos = sidebarPos - (sidebarPos) / 4
  end
end

function overlay_mousepressed(x, y, button)
  if button == 1 and x >= sidebarSize / 24 and x <= sidebarSize / 3.45 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    players[#players + 1] = {x = 0, y = 0, rgb = {getColor()}, s = 1}
    selected = {type = 1, num = #players, new = true}
    onMouse = true
  elseif button == 1 and x >= sidebarSize / 2.67 and x <= sidebarSize / 1.6 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    npcs[#npcs + 1] = {x = 0, y = 0, rgb = {getColor()}, s = 1}
    selected = {type = 2, num = #npcs, new = true}
    onMouse = true
  elseif button == 1 and x >= sidebarSize / 1.41 and x <= sidebarSize / 1.046 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    monsters[#monsters + 1] = {x = 0, y = 0, rgb = {getColor()}, s = 1}
    selected = {type = 3, num = #monsters, new = true}
    onMouse = true
  end
end
