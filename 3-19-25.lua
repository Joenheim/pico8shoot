function _init()
    cls(0)
    mode="start"
    blinkt=1
end

function drawmyspr(myspr) --new funtion for drawing sprites
spr(myspr.spr,myspr.x,myspr.y)
end

function starfield()
    for i=1,#stars do
        local mystar=stars[i]
        local scol=7

        if mystar.spd<0.75 then
            scol=1
        elseif mystar.spd<1 then
            scol=2
        elseif mystar.spd<1.5 then
            scol=13
        end

        pset(mystar.x,mystar.y,scol)
    end    
end

--[[ 
function catfield()
    cx={}
    cy={}
    for i=1,5 do
        add(cx,flr(rnd(100)+10))
        add(cy,flr(rnd(100)+10))
    end

    for j=1,5 do
        spr(51,cx[j],cy[j])
    end
end
]]

function blink() --blinking text
    local banim={5,5,6,6,7,7,6,6,5,5}
    if blinkt>#banim then
        blinkt=1
    end
    return banim[blinkt]
end

function animatestars() --stars animation
    for i=1, #stars do
        local mystar=stars[i]
        mystar.y=mystar.y+mystar.spd
        if mystar.y>128 then
            mystar.y=mystar.y-128
        end
    end
end

function swarm() --enemy swarm movement and animation
    for en in all(enswarm) do
        en.y+=en.spd
        en.x+=0
        en.spr+=0.25
        if en.spr>=23 then
            en.spr=20
        end
        if en.y>130 then
            del(enswarm,en)
        elseif en.x>130 or en.x<-5 then
            del(enswarm,en)
        end 
    end
end

function swarm2() --enemy sawrm 2 movement and animation
    for en in all(enswarm2) do
        en.y+=en.spd
        en.x-=2
        en.spd+=0.001
        en.spr+=.10
        if en.spr>=39 then
            en.spr=36
        end
        if en.y>130 or en.y<-5 then
            del(enswarm2,en)
        elseif en.x<-3 then 
            en.x+=128
        end
    end
end

function update_game()
    cls(0)
    --ship sprite neutral reset
    ship.spr=2
    --flame animation
    flamespr+=1
    if flamespr>8 then
        flamespr=4
    end

   swarm()
   swarm2()

    --muzzle flash
    if mz>0 then
        mz=mz-2
    end
  
    --ship movement
    if btn(0) then  
        ship.x-=2
        ship.spr=1
    end
    if btn(1) then
        ship.x+=2
        ship.spr=3
    end
    if btn(2) then 
        ship.y-=2
    end
    if btn(3) then
        ship.y+=2
    end
    --shooting
    if btnp(4) then
        local newbul={}
        newbul.x=ship.x
        newbul.y=ship.y-5
        newbul.spr=51
        add(buls2,newbul)
        sfx(1)
    end 
    
    if btnp(5) then
        local newbul={}
        newbul.x=ship.x
        newbul.y=ship.y-4
        newbul.spr=9
        add(buls,newbul)
        sfx(0)
        mz=3
    end
    --moving the bullets
    --bullet 1 all loop
    for mybul in all(buls) do
        local speed=4
        mybul.y=mybul.y-speed
        if mybul.y<-8 then
            del(buls,mybul)
        end
    end

   --bullet 2 all loop in buls2
    for mybul in all(buls2) do 
        local speed=2
        mybul.y=mybul.y-speed
        mybul.x=mybul.x-speed

        if mybul.y<-8 or mybul.x<-8 then     
            del(buls2,mybul)
        end
    end

    --moving enemy1 with all loop
    for en in all(en1) do
        en.y+=1
        en.spr+=0.2
        if en.spr>=23 then
            en.spr=20
        end
        if en.y>128 then
            del(en1,en)
        end
    end

    

    --map boundaries, could prob do this better
    if ship.x>120 then
        ship.x=120
    end
    if ship.x<0 then
        ship.x=0
    end
    if ship.y>120 then
        ship.y=120
    end
    if ship.y<0 then
        ship.y=0
    end    
end

function update_start() --start screen
    if btnp(4) or btnp(5) then
        mode="splash"
    end
end

function update_gover() --game over
    if btnp(4) or btnp(5) then
        mode="start"
    end
end

function update_splash() --splash screen
    if btnp(4) or btnp(5) then
        startgame()
    end
end

function _update() --game mode stuff
    blinkt+=1

    if mode =="game" then
        update_game()
    elseif mode=="start" then
        update_start()
    elseif mode=="gover" then
        update_gover()
    elseif mode=="splash" then
        update_splash()
    end
end

function draw_game()
    cls()
    starfield()
    animatestars()
    drawmyspr(ship)
   
    --drawing bullets
    --bullet 1
    for mybul in all(buls) do
        drawmyspr(mybul)
    end
    --bullet 2
    for mybul in all(buls2) do
        drawmyspr(mybul)
    end

    --drawing enemies
    for en in all(en1) do
        drawmyspr(en)
    end

    --drawing enemy swarm
    for en in all(enswarm) do
        drawmyspr(en)
    end
    --drawing second swarm
    for en in all(enswarm2) do
        drawmyspr(en)
    end


        --engine fire location
     spr(flamespr,ship.x,ship.y+8) 

    --bullet 1 muzzle flash
    if mz>0 then 
        circfill(ship.x+3,ship.y-2,mz,7)
    end


    --score test placeholder
    print("score: "..score,40,1,12) 

    --hp
    hp=2
    for i=1,4 do
        if hp>=i then
            spr(16,i*9+80,1)
        else 
            spr(17,i*9+80,1)
        end
    end

    --bombs
    bomb=3
    for i=1,4 do
        if bomb>=i then
            spr(18,i*7,1)
        else
            spr(19,i*7,1)
        end
    end
    
end

function draw_start() --start screen
    cls(1)
    print("tane's galactic quest",20,40,12)
    print("press butan",36,64,blink())
end

function draw_gover() --game over screen
    cls(5)
    print("you have died like a noob",20,20,8)
    print("pres butan to restart",15,40,13)
end

function draw_splash()
    cls(14)
    --catfield()
    print("level 1", 64,64,7)
    spr(51,20,40)
end

function _draw()
    if mode=="game" then
        draw_game()
    elseif mode=="start" then
        draw_start()
    elseif mode=="gover" then
        draw_gover()
    elseif mode=="splash" then
        draw_splash()
    end
end

function startgame() --starting the game
    mode="game"

    ship={x=64,y=64,spr=2}

    flamespr=4 --flame sprite
    mz=0 --muzzle flash state
     
    score=10000

    --star coords and speed
    stars={}
    for i=1,100 do
        local newstar={}
        newstar.x=flr(rnd(128))
        newstar.y=flr(rnd(128))
        newstar.spd=(rnd(1.5)+0.5)
        add(stars,newstar)
    end

    --empty bullets tables
    buls={}
    buls2={}
    
    --single enemy spawn
    en1={} 
    local myen={}
    myen.x=60
    myen.y=10
    myen.spr=20
    add(en1,myen)

    --trying enemy swarm, coords and speed
    enswarm={} --array to pull from swarm()
        for i=1,10 do
            local en={}
            en.x=flr(rnd(112)+8)
            en.y=flr(rnd(10)-40)
            en.spr=20
            en.spd=rnd(1.0)+0.75
            add(enswarm,en)
        end
    
    enswarm2={} --enemies for swarm2()
        for i=1,5 do
            local en={}
            en.x=flr(rnd(128))
            en.y=flr(rnd(5))
            en.spr=36
            en.spd=rnd(1)
            add(enswarm2,en)
        end





 end
