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
    love.graphics.printf(focus.name, 8, 6, sidebarSize - 16, "left")
    if textBox == "name" then
      love.graphics.rectangle("line", 6, 6, sidebarSize - 12, nameBoxSize)
    end

    -- draw tags
    love.graphics.setColor(155, 155, 155)
    love.graphics.rectangle("fill", 6, 12 + nameBoxSize, sidebarSize - 12, tagsBoxSize)
    love.graphics.setColor(55, 55, 55)
    love.graphics.printf(focus.tags, 8, 12 + nameBoxSize, sidebarSize - 16, "left")
    if textBox == "tags" then
      love.graphics.rectangle("line", 6, 12 + nameBoxSize, sidebarSize - 12, tagsBoxSize)
    end

    --draw stats
    drawStatBubble(sidebarSize / 4 - 6, 18 + nameBoxSize + tagsBoxSize + sidebarSize / 8, sidebarSize / 8, sidebarSize / 8, focus.ac, false, "AC")
    drawStatBubble(sidebarSize / 2, 18 + nameBoxSize + tagsBoxSize + sidebarSize / 8, sidebarSize / 8, sidebarSize / 8, focus.hp, false, "HP")
    drawStatBubble((sidebarSize / 4) * 3 + 6, 18 + nameBoxSize + tagsBoxSize + sidebarSize / 8, sidebarSize / 8, sidebarSize / 8, focus.init, false, "Init")
    drawStatBubble(sidebarSize / 4 - 6, 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 3, sidebarSize / 8, sidebarSize / 8, focus.stats.str, true, "STR")
    drawStatBubble(sidebarSize / 2, 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 3, sidebarSize / 8, sidebarSize / 8, focus.stats.dex, true, "DEX")
    drawStatBubble((sidebarSize / 4) * 3 + 6, 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 3, sidebarSize / 8, sidebarSize / 8, focus.stats.con, true, "CON")
    drawStatBubble(sidebarSize / 4 - 6, 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 5, sidebarSize / 8, sidebarSize / 8, focus.stats.int, true, "INT")
    drawStatBubble(sidebarSize / 2, 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 5, sidebarSize / 8, sidebarSize / 8, focus.stats.wis, true, "WIS")
    drawStatBubble((sidebarSize / 4) * 3 + 6, 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 5, sidebarSize / 8, sidebarSize / 8, focus.stats.cha, true, "CHA")

    -- draw attack
    love.graphics.setColor(155, 155, 155)
    love.graphics.rectangle("fill", sidebarSize / 4 - sidebarSize / 8 - 6, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize / 4 - 4, 14)
    love.graphics.rectangle("fill", sidebarSize / 2 - sidebarSize / 8 + 4, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize / 4 - 4, 14)
    love.graphics.rectangle("line", (sidebarSize / 4) * 3 - sidebarSize / 8 + 6, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize / 4, 14)
    love.graphics.setColor(55, 55, 55)
    love.graphics.print("d", sidebarSize / 2 - sidebarSize / 8 - 7, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + 1)
    love.graphics.printf(tostring(focus.atk[1]), sidebarSize / 4 - sidebarSize / 8 - 5, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + 1, sidebarSize / 4 - 6, "right")
    love.graphics.printf(tostring(focus.atk[2]), sidebarSize / 2 - sidebarSize / 8 + 5, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + 1, sidebarSize / 4 - 6, "left")
    love.graphics.printf("Roll", (sidebarSize / 4) * 3 - sidebarSize / 8 + 6, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + 1, sidebarSize / 4,"center")
    if textBox == "atk1" then
      love.graphics.rectangle("line", sidebarSize / 4 - sidebarSize / 8 - 6, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize / 4 - 4, 14)
    elseif textBox == "atk2" then
      love.graphics.rectangle("line", sidebarSize / 2 - sidebarSize / 8 + 4, 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize / 4 - 4, 14)
    end
    love.graphics.printf(focus.atk[3], 0, 50 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize, "center")

    -- draw info
    love.graphics.setColor(155, 155, 155)
    love.graphics.rectangle("fill", 6, 70 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize - 12, infoBoxSize)
    love.graphics.setColor(55, 55, 55)
    love.graphics.printf(focus.info, 8, 70 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize - 16, "left")
    if textBox == "info" then
      love.graphics.rectangle("line", 6, 70 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6, sidebarSize - 12, infoBoxSize)
    end

    -- draw color
    love.graphics.setColor(focus.rgb[1], focus.rgb[2], focus.rgb[3])
    love.graphics.rectangle("fill", 6, 76 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize, sidebarSize / 3 - 8, 20)
    love.graphics.rectangle("fill", 13 + sidebarSize / 3 - 9, 76 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize, sidebarSize / 3 - 8, 20)
    love.graphics.rectangle("fill", 20 + (sidebarSize / 3 - 9) * 2, 76 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize, sidebarSize / 3 - 8, 20)
    love.graphics.setColor(55, 55, 55)
    love.graphics.printf(tostring(focus.rgb[1]), 6, 76 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize + 3, sidebarSize / 3 - 8, "center")
    love.graphics.printf(tostring(focus.rgb[2]), 13 + sidebarSize / 3 - 9, 76 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize + 3, sidebarSize / 3 - 8, "center")
    love.graphics.printf(tostring(focus.rgb[3]), 20 + (sidebarSize / 3 - 9) * 2, 76 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize + 3, sidebarSize / 3 - 8, "center")

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
  if selected ~= nil then
    focus = objects[selected.type][selected.num]
  end
  if selected ~= nil and sidebarPos < sidebarSize then
    sidebarPos = sidebarPos + (sidebarSize - sidebarPos) / 4
  elseif selected == nil and sidebarPos > 0 then
    sidebarPos = sidebarPos - (sidebarPos) / 4
  end
  if selected ~= nil then
    nameBoxSize = getWrapSize(focus.name, sidebarSize - 16)
    if nameBoxSize < 14 then
      nameBoxSize = 14
    end
    tagsBoxSize = getWrapSize(focus.tags, sidebarSize - 16)
    if tagsBoxSize < 14 then
      tagsBoxSize = 14
    end
    infoBoxSize = getWrapSize(focus.info, sidebarSize - 16)
    if infoBoxSize < 28 then
      infoBoxSize = 28
    end
  end
end

function overlay_mousepressed(x, y, button)
  -- adding buttons
  if button == 1 and x >= sidebarSize / 24 and x <= sidebarSize / 3.45 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    players[#players + 1] = {x = 0, y = 0, rgb = getColor(), s = 1, name = "", tags = "", info = "", hp = 10, ac = 10, init = 1, stats = {str = 10, dex = 10, con = 10, int = 10, wis = 10, cha = 10}, atk = {1, 6, ""}}
    selected = {type = 1, num = #players, new = true}
    onMouse = true
  elseif button == 1 and x >= sidebarSize / 2.67 and x <= sidebarSize / 1.6 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    npcs[#npcs + 1] = {x = 0, y = 0, rgb = getColor(), s = 1, name = "", tags = "", info = "", hp = 10, ac = 10, init = 1, stats = {str = 10, dex = 10, con = 10, int = 10, wis = 10, cha = 10}, atk = {1, 6, ""}}
    selected = {type = 2, num = #npcs, new = true}
    onMouse = true
  elseif button == 1 and x >= sidebarSize / 1.41 and x <= sidebarSize / 1.046 and y >= h - sidebarSize / 3.45 and y <= h - sidebarSize / 24 then
    monsters[#monsters + 1] = {x = 0, y = 0, rgb = getColor(), s = 1, name = "", tags = "", info = "", hp = 10, ac = 10, init = 1, stats = {str = 10, dex = 10, con = 10, int = 10, wis = 10, cha = 10}, atk = {1, 6, ""}}
    selected = {type = 3, num = #monsters, new = true}
    onMouse = true
  elseif selected ~= nil and button == 1 and x >= 6 and x <= sidebarSize - 12 and y >= 6 and y <= 6 + nameBoxSize then
    textBox = "name"
  elseif selected ~= nil and button == 1 and x >= 6 and x <= sidebarSize - 12 and y >= 12 + nameBoxSize and y <= 12 + nameBoxSize + tagsBoxSize then
    textBox = "tags"
  elseif selected ~= nil and button == 1 and x >= 6 and x <= sidebarSize - 12 and y >= 70 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 and y <= 70 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 + infoBoxSize then
    textBox = "info"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 4 - 6 - sidebarSize / 8 and x <= sidebarSize / 2 - sidebarSize / 4 - 6 + sidebarSize / 8 and y >= 18 + nameBoxSize + tagsBoxSize and y <= 18 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 2 then
    textBox = "AC"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 2 - sidebarSize / 8 and x <= sidebarSize / 2 + sidebarSize / 8 and y >= 18 + nameBoxSize + tagsBoxSize and y <= 18 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 2 then
    textBox = "HP"
  elseif selected ~= nil and button == 1 and x >= (sidebarSize / 4) * 3 + 6 - sidebarSize / 8 and x <= sidebarSize / 2 + sidebarSize / 4 + 6 + sidebarSize / 8 and y >= 18 + nameBoxSize + tagsBoxSize and y <= 18 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 2 then
    textBox = "Init"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 4 - 6 - sidebarSize / 8 and x <= sidebarSize / 2 - sidebarSize / 4 - 6 + sidebarSize / 8 and y >= 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 2 and y <= 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 4 then
    textBox = "STR"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 2 - sidebarSize / 8 and x <= sidebarSize / 2 + sidebarSize / 8 and y >= 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 2 and y <= 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 4 then
    textBox = "DEX"
  elseif selected ~= nil and button == 1 and x >= (sidebarSize / 4) * 3 + 6 - sidebarSize / 8 and x <= sidebarSize / 2 + sidebarSize / 4 + 6 + sidebarSize / 8 and y >= 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 2 and y <= 24 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 4 then
    textBox = "CON"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 4 - 6 - sidebarSize / 8 and x <= sidebarSize / 2 - sidebarSize / 4 - 6 + sidebarSize / 8 and y >= 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 4 and y <= 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 then
    textBox = "INT"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 2 - sidebarSize / 8 and x <= sidebarSize / 2 + sidebarSize / 8 and y >= 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 4 and y <= 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 then
    textBox = "WIS"
  elseif selected ~= nil and button == 1 and x >= (sidebarSize / 4) * 3 + 6 - sidebarSize / 8 and x <= sidebarSize / 2 + sidebarSize / 4 + 6 + sidebarSize / 8 and y >= 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 4 and y <= 30 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 then
    textBox = "CHA"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 4 - sidebarSize / 8 - 6 and x <= sidebarSize / 2 - sidebarSize / 8 - 10 and y >= 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 and y <= 50 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 then
    textBox = "atk1"
  elseif selected ~= nil and button == 1 and x >= sidebarSize / 2 - sidebarSize / 8 + 4 and x <= (sidebarSize / 8) * 5 and y >= 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 and y <= 50 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 then
    textBox = "atk2"
  elseif selected ~= nil and button == 1 and x >= (sidebarSize / 4) * 3 - sidebarSize / 8 + 6 and x <= (sidebarSize / 8) * 7 + 6 and y >= 36 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 and y <= 50 + nameBoxSize + tagsBoxSize + (sidebarSize / 8) * 6 then
    local dmg = 0
    for i = 1, focus.atk[1] do
      dmg = dmg + math.random(1, focus.atk[2])
    end
    focus.atk[3] = tostring(dmg)
    textBox = ""
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
      focus.name = string.sub(focus.name, 1, -2)
    elseif textBox == "tags" then
      focus.tags = string.sub(focus.tags, 1, -2)
    elseif textBox == "info" then
      focus.info = string.sub(focus.info, 1, -2)
    elseif selected ~= nil and textBox == "AC" and focus.ac > 9 then
      focus.ac = tonumber(string.sub(tostring(focus.ac), 1, -2))
    elseif selected ~= nil and textBox == "AC" and focus.ac < 10 then
      focus.ac = 0
    elseif selected ~= nil and textBox == "HP" and focus.hp > 9 then
      focus.hp = tonumber(string.sub(tostring(focus.hp), 1, -2))
    elseif selected ~= nil and textBox == "HP" and focus.hp < 10 then
      focus.hp = 0
    elseif selected ~= nil and textBox == "Init" and focus.init > 9 then
      focus.init = tonumber(string.sub(tostring(focus.init), 1, -2))
    elseif selected ~= nil and textBox == "Init" and focus.init < 10 then
      focus.init = 0
    elseif selected ~= nil and textBox == "STR" and focus.stats.str > 9 then
      focus.stats.str = tonumber(string.sub(tostring(focus.stats.str), 1, -2))
    elseif selected ~= nil and textBox == "STR" and focus.stats.str < 10 then
      focus.stats.str = 0
    elseif selected ~= nil and textBox == "DEX" and focus.stats.dex > 9 then
      focus.stats.dex = tonumber(string.sub(tostring(focus.stats.dex), 1, -2))
    elseif selected ~= nil and textBox == "DEX" and focus.stats.dex < 10 then
      focus.stats.dex = 0
    elseif selected ~= nil and textBox == "CON" and focus.stats.con > 9 then
      focus.stats.con = tonumber(string.sub(tostring(focus.stats.con), 1, -2))
    elseif selected ~= nil and textBox == "CON" and focus.stats.con < 10 then
      focus.stats.con = 0
    elseif selected ~= nil and textBox == "WIS" and focus.stats.wis > 9 then
      focus.stats.wis = tonumber(string.sub(tostring(focus.stats.wis), 1, -2))
    elseif selected ~= nil and textBox == "WIS" and focus.stats.wis < 10 then
      focus.stats.wis = 0
    elseif selected ~= nil and textBox == "INT" and focus.stats.int > 9 then
      focus.stats.int = tonumber(string.sub(tostring(focus.stats.int), 1, -2))
    elseif selected ~= nil and textBox == "INT" and focus.stats.int < 10 then
      focus.stats.int = 0
    elseif selected ~= nil and textBox == "CHA" and focus.stats.cha > 9 then
      focus.stats.cha = tonumber(string.sub(tostring(focus.stats.cha), 1, -2))
    elseif selected ~= nil and textBox == "CHA" and focus.stats.cha < 10 then
      focus.stats.cha = 0
    elseif selected ~= nil and textBox == "atk1" and focus.atk[1] > 9 then
      focus.atk[1] = tonumber(string.sub(tostring(focus.atk[1]), 1, -2))
    elseif selected ~= nil and textBox == "atk1" and focus.atk[1] < 10 then
      focus.atk[1] = 0
    elseif selected ~= nil and textBox == "atk2" and focus.atk[2] > 9 then
      focus.atk[2] = tonumber(string.sub(tostring(focus.atk[2]), 1, -2))
    elseif selected ~= nil and textBox == "atk2" and focus.atk[2] < 10 then
      focus.atk[2] = 0
    end
    love.keyboard.setKeyRepeat(true)
  end
end

function overlay_textinput(text)
  number = tonumber(text)
  if selected ~= nil and textBox == "name" then
    focus.name = focus.name .. text
  elseif selected ~= nil and textBox == "tags" then
    focus.tags = focus.tags .. text
  elseif selected ~= nil and textBox == "info" then
    focus.info = focus.info .. text
  elseif selected ~= nil and textBox == "AC" and focus.ac < 100 and number then
    focus.ac = tonumber(tostring(focus.ac .. text))
  elseif selected ~= nil and textBox == "HP" and focus.hp < 100 and number then
    focus.hp = tonumber(tostring(focus.hp .. text))
  elseif selected ~= nil and textBox == "Init" and focus.init < 100 and number then
    focus.init = tonumber(tostring(focus.init .. text))
  elseif selected ~= nil and textBox == "STR" and focus.stats.str < 1000 and number then
    focus.stats.str = tonumber(tostring(focus.stats.str .. text))
  elseif selected ~= nil and textBox == "DEX" and focus.stats.dex < 1000 and number then
    focus.stats.dex = tonumber(tostring(focus.stats.dex .. text))
  elseif selected ~= nil and textBox == "CON" and focus.stats.con < 1000 and number then
    focus.stats.con = tonumber(tostring(focus.stats.con .. text))
  elseif selected ~= nil and textBox == "WIS" and focus.stats.wis < 1000 and number then
    focus.stats.wis = tonumber(tostring(focus.stats.wis .. text))
  elseif selected ~= nil and textBox == "INT" and focus.stats.int < 1000 and number then
    focus.stats.int = tonumber(tostring(focus.stats.int .. text))
  elseif selected ~= nil and textBox == "CHA" and focus.stats.cha < 1000 and number then
    focus.stats.cha = tonumber(tostring(focus.stats.cha .. text))
  elseif selected ~= nil and textBox == "atk1" and focus.atk[1] < 10000 and number then
    focus.atk[1] = tonumber(tostring(focus.atk[1] .. text))
  elseif selected ~= nil and textBox == "atk2" and focus.atk[2] < 10000 and number then
    focus.atk[2] = tonumber(tostring(focus.atk[2] .. text))
  end
end

function drawStatBubble(x, y, r, l, stat, showModifier, txt)
  if textBox == tostring(txt) then
    love.graphics.setColor(55, 55, 55)
  else
    love.graphics.setColor(155, 155, 155)
  end
  love.graphics.circle("line", x, y, r, l)
  love.graphics.setColor(55, 55, 55)
  love.graphics.setFont(font)
  love.graphics.printf(tostring(txt), x - r, math.floor(y - 6 - r * 0.53), r * 2 , "center")
  love.graphics.setFont(bigFont)
  if showModifier == true then
    if stat <= 2009 then
      modifier = tostring(math.floor((stat - 10) / 2))
    else
      modifier = "999"
    end
    if string.len(modifier) > 2 then
      love.graphics.printf(modifier, x - r, y - 10, r * 2 , "center")
    else
      love.graphics.printf("+"..modifier, x - r, y - 10, r * 2 , "center")
    end
    love.graphics.setFont(font)
    love.graphics.printf(tostring(stat), x - r, math.ceil(y - 6 + r * 0.53), r * 2 , "center")
  else
    if stat < 1000 then
      love.graphics.printf(tostring(stat), x - r, y - 10, r * 2 , "center")
    else
      love.graphics.printf("999", x - r, y - 10, r * 2 , "center")
    end
  end
end
