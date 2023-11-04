--[[ Lua script for ALBERT by Luigi Di Fraia
Stars and spheres
--]]

p = 4
s = 28
i = 0
x = 0

invalidateoff() -- disable the auto-refresh

drawclear()

r = s/2 + 1

while i <= 416 - r do
  j = 0
  y = x % 2

  while j < 200 - r do
    if(y % 2 == 0) then
      drawstar(i, j + 56 + 1, 2*r, 2*r, 10)
    else
      drawcirclef(i + r, j + 56 + r, r, 4)
      drawcirclef(i + r - r/3, j + 56 + r - r/3, r/4, 10)
    end

    j = j + s + p
    y = y + 1
  end

  i = i + s + p
  x = x + 1
end

drawrefresh()  -- force a refresh of the drawing
