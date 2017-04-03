require("engine")
function overlay_load()
  sidebarPos = 0
  sidebarSize = w / 4
  sidebar = love.graphics.newCanvas(sidebarSize, h)
  textBox = ""
  nameBoxSize = 0
  tagsBoxSize = 0
  infoBoxSize = 0
end

function overlay_draw()
  love.graphics.setLineWidth(2)

  if selected ~= nil then
    love.graphics.setCanvas(sidebar)
    love.graphics.setColor(255, 255, 255)
    love.graphics.rectangle("fill", 0, 0, sidebarSize, h)
    love.graphics.setColor(55, 55, 55)

    -- draw name
    love.graphics.setColor(155, 155, 155)
    love.graphics.rectangle("fill", 6, 6, sidebarSize - 12, nameBoxSize)
    love.graphics.setColor(55, 55, 55)
    love.graphics.printf(objects[selected.type][selected.num].name, 8, 6, sidebarSize - 16, "left")
    if textBox == "name" then
      love.graphics.rectangle("line", 6, 6, sidebarSize - 12, nameBoxSize)
    end

    -- draw tags
    love.graphics.setColor(155, 155, 155)
    love.graphics.rectangle("fill", 6, 12 + nameBoxSize, sidebarSize - 12, tagsBoxSize)
    love.graphics.setColor(55, 55, 55)
    love.graphics.printf(objects[selected.type][selected.num].tags, 8, 12 + nameBoxSize, sidebarSize - 16, "left")
    if textBox == "tags" then
      love.graphics.rectangle("line", 6, 12 + nameBoxSize, sidebarSize - 12, tagsBoxSize)
    end

    -- draw info
    love.graphics.setColor(155, 155, 155)
    love.graphics.rectangle("fill", 6, 18 + nameBoxSize + tagsBoxSize, sidebarSize - 12, infoBoxSize)
    love.graphics.setColor(55, 55, 55)
    love.graphics.printf(objects[selected.type][selected.num].info, 8, 18 + nameBoxSize + tagsBoxSize, sidebarSize - 16, "left")
    if textBox == "info" then
      love.graphics.rectangle("line", 6, 18 + nameBoxSize + tagsBoxSize, sidebarSize - 12, infoBoxSize)
    end

    -- if objects[selected.type][selected.num].hp ~= nil then
    --   love.graphics.print(objects[selected.type][selected.num].hp, 0, 14)
    -- end
    -- if objects[selected.type][selected.num].atk ~= nil then
    --   love.graphics.print(tostring(objects[selected.type][selected.num].atk[1]).."d"..tostring(objects[selected.type][selected.num].atk[2]), 0, 28)
    -- end
    love.graphics.setCanvas()
  end
  love.graphics.setColor(255, 255, 255)
  love.graphics.draw(sidebar, sidebarPos - sidebarSize, 0)
  -- add buttons
  love.graphics.setColor(255, 255, 255)
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
  if selected ~= nil then
    nameBoxSize = getWrapSize(objects[selected.type][selected.num].name, sidebarSize - 16)
    if nameBoxSize < 14 then
      nameBoxSize = 14
    end
    tagsBoxSize = getWrapSize(objects[selected.type][selected.num].tags, sidebarSize - 16)
    if tagsBoxSize < 14 then
      tagsBoxSize = 14
    end
    infoBoxSize = getWrapSize(objects[selected.type][selected.num].info, sidebarSize - 16)
    if infoBoxSize < 28 then
      infoBoxSize = 28
    end
  end
end

function overlay_mousepressed(x, y, button)
  -- adding buttons
  if button == 1 and x >= sidebarSize / 24 and x <= sidebarSize / 3.45 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    players[#players + 1] = {x = 0, y = 0, rgb = {getColor()}, s = 1, name = "", tags = "", info = ""}
    selected = {type = 1, num = #players, new = true}
    onMouse = true
  elseif button == 1 and x >= sidebarSize / 2.67 and x <= sidebarSize / 1.6 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    npcs[#npcs + 1] = {x = 0, y = 0, rgb = {getColor()}, s = 1, name = "", tags = "", info = ""}
    selected = {type = 2, num = #npcs, new = true}
    onMouse = true
  elseif button == 1 and x >= sidebarSize / 1.41 and x <= sidebarSize / 1.046 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    monsters[#monsters + 1] = {x = 0, y = 0, rgb = {getColor()}, s = 1, name = "", tags = "", info = ""}
    selected = {type = 3, num = #monsters, new = true}
    onMouse = true
  elseif selected ~= nil and button == 1 and x >= 6 and x <= sidebarSize - 12 and y >= 6 and y <= 6 + nameBoxSize then
    textBox = "name"
  elseif selected ~= nil and button == 1 and x >= 6 and x <= sidebarSize - 12 and y >= 12 + nameBoxSize and y <= 12 + nameBoxSize + tagsBoxSize then
    textBox = "tags"
  elseif selected ~= nil and button == 1 and x >= 6 and x <= sidebarSize - 12 and y >= 18 + nameBoxSize + tagsBoxSize and y <= 18 + nameBoxSize + tagsBoxSize + infoBoxSize then
    textBox = "info"
  else
    textBox = ""
  end
end

function overlay_keypressed(key)
  love.keyboard.setKeyRepeat(false)
  if key == "return" and textBox ~= "" then
    textBox = ""
  elseif key == "backspace" and textBox ~= "" then
    if textBox == "name" then
      objects[selected.type][selected.num].name = string.sub(objects[selected.type][selected.num].name, 1, -2)
    elseif textBox == "tags" then
      objects[selected.type][selected.num].tags = string.sub(objects[selected.type][selected.num].tags, 1, -2)
    elseif textBox == "info" then
      objects[selected.type][selected.num].info = string.sub(objects[selected.type][selected.num].info, 1, -2)
    end
    love.keyboard.setKeyRepeat(true)
  end
end

function overlay_textinput(text)
  if selected ~= nil and textBox == "name" then
    objects[selected.type][selected.num].name = objects[selected.type][selected.num].name .. text
  elseif selected ~= nil and textBox == "tags" then
    objects[selected.type][selected.num].tags = objects[selected.type][selected.num].tags .. text
  elseif selected ~= nil and textBox == "info" then
    objects[selected.type][selected.num].info = objects[selected.type][selected.num].info .. text
  end
end
