scene=class:extend({
	current=nil,
	update=noop,
	draw=noop,

	destroy=function(_ENV)entity:each("destroy")end,
	load=function(_ENV,scn)
		if current!=scn then
			if(current)current:destroy()
			current=scn()
		end
	end
})

-- generates the matching key
function refresh_key(_ENV)key={rnd(elems),rnd(elems)}end

function l(text,...)
  local pre=tostr(t())pre=pre..spaces(8-#pre)
  if(type(text)=="table")logger:log(pre)logger:log(text)
  if(type(text)~="table")logger:log(pre..tostr(text))
end

function ln(text)
  local pre=tostr(t())pre=pre..spaces(8-#pre)
  if(type(text)=="table")logger:log(pre,true)logger:log(text)
  if(type(text)~="table")logger:log(pre..text,true)
end

function react(_ENV,x,y)
  l("react "..x..","..y)
  local trigger=board:get(x,y)
  if (y==1)over=true
  local impact={}
  if(x>1)add(impact,board:get(x-1,y))
  if(x<max_col)add(impact,board:get(x+1,y))
  if(y<max_row)add(impact,board:get(x,y+1))
  if #impact>0 then
    local match=false
    for tl in all(impact)do
      if(tl~=e and key_check(_ENV,trigger,tl))board:destroy(tl.x,tl.y)tl:destroy()match=true
    end
    if(match)board:destroy(x,y)trigger:destroy()refresh_key(_ENV)
  end
end

-- checks the if slot x,y with color 'c' matches any of the keys
function key_check(_ENV,tl1,tl2)
  --l("key check")l(tl1)l(tl2)
  return (tl1.elem==key[1] and tl2.elem==key[2])
    or (tl1.elem==key[2] and tl2.elem==key[1])
end

function adds_kv(tbl,kv) 
  for k,v in pairs(kv)do tbl[k]=v end
  return tbl
end

function adds(tbl,tbl2) 
  for v in all(tbl2)do add(tbl,v)end
  return tbl
end
