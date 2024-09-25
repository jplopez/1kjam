tile=entity:extend({
  x=1,
  y=1,
  w=1,
  h=1,
  clr=rnd(clrs),

  state=global.idle,

  -- utility constructors for current and next
  random=function(_ENV,_x,_y) return tile({x=_x or 1, y=_y or 1, clr=rnd(clrs)}) end,

  move=function(_ENV,dx,dy)
    local nx=mid(1,x+dx,8)
	  local ny=min(y+dy,16)
    local next_pos= board:get(nx,ceil(ny))--pt[nx][ceil(ny)]
    if(next_pos==e) then
      x,y=nx,ny --update tile position
      return true
    else return false -- no move
    end
  end,

  update=function(_ENV)
    local ly=y
    if(move(_ENV,0,tsp))then
      state=global.move
      --something
    else 
      if(ly==y)state=global.parked
    end  
  end,

  draw=function(_ENV)  
    rectfill(32+((x-1)*8),(y-1)*8,
    32+(x*8)-1,y*8-1,clr) 
  end,

})