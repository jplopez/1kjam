pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

#include src/globals.lua

#include src/core/env.lua
#include src/core/oop.lua
#include src/core/log.lua
#include src/core/utils.lua
#include src/core/gst.lua
#include src/core/collisions.lua

#include src/entities/tile.lua
#include src/entities/board.lua

#include src/scenes/title.lua
#include src/scenes/level.lua

#include src/states/init.lua
#include src/states/game.lua

world = {}
entities = {}

function _init()
	l("start", true)
	-- initialized the 2d 8x16 board
	board:init()
	key(_ENV) -- generates the matching key
	cur=tile:random(4)
	nxt=tile:random()

	add(world,key)
	add(world,nxt)
	add(entities,board)
	add(entities,cur)
end

function _update()
	ucur(_ENV)  -- move current
	input(_ENV)	-- handle inputs
	board:update()
end

function _draw()
	cls()
	rectfill(32, 0, 95, 127, 7) -- playable area
	print("next:", 12, 1, 7)
	print("tiles\n  " .. tcount, 97, 1, 7)
	print("key:", 1, 8, 7)
	-- key
	rectfill(17, 8, 21, 12, k[1])
	rectfill(23, 8, 27, 12, k[2])

	if over then
		print("gameover", 48, 60, 8)
	else
		cur:draw()
		nxt:draw()
		board:draw()	
	end
end
-->8

-- generates the matching key
function key(_ENV) k = { rnd(clrs), rnd(clrs) } end

-- collision detection
function coll(t1, t2)
	if (t1 == nil or t2 == nil) return false
	return t1.x < t2.x + 8
			and t1.x + 8 > t2.x
			and t1.y < t2.y + 8
			and t1.y + 8 > t2.y
end

-- handle inputs
function input(_ENV)
	if (btn(⬇️)) cur:move(0,tsp*2)
	if (btnp(⬅️)) cur:move(-1, 0)
	if (btnp(➡️)) cur:move(1, 0)
end

--update current tile
function ucur(_ENV)
	cur:update()
	if(cur.state==global.parked)then
		board:set(cur.x,cur.y,tile(cur))
		rct(_ENV,cur.x,cur.y)
		cur=nxt
		cur.x=4
		nxt=tile:random()
		tcount+=1
	end
end

-->8

-- determines if there are reactions around the slot x,y
function rct(_ENV,x,y)
	local trigger=board:get(x,y) --board[x][y]
	--if (trigger==e) return
	if (y==1) over=true
	local impact={}
	if (x>1 and chk(_ENV,x-1, y, trigger.clr)) add(impact, board:get(x-1,y)) --board[x-1][y])
	if (x<8 and chk(_ENV,x+1, y, trigger.clr)) add(impact, board:get(x+1,y)) --board[x+1][y])
	if (y<16 and chk(_ENV,x, y+1, trigger.clr)) add(impact,board:get(x,y+1)) -- board[x][y+1])
	if #impact>0 then
		l(serialize(impact))
		board:set(x,y,global.e)
		for a in all(impact)do
			board:set(a.x,a.y,global.e)
		end
		l(tostr(board:get(x,y)))
		key(_ENV)
	end
end

-- checks the if slot x,y with color 'c' matches any of the keys
function chk(_ENV,x,y,c)
	local tl=board:get(x,y)
	return tl~=e
	and (tl.clr==k[1] and c==k[2]
		or tl.clr==k[2] and c==k[1])
end

function l(text, ov)logger:log(text, ov)end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
