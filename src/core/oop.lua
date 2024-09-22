-- source: https://github.com/kevinthompson/object-oriented-pico-8/blob/main/heartseeker.p8#L293
-- author: https://github.com/kevinthompson 
class=setmetatable({
  extend=function(self, tbl)
    tbl=tbl or {}
    tbl.__index=tbl
    return setmetatable(
      tbl,{__index=self,
        __call=function(self, ...)
          return self:new(...) end })
  end,
  new=function(self,tbl)
    tbl=setmetatable(tbl or {},self)
    tbl:init()
    return tbl
  end,
  init=noop
},{__index=_ENV})

entity=class:extend({
	-- class
	pool={},
	
	extend=function(_ENV,tbl)
		tbl=class.extend(_ENV,tbl)
		tbl.pool={}
		return tbl
	end,

	each=function(_ENV,method,...)
		for e in all(pool) do
			if (e[method]) e[method](e,...)
		end
	end,

	-- instance
	x=0,
	y=0,

	w=8,
	h=8,

	init=function(_ENV)
		add(entity.pool,_ENV)
		if pool!=entity.pool then
			add(pool,_ENV)
		end
	end,

	detect=function(_ENV,other,callback)
		if collide(_ENV,other) then 
			callback(_ENV) 
			return true
		end
		return false
	end,

	collide=function(_ENV,other)
		return x<other.x+other.w and
			x+w>other.x and
			y<other.y+other.h and
			h+y>other.y
	end,

	destroy=function(_ENV)
		del(entity.pool,_ENV)
		if(pool!=entity.pool) del(pool,_ENV)
	end
})