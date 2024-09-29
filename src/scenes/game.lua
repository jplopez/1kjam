game_scene=scene:extend({
	init=function(_ENV)
    global.score=0
    board:init()
    board:setup()
    key=entity:extend()
    refresh_key(_ENV)
    cur=tile:random(4)
    nxt=tile:random()
		tcount=0
		l(cur)l(nxt)
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
		nxt=tile:random()
		tcount+=1
	end
end

function draw_ui(_ENV)
	-- playable area
	rectfill(32,0,95,127,7)
	-- ui
	?"next:",12,1,7
	?"tiles\n "..pad(tcount,4),97,1,7
	?"key:",1,8,7
	rectfill(17,8,21,12,key[1])
	rectfill(23,8,27,12,key[2])
	--debug
	-- rectfill(0,20,7,25,7)
	-- for c=1,8 do
	-- 	for r=1,16 do
	-- 		local clr=(board:is_empty(c,r) and 7 or board:get(c,r).clr)
	-- 		pset(c-1,19+r,clr)
	-- 	end
	-- end
end