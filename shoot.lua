function _init()
	cls(0)
	px=64 --x value of ship
	py=64 --y value of ship
	shipspr=2 --ship sprite
	flamespr=4 --flame sprite
	b1x=px --bullet 1 locs
	b1y=-10
	b2x=px -- bullet 2 locs
	b2y=-10
	mz=0 --muzzle flash state
	b1a=9 --bullet 1 anim8
	b2a=25 -- bullet 2 anim8
	b2m=32 --bullet 2 muzzle 
end

function _update()
	cls(0)
	--ship sprite neutral reset
	shipspr=2
	--flame animation
	flamespr=flamespr+1
	b2m=b2m
	if flamespr>8 then
 	flamespr=4
	--bullet 1 animation
	b1a=b1a+1
	if b1a>13 then
		b1a=11
	end
	--bullet 2 animation
	b2a=b2a+1
	if b2a>28 then
		b2a=25
	end
	--muzzle flash
	if mz>0 then
		mz=mz-2
	end
	--bullet 2 muzzle animation
	b2m=b2m+1
		if b2m>30 then
			b2m=31
		end
	end 
	--ship movement
	if btn(0) then  
		px=px-2
		shipspr=1
	end
	if btn(1) then
		px=px+2
		shipspr=3
	end
	if btn(2) then 
		py=py-2
	end
	if btn(3) then
		py=py+2
	end
--shooting
	if btnp(4) then
		b2y=py-5
		b2x=px
		sfx(1)
		b2m=29
	spr(b2m,px,py-6)
	end
	
	if btnp(5) then
		b1y=py-4
		b1x=px
		sfx(0)
		mz=3
	end
b1y=b1y-4 --bullet speed	
b2y=b2y-2	
--map boundaries
	if px>120 then
		px=120
	end
	if px<0 then
		px=0
	end
	if py>120 then
		py=120
	end
	if py<0 then
		py=0
	end	
end

function _draw()
	spr(shipspr,px,py) --ship sprite
	spr(b1a,b1x,b1y) --bullet 1 animation
	spr(b2a,b2x,b2y) --bullet 2 animation
	spr(flamespr,px,py+8) --flame animation
	if mz>0 then --bullet 1 muzzle flash
		circfill(px+3,py-2,mz,7)
	end
	spr(b2m,px,py-6) --bullet 2 muzzle flash animation
end
