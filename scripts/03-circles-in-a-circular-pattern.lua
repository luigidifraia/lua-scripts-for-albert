--[[ Lua script for ALBERT by Luigi Di Fraia
Circles in a circular pattern
--]]

require "math"

cycle = 20
radius = 78

drawclear()

for f = 0, cycle - 1 do
  a = 2*math.pi*f/cycle
  x = 208 + radius*math.cos(a)
  y = 150 + radius*math.sin(a)
  drawcircle(x, y, 20, 7)
end
