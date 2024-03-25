--[[ Lua script for ALBERT by Luigi Di Fraia
Miscellaneous shapes
--]]

checkpointon()

invalidateoff() -- disable the auto-refresh

drawclear()

drawline(48, 51, 96, 99, 10)
drawline(48, 51, 0, 99, 7)
drawline(74, 51, 0, 125, 5)
drawcirclef(208, 151, 40, 15)
drawcirclef(238, 171, 50, 14)
drawcirclef(238, 171, 30, 13)
drawcirclef(248, 181, 20, 12)
drawcircle(300, 131, 80, 7)
drawstar(70, 75, 100, 4)
drawfill(120, 125, 4)

drawrefresh()  -- force a refresh of the drawing
