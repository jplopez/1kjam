pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
e=-1
over=false
clrs={2,3,8,9}
tcount=0
function _init()
 pt={}
 for c=1,8do
 	local row={}
		for r=1,16do add(row,e)end
 	add(pt,row)
	end
 cur=tile({x=4})
 nxt=tile()
 key()
end

function _update() 
	mcur()
 input()
 utile()
end

function _draw() 
	cls()
	rectfill(32,0,95,127,7)
	print("next:",12,1,7)
	print("tiles\n  "..tcount,97,1,7)
	print("key:",1,8,7)
	rectfill(17,8,21,12,k[1])
	rectfill(23,8,27,12,k[2])
	if(over)then
	 print("gameover",48,60,8)
	else dgame()end 
end
-->8
function tile(t)
 t=t or {}
 return {x=t.x or 1,y=t.y or 1,
		clr=t.clr or rnd(clrs)}
end

function key() k={rnd(clrs),rnd(clrs)}end

function coll(t1,t2)
 if(t1==nil or t2==nil)return false
 return t1.x<t2.x+8
  and t1.x+8>t2.x 
  and t1.y<t2.y+8
  and t1.y+8>t2.y
end

function input() 
 if(btn(⬇️))move(cur,0,0.125)
 if(btnp(⬅️))move(cur,-1,0)
 if(btnp(➡️))move(cur,1,0) 
end

function det(t,x,y)
 if(x<1 or x>8 or y>16)return true
	if(pt[x][y]==e)return false
	return coll(t,pt[x][y])
end

function move(t,dx,dy)
 if(det(t,t.x+dx,ceil(t.y+dy)))return false
 t.x=mid(1,t.x+dx,8)
 t.y=min(t.y+dy,16)
 return true
end

function mcur()
 local ly=cur.y
 move(cur,0,0.125)
 if(ly==cur.y)then
		pt[cur.x][cur.y]=tile(cur)
 	rct(cur.x,cur.y)
 	cur=nxt
 	cur.x=4
 	nxt=tile()
 	tcount+=1end
end

function utile()
 for r=16,1,-1do
 	for c=8,1,-1do
 	 local tl=pt[c][r]
 	 if(tl~=e)then
  	 local ly=tl.y
 	  move(tl,0,0.125)
 	  if(ly==tl.y)then
 	  pt[c][r]=e
 	  pt[c][tl.y]=tl
 	  rct(c,tl.y)end
   end
  end
 end
end

-->8
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
function dtile(t)	
 rectfill(32+((t.x-1)*8),(t.y-1)*8,
 32+(t.x*8)-1,t.y*8-1,t.clr)end
-->8
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
