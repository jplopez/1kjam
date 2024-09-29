tile=entity:extend({
  x=1,
  y=1,
  w=1,
  h=1,
  clr=rnd(clrs),
  state=global.idle,

  -- utility constructors for current and next
  random=function(_ENV,_x,_y) 
    return tile({x=_x or 1, y=_y or 1,
        clr=rnd(clrs),state=global.idle}) 
  end,

  move=function(_ENV,dx,dy)
    local nx=mid(1,x+dx,8)
	  local ny=min(y+dy,16)
    if(board:is_empty(nx,ceil(ny)))then
      x,y=nx,ny --update tile position
      state=global.move
      if(y==16)state=global.parked
    else
      y=flr(ny)
      state=global.parked 
    end
    return(state==global.move)
  end,

  update=function(_ENV)if(state==global.move)move(_ENV,0,tsp)end,

  draw=function(_ENV) 
    rectfill(32+((x-1)*8),(y-1)*8,
        32+(x*8)-1,y*8-1,clr) 
  end,
})