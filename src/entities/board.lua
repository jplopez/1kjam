board=entity:extend({

--  max_row=16,
--  max_col=8,
  tiles={},

  setup=function(_ENV)
    tiles={}
    for c=1,max_col do
      local col={}
      for r=1,max_row do add(col,e) end
      add(tiles,col)
    end
  end,

  --game loop
  update=function(_ENV)
    --l("update board")
    for r=max_row,1,-1 do
      for c=max_col,1,-1 do
        if(tiles[c][r]~=global.e)then
          local tl=tiles[c][r]
          tl:move(0,tsp*2)
          if(tl.state==global.parked) then
            if(tl.y~=r) then
              tl.state=idle
              tiles[c][tl.y]=tl
              destroy(_ENV,c,r)
              --tiles[c][r]=global.e
              react(_ENV,c,tl.y)
            end
          end
        end
      end
    end  
  end,

  --accessors
  get=function(_ENV,x,y)return tiles[x][y]end,
  set=function(_ENV,x,y,value)
    if(value~=e)then
      value.x,value.y=x,y end 
    tiles[x][y]=value 
  end,
  is_empty=function(_ENV,x,y)return tiles[x][y]==e end,

  move=function(_ENV,x,y,dx,dy)
    local tl=tiles[x][y]
    if(tl==global.e)return false
    local nx=mid(1,x+dx,8)
	  local ny=min(y+dy,16)
    if(tiles[nx][ceil[ny]]==global.e)tl:move(dx,dy)
    return (tl.state==global.move)
  end,

  destroy=function(_ENV,x,y) 
    if(x and y) then 
      local tl=tiles[x][y]
      tiles[x][y]=global.e
    else entity:destroy() end
  end
})