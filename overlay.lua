function overlay_draw()
  love.graphics.setColor(255, 255, 255)
  if selected ~= nil then
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
  end
end
