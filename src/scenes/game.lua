game_scene=scene:extend({
	init=function(_ENV)
    global.score=0
    board:init()
    board:setup()
    key=entity:extend()
    refresh_key()
    cur=tile:random(4)
    nxt=tile:random()
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

	draw=function(_ENV)entity:each("draw")end,
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