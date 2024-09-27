e=-1 -- represents an empty slot for a tile
over=false -- gameover flag
clrs={2,3,8,9} -- tile's colors
tcount=0 -- tile count
score=0
tsp=0.125 -- tile down speed

board=nil
cur=nil    -- current tile in play
nxt=nil    -- next tile
key={}     -- current matching combination

--states
init_state=0
game_state=1
over_state=2

--tile states
idle=  10
move=  20
parked=30