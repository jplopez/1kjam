pico-8 cartridge // http://www.pico-8.com
version 42
__lua__

#include src/globals.lua

#include src/core/env.lua
#include src/core/oop.lua
#include src/core/utils.lua
#include src/core/gst.lua
#include src/core/collisions.lua

#include src/entities/tile.lua

-- e=-1 -- represents an empty slot for a tile
-- over=false -- gameover flag
-- clrs={2,3,8,9} -- tile's colors
-- tcount=0 -- tile count

function _init()
--  pt={} -- 8x16 2D array tracking the played tiles
 for c=1,8do
 	local row={}
		for r=1,16do add(row,e)end
 	add(pt,row)
	end
 cur=tile({x=4}) -- current tile in play
 nxt=tile() -- next tile
 key() -- generates the key 
end

function _update() 
	mcur() -- move current
 input() -- handle inputs
 utile() -- update tiles: detects collisions and triggers removal of tiles
end

function _draw() 
	cls()
	rectfill(32,0,95,127,7) -- playable area
	print("next:",12,1,7)
	print("tiles\n  "..tcount,97,1,7)
	print("key:",1,8,7)
	rectfill(17,8,21,12,k[1]) -- 1st key element
	rectfill(23,8,27,12,k[2]) -- 2nd key element
	if(over)then
	 print("gameover",48,60,8)
	else dgame()end -- dgame draws the tiles
end
-->8
-- construct for a tile
function tile(t)
 t=t or {}
 return {x=t.x or 1,y=t.y or 1,
		clr=t.clr or rnd(clrs)}
end
-- generates the matching key
function key() k={rnd(clrs),rnd(clrs)}end

-- collision detection
function coll(t1,t2)
 if(t1==nil or t2==nil)return false
 return t1.x<t2.x+8
  and t1.x+8>t2.x 
  and t1.y<t2.y+8
  and t1.y+8>t2.y
end
-- handle inputs
function input() 
 if(btn(⬇️))move(cur,0,0.125)
 if(btnp(⬅️))move(cur,-1,0)
 if(btnp(➡️))move(cur,1,0) 
end
--detect it tile 't' will collision or hit boundary 
-- at coordinates x,y 
function det(t,x,y)
 if(x<1 or x>8 or y>16)return true
	if(pt[x][y]==e)return false
	return coll(t,pt[x][y])
end
--general move function for tile 't'
function move(t,dx,dy)
 if(det(t,t.x+dx,ceil(t.y+dy)))return false
 t.x=mid(1,t.x+dx,8)
 t.y=min(t.y+dy,16)
 return true
end
--move cursor to be called in _update 
function mcur()
	local ly=cur.y
 	move(cur,0,0.125)
 	if(ly==cur.y)then
		pt[cur.x][cur.y]=tile(cur)
 		rct(cur.x,cur.y)
 		cur=nxt
 		cur.x=4
 		nxt=tile()
 		tcount+=1
	end
end
-- update played tiles 
-- check for matches and triggers the 
-- cascading movements of
-- 
function utile()
 for r=16,1,-1do
 	for c=8,1,-1do
 	 local tl=pt[c][r]
 	 if(tl~=e)then  -- if tile slot isn't empty
  	 local ly=tl.y -- save last Y position
 	   move(tl,0,0.125)  -- move tile down
 	   -- if Y pos stays the same, tile cannot move any further
		 -- so we trigger react check
		 if(ly==tl.y) then 
		  --if the previous 'if' is true, the next two lines update the same slot.
		  --although inneficient, it saves me a couple of lines 
			pt[c][r]=e     -- empty previous slot used by tile
			pt[c][tl.y]=tl -- set tile in new slot
			rct(c,tl.y)
		 end
   end
  end
 end
end

-->8
-- draws all tiles: current, next and played
function dgame() 
	dtile(cur)
	dtile(nxt)
	for c=8,1,-1do
		for r=16,1,-1do
   local tl=pt[c][r]
		 if(tl~=e)dtile(tl)
		end
	end
end
-- draws one tile
-- the x and y pos represent the slots in the 8x16 playable area
-- this draw function convers those values to the correct pixel in the screen
function dtile(t)	
 rectfill(32+((t.x-1)*8),(t.y-1)*8,
 32+(t.x*8)-1,t.y*8-1,t.clr)end
-->8

-- determines if there are reactions around the slot x,y
function rct(x,y)
 local p=pt[x][y]
 if(p==e)return
 if(y==1)over=true
 local ra={}
 if(x>1 and chk(x-1,y,p.clr))add(ra,pt[x-1][y])
 if(x<8 and chk(x+1,y,p.clr))add(ra,pt[x+1][y])
 if(y<16 and chk(x,y+1,p.clr))add(ra,pt[x][y+1])
	if(#ra>0)then
	 pt[x][y]=e
	 for a in all(ra)do	 
	  pt[a.x][a.y]=e end
	 key()
	end
end
-- checks the if slot x,y with color 'c' matches any of the keys
function chk(x,y,c)
 return pt[x][y]~=e and
  ((pt[x][y].clr==k[1] and c==k[2]) 
  or
  (pt[x][y].clr==k[2] and c==k[1]))
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
