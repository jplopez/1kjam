hilichurl=tile:extend({

  weak={},
  resist={},
  life=1,

  update=function (_ENV) end,

  --draw=function (_ENV) end,

  --destroy=function (_ENV)end,

  weak_to=function(_ENV,elem)
    for e in all(weak)do 
      if(e==elem)return true 
    end 
    return false 
  end,

  resists=function(_ENV,elem) 
    for e in all(resist)do 
      if(e==elem)return true 
    end 
    return false
  end,
})

function electro_hilichurl(_ENV,_x,_y)return hilichurl(adds_kv(adds_kv({x=_x,y=_y},sprites.electro_h),enemies_attr.electro_h))end
function hydro_hilichurl(_ENV,_x,_y)return hilichurl(adds_kv(adds_kv({x=_x,y=_y},sprites.hydro_h),enemies_attr.hydro_h))end
function pyro_hilichurl(_ENV,_x,_y)return hilichurl(adds_kv(adds_kv({x=_x,y=_y},sprites.pyro_h),enemies_attr.pyro_h))end
