title_scene=scene:extend({

	init=function(_ENV)entity:each("destroy")end,

	update=function(_ENV)
		entity:each("update")
		if(btnp(❎))entity:each("destroy")scene:load(game_scene)
		-- spawn spark each 4/10 sec
		if((t()*10)\1%45==0)create_tile(_ENV)
	end,

	draw=function(_ENV)
		-- draw entities
		entity:each("draw")
		-- title
		printo("t",52,37+cos(t()),2,13)
		printo("i",58,37+sin(t()),3,11)
		printo("l",64,37+cos(t()),8,14)
		printo("e",70,37+sin(t()),9,10)
		printo("s",76,37+cos(t()),1,12)	
		-- prompt
		printc("❎ start game",67,6)
	end,

	create_tile=function(_ENV)
		local tl=random_tile(_ENV,1+rnd(7),1)
		tl.update=function(_ENV)
			y+=tsp
			if(y==16)y=1x=1+rnd(7)
		end
	end
})