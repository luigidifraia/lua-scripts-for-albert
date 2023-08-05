--[[ Lua script for ALBERT by Luigi Di Fraia
Soap bubbles in a circular pattern animation
Based on the GTK Pixbufs demo
--]]

require "math"

nbubbles = 10   -- number of bubbles to draw
szbubble = 8    -- average bubble radius
radius = 64     -- radius of the overall bubble pattern

cycles = 60     -- total frames in the animation

xmid = 208      -- screen center, x coordinate
ymid = 156      -- screen center, y coordinate

saveframes = false   -- whether to save frames as PNG
savedir = "C:/Temp"  -- folder where to save frames

invalidateoff() -- disable the auto-refresh

buildframe = 0

for frame = 0, cycles - 1 do
  drawclear()   -- clear the canvas

  f = frame/cycles
  rd = f*2*math.pi

  for b = 0, nbubbles - 1 do
    a = 2*math.pi*b/nbubbles - rd

    r = radius + (radius/3)*math.sin(rd)

    x = math.floor(xmid + r*math.cos(a) - szbubble + 0.5)
    y = math.floor(ymid + r*math.sin(a) - szbubble + 0.5)

    if b & 1 ~= 0 then
      k = math.sin(rd)
      c1 = 5
      c2 = 13
    else
      k = math.cos(rd)
      c1 = 6
      c2 = 14
    end
    k = 2*k*k
    k = math.max(0.25, k)

    s = k*szbubble

    drawcirclef(x, y, s, c1)

    -- If a bubble is big enough then add some glare
    if k > 0.35 then
      drawcirclef(x + s/2 - 1, y - s/2 + 1, 2, c2)
    end

    -- Produce a build-up sequence for the first frame
    if frame == 0 then
      drawrefresh()  -- force a refresh of the drawing

      if saveframes == true then
        fn = string.format("%s/frame-%04d-%04d.png", savedir, frame, buildframe)
        exportpng(fn)
      end

      checkpointsave()

      buildframe = buildframe + 1
    end
  end

  drawrefresh()  -- force a refresh of the drawing

  if frame ~= 0 then
    if saveframes == true then
      fn = string.format("%s/frame-%04d.png", savedir, frame)
      exportpng(fn)
    end
  end

  checkpointsave()
end
