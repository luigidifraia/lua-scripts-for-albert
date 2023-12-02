--[[ Lua script for ALBERT by Luigi Di Fraia
Random shapes that might cause pareidolia
Based on https://stackoverflow.com/questions/40891423/how-to-call-a-random-function-in-lua
--]]

require "math"

x_min = 0
x_max = 415
y_min = 51
y_max = 250

shape_min_dim = 30
shape_max_dim = 100

function random_line()
  local x_from = math.random(x_min, x_max)
  local y_from = math.random(y_min, y_max)
  local x_to = math.random(x_min, x_max)
  local y_to = math.random(y_min, y_max)
  local color = math.random(0, 15)
  drawline(x_from, y_from, x_to, y_to, color)
end

function random_rectangle()
  local x = math.random(x_min, x_max)
  local y = math.random(y_min, y_max)
  local width = math.random(shape_min_dim, shape_max_dim)
  local height = math.random(shape_min_dim, shape_max_dim)
  local color = math.random(0, 15)
  if (x+width > x_max) then width = x_max-x end
  if (y+height > y_max) then height = y_max-y end
  drawline(x, y, x+width, y, color)
  drawline(x+width, y, x+width, y+height, color)
  drawline(x+width, y+height, x, y+height, color)
  drawline(x, y+height, x, y, color)
end

function normalise_radius(x, y, r)
  if (x-r < 0) then r = x end
  if (x+r > x_max) then r = x_max-x end
  if (y-r < y_min) then r = y-y_min end
  if (y+r > y_max) then r = y_max-y end
  return r
end

function random_circle()
  local x_center, y_center, radius, color
  repeat
    x_center = math.random(x_min, x_max)
    y_center = math.random(y_min, y_max)
    radius = math.random(shape_min_dim, shape_max_dim)
    color = math.random(0, 15)
    radius = normalise_radius(x_center, y_center, radius)
  until (radius > 0)
  if (x_center % 2 == 0) then
    drawcircle(x_center, y_center, radius, color)
  else
    drawcirclef(x_center, y_center, radius, color)
  end
end

function random_ellipse()
  local x_center, y_center, radius_x, radius_y, color
  repeat
    x_center = math.random(x_min, x_max)
    y_center = math.random(y_min, y_max)
    radius_x = math.random(shape_min_dim, shape_max_dim)
    radius_y = math.random(shape_min_dim, shape_max_dim)
    color = math.random(0, 15)
    radius_x = normalise_radius(x_center, y_center, radius_x)
    radius_y = normalise_radius(x_center, y_center, radius_y)
  until (radius_x > 0 and radius_y > 0)
  if (x_center % 2 == 0) then
    drawellipse(x_center, y_center, radius_x, radius_y, color)
  else
    drawellipsef(x_center, y_center, radius_x, radius_y, color)
  end
end

invalidateoff() -- disable the auto-refresh

drawclear()

function execute_random(f_tbl)
  local random_index = math.random(1, #f_tbl) --pick random index from 1 to #f_tbl
  f_tbl[random_index]() --execute function at the random_index we've picked
end

-- prepare/fill our function table
local funcs = {random_line, random_rectangle, random_circle, random_ellipse}

-- seed the pseudo-random generator
math.randomseed(os.time())

-- try executing random functions
for i = 0, 50 do
  execute_random(funcs)
end

drawrefresh()  -- force a refresh of the drawing
