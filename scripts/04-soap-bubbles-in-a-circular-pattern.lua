--[[ Lua script for ALBERT by Luigi Di Fraia
Green soap bubbles in a circular pattern
--]]

require "math"

cycle = 20
radius = 78

drawclear()

for f = 0, cycle - 1 do
  a = 2*math.pi*f/cycle
  x = 208 + radius*math.cos(a)
  y = 150 + radius*math.sin(a)
  s = 10*math.random()
  s = math.max(5, s);
  drawcirclef(x, y, s, 5)
  drawcirclef(x + s/2 - 1, y - s/2 + 1, 2, 13)
end
