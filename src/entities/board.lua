board=entity:extend({
  max_row=16,
  max_col=8,
  tiles={},
  init=function(_ENV)
    tiles={}
    for c=1,max_col do
      local col={} --column(_ENV)
      for r=1,max_row do add(col,e) end
      add(tiles,a2col(_ENV,col))
    end
  end,

  a2col=function(_ENV, col) 
    col.update=function(_ENV) 
      for t in all(col)do t:update()end end
    col.draw=function(_ENV) 
      for t in all(col)do 
        if(t~=global.e)t:draw()end 
    end
    return col
  end,

  --game loop
  update=function(_ENV)
    for r=board.max_row,1,-1 do
      for c=board.max_col,1,-1 do
        if(not is_empty(_ENV,c,r))then
          local tl=get(_ENV,c,r)
          local ly=tl.y -- save last Y position
          tl:move(0,tsp*2)
          if(ly==tl.y and tl.y~=r) then
            --l("moving "..c..",".. r .."->"..c..","..tl.y)
            set(_ENV,c,r,e) -- empty previous slot used by tile
            set(_ENV,c,tl.y,tl) -- set tile in new slot
            rct(_ENV,c,tl.y)
          end
        end
      end
    end  
  end,

  draw=function(_ENV)
    for col in all(tiles)do col.draw(_ENV)end
  end,

  --accessors
  get=function(_ENV,x,y)return tiles[x][y]end,
  set=function(_ENV,x,y,value)tiles[x][y]=value end,
  is_empty=function(_ENV,x,y)return tiles[x][y]==e end,

  move=function(_ENV,x,y,dx,dy)return get(x,y):move(dx,dy)end,
})

