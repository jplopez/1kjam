game_scene=scene:extend({
	init=function(_ENV)
		elems={hydro,pyro}
    global.score=0
    board:init()
    board:setup()
    key=entity:extend()
    refresh_key(_ENV, {sprites.hydro,sprites,pyro})
    cur=random_tile(_ENV,4,1)
    nxt=random_tile(_ENV,1,1)
		tcount=0
		enemies = {}
		create_enemies(_ENV)
	end,

	create_enemies=function(_ENV)
		board:set(1,max_row,dirt_tile(_ENV))
		board:set(2,max_row,dirt_tile(_ENV))
		board:set(6,max_row,dirt_tile(_ENV))
		local hc=hydro_hilichurl(_ENV)
		board:set(4,max_row,hc)
		add(enemies,hc)
	end,

	update=function(_ENV)
		entity:each("update")
    input(_ENV)
    update_current(_ENV)
		-- check win state
		-- if #heart.pool==0 then
		-- 	scene:load(win_scene)
		-- end
		-- check game over state
		if(cur.y==1 and cur.state==global.parked) then
		 	scene:load(lose_scene)
		end
	end,

	draw=function(_ENV)draw_ui(_ENV)entity:each("draw")end,
})

-- handle inputs
function input(_ENV)
	if (btn(⬇️)) cur:move(0,tsp*2)
	if (btnp(⬅️)) cur:move(-1,0)
	if (btnp(➡️)) cur:move(1,0)
end

--add cur to board, move next to cur
function update_current(_ENV)
	if(cur.state==parked)then
		board:set(cur.x,cur.y,tile(cur))
		react(_ENV,cur.x,cur.y)
    cur:destroy()
		cur=nxt
		cur.x=4
		cur.state=move
		nxt=random_tile(_ENV,1,1)
		tcount+=1
	end
end

function draw_ui(_ENV)
	-- playable area
	rectfill(scr_l,scr_t,scr_r-1,scr_b-1,7)
	-- ui
	?"key:",1,1,7
	rectfill(17,1,21,5,elem_clr(_ENV,key[1]))
	rectfill(23,1,27,5,elem_clr(_ENV,key[2]))
	?"next:",1,8,7
	rectfill(23,8,27,12,nxt.clr)
	?"tiles\n "..pad(tcount,4),97,1,7
	--debug
	-- rectfill(0,20,7,25,7)
	-- for c=1,8 do
	-- 	for r=1,16 do
	-- 		local clr=(board:is_empty(c,r) and 7 or board:get(c,r).clr)
	-- 		pset(c-1,19+r,clr)
	-- 	end
	-- end
end

function elem_clr(_ENV,elem)
  if(elem==electro)return sprites.electro.clr
  if(elem==dendro)return sprites.dendro.clr
  if(elem==pyro)return sprites.pyro.clr
  if(elem==geo)return sprites.geo.clr
  if(elem==anemo)return sprites.anemo.clr
  if(elem==hydro)return sprites.hydro.clr
  if(elem==cryo)return sprites.cryo.clr
end