tile=entity:extend({
  x=1,
  y=16,
  w=1,
  h=1,
  clr=rnd(clrs),

  move=function(_ENV,dx,dy)
    local nx,ny=x+dx,x+dy -- next position
    if(nx<1 or nx>8 or ny>16) return false -- screen boundaries
    local next_pos=pt[ceil(nx)][ceil(ny)]
    if(next_pos==e) then
      x,y=nx,ny --update tile position
      return true
    else return false -- no move
    end
  end,

  update=function(_ENV) 
    return move(_ENV,0,0.125)
  end,

  draw=function(_ENV)  
    rectfill(32+((x-1)*8),(y-1)*8,
    32+(x*8)-1,y*8-1,clr) 
  end,

})