initstate={
  enter=function(_ENV)
    for c=1,8do
    local row={}
     for r=1,16do add(row,e)end
    add(pt,row)
   end
    cur=tile({x=4}) -- current tile in play
    --l(serialize(cur),true)
    nxt=tile() -- next tile
    key() -- generates the key 
  end,

  exit=noop
}