tile=entity:extend({
  --position
  x=1,
  y=1,
  w=1,
  h=1,
  --element and state
  elem=rnd(elems),
  state=global.idle,
  --draw
  clr=rnd(clrs),
  sx=8,
  sy=0,

  move=function(_ENV,dx,dy)
    local nx=mid(1,x+dx,max_col)
	  local ny=min(y+dy,max_row)
    if(board:is_empty(nx,ceil(ny)))then
      x,y=nx,ny --update tile position
      state=global.move
      if(y==max_row)state=global.parked
    else
      y=flr(ny)
      state=global.parked 
    end
    return(state==global.move)
  end,

  update=function(_ENV)
    if(state==global.move and (t()*10)\1%2==0)move(_ENV,0,tsp)
  end,

  draw=function(_ENV) 
    rectfill(scr_l+((x-1)*16),scr_t+(y-1)*16,
        scr_l+(x*16)-1,scr_t+(y*16)-1,clr) 
    sspr(sx,sy,16,16,scr_l+((x-1)*16),scr_t+(y-1)*16)
  end,
})

function random_tile(_ENV,_x,_y)
  local elem=rnd(elems)
  local tbl={x=_x,y=_y,elem=elem}
  if(elem==electro)tbl=adds_kv(tbl,sprites.electro)
  if(elem==dendro)tbl=adds_kv(tbl,sprites.dendro)
  if(elem==pyro)tbl=adds_kv(tbl,sprites.pyro)
  if(elem==geo)tbl=adds_kv(tbl,sprites.geo)
  if(elem==anemo)tbl=adds_kv(tbl,sprites.anemo)
  if(elem==hydro)tbl=adds_kv(tbl,sprites.hydro)
  if(elem==cryo)tbl=adds_kv(tbl,sprites.cryo)
  return tile(tbl)
end

function dirt_tile(_ENV,_x,_y)return tile(adds_kv({x=_x,y=_y,elem=nil},sprites.dirt))end
function rock(_ENV,_x,_y)return tile(adds_kv({x=_x,y=_y,elem=nil},sprites.rock))end