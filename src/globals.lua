e=-1 -- represents an empty slot for a tile
over=false -- gameover flag
clrs={2,3,8,9} -- tile's colors
tcount=0 -- tile count
score=0
tsp=0.06 -- tile down speed
-- playable screen boundaries
scr_l=15
scr_r=111
scr_t=15
scr_b=127

max_col=(scr_r-scr_l)/16
max_row=(scr_b-scr_t)/16
--entities
board=nil
cur=nil    -- current tile in play
nxt=nil    -- next tile
key={}     -- current matching combination
--states
init_state=0
game_state=1
over_state=2
--tile states
idle=10
move=20
parked=30

-- elements
anemo=100
geo=200
electro=300
dendro=400
hydro=500
pyro=600
cryo=700
elems={anemo,geo,electro,dendro,hydro,pyro,cryo}
--sprites
sprites={
 anemo = {sx=8,sy=0,clr=12}, 
 geo = {sx=24,sy=0,clr=9}, 
 electro = {sx=40,sy=0,clr=2}, 
 dendro = {sx=56,sy=0,clr=3}, 
 hydro = {sx=8,sy=16,clr=1}, 
 pyro = {sx=24,sy=16,clr=8}, 
 cryo = {sx=40,sy=16,clr=6}, 

 dirt = {sx=72,sy=0,clr=0}, 
 rock = {sx=88,sy=0,clr=0}, 
 electro_h = {sx=88,sy=16}, 
 hydro_h = {sx=56,sy=16,clr=0},
 pyro_h = {sx=72,sy=16},
}
-- enemies attributes
enemies_attr={
  electro_h = {life=1,elem=electro,weak={dendro,cryo,hydro},resist={electro}}, 
  hydro_h = {life=1,elem=hydro,weak={electro,pyro,dendro},resist={hydro}},
  pyro_h = {life=1,elem=pyro,weak={cryo,hydro},resist={pyro}},
}