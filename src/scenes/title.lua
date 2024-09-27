title_scene=scene:extend({
	init=function(_ENV)
		frame=0
	end,

	update=function(_ENV)
		entity:each("update")
	
		if btnp(❎) then
			scene:load(game_scene)
		end
		
		-- spawn spark each 4/10 sec
		-- if (t()*10)\1%4==0 then
		-- 	title_heart:create_spark()
		-- end
	end,

	draw=function()
		-- draw entities
		entity:each("draw")		
		-- title
		printo("t",54,7,2,13)
		printo("i",60,7,3,11)
		printo("l",66,7,8,14)
		printo("e",72,7,9,10)
		printo("s",78,7,1,12)
				
		-- prompt
		printc("❎ start game",96,7)
	end,
})