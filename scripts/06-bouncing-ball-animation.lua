--[[ Lua script for ALBERT by Luigi Di Fraia
Bouncing ball animation
Based on https://physics.stackexchange.com/questions/256468/model-formula-for-bouncing-ball
--]]

require "math"

invalidateoff() -- disable the auto-refresh

h0 = 176        -- px
v = 0           -- px/s, current velocity
g = 10          -- px/s/s
t = 0           -- starting time
dt = 0.15       -- time step
rho = 0.75      -- coefficient of restitution
tau = 0.01      -- contact time for bounce
hmax = h0       -- keep track of the maximum height
h = h0
tstop = 13      -- stop when enough bounces have taken place
freefall = true -- state: freefall or in contact
t_last = -math.sqrt(2*h0/g) -- time we would have launched to get to h0 at t=0
vmax = math.sqrt(2*hmax*g)

frame = 0
saveframes = false   -- whether to save frames as PNG
savedir = "C:/Temp"  -- folder where to save frames

while t < tstop do
  if freefall == true then
    hnew = h + v*dt - 0.5*g*dt*dt
    if hnew<0 then
      t = t_last + 2*math.sqrt(2*hmax/g)
      freefall = false
      t_last = t + tau
      h = 0
    else
      t = t + dt
      v = v - g*dt
      h = hnew
    end
  else
    t = t + tau
    vmax = vmax*rho
    v = vmax
    freefall = true
    h = 0
  end
  hmax = 0.5*vmax*vmax/g

  drawclear()

  drawline(30, 217, 385, 217, 13)
  drawline(0, 249, 415, 249, 7)

  x = t/tstop*426
  y = h0 + 64 - h

  drawcirclef(x, y, 10, 2)
  drawcirclef(x + 5, y - 5, 2, 10)
  drawcirclef(416 - x, y - 30, 7, 4)
  drawcirclef(416 - x + 3, y - 30 - 3, 1, 14)

  drawrefresh()  -- force a refresh of the drawing

  if saveframes == true then
    fn = string.format("%s/frame-%04d.png", savedir, frame)
    exportpng(fn)
  end

  frame = frame + 1

  checkpointsave()
end
