function _init()
    cls(0)
    mode="start"
    blinkt=1
    t=0
end

--functions
function drawmyspr(myspr) --new funtion for drawing sprites
    spr(myspr.spr,myspr.x,myspr.y)
end

--spawn powerups
    function spawn_powerup()
        local powerup={}
        powerup.x=flr(rnd(120))
        powerup.y=flr(rnd(120))
        powerup.spr=49
        powerup.type="shield"

        add(powerups,powerup)
    end
--collision function
function col(a,b)
    local a_left=a.x
    local a_top=a.y
    local a_right=a.x+7
    local a_bottom=a.y+7

    local b_left=b.x
    local b_top=b.y
    local b_right=b.x+7
    local b_bottom=b.y+7

    if a_top>b_bottom then return false end
    if b_top>a_bottom then return false end
    if a_left>b_right then return false end
    if b_left>a_right then return false end

    return true
end

--shieldbar
    function draw_shield()
        rect(90,10,120,15,7)
        if shield >0 then
            rectfill(92,12,92+(shield/100*26),13,12)
        end
        print(shield,75,10) --to measure value
    end


--enemy explosion
function explode(expx,expy,isblue)
   
    local myp={}
        myp.x=expx
        myp.y=expy
        myp.sx=0
        myp.sy=0
        myp.age=0
        myp.size=10  --initial white circle size
        myp.maxage=0
        myp.blue=isblue

        add(parts,myp)

    for i=1,30 do
        local myp={}
        myp.x=expx
        myp.y=expy
        myp.sx=(rnd()-0.5)*6
        myp.sy=(rnd()-0.5)*6
        myp.age=rnd(3)
        myp.size=1+rnd(3)
        myp.maxage=10+rnd(10)
        myp.blue=isblue

        add(parts,myp)
    end

    big_shwave(expx,expy)

end

function explode2(expx,expy)
   
    for i=1,30 do
        local myp={}
        myp.x=expx
        myp.y=expy
        myp.sx=(rnd()-0.5)*8
        myp.sy=(rnd()-0.5)*8
        myp.age=rnd(3)
        myp.maxage=10
       
        add(parts2,myp)
    end

end

--sparks for bul1
function csparks(expx,expy)
    for i=1,5 do
        local myp={}
        myp.x=expx
        myp.y=expy
        myp.sx=(rnd()-0.5)*6
        myp.sy=(rnd()-0.5)*6
        myp.age=rnd(3)
        myp.size=1+rnd(3)
        myp.maxage=10+rnd(10)

        add(sparks,myp)
    end
end


function page_red(page)
    local col=7
    if page>15 then
        col=5
    elseif page>12 then
        col=2
    elseif page>9 then
        col=8
    elseif page>7 then
        col=9
    elseif page>5 then
        col=10
    end
    return col
end

function page_blue(page)
    local col=7
    if page>15 then
        col=1
    elseif page>12 then
        col=1
    elseif page>9 then
        col=13
    elseif page>7 then
        col=12
    elseif page>5 then
        col=7
    end
    return col
end

function smol_shwave(shx,shy)
    local mysw={}
    mysw.x=shx+4
    mysw.y=shy+4
    mysw.r=3
    mysw.tr=6
    mysw.col=9
    mysw.spd=1
    add(shwaves,mysw)
end

function big_shwave(shx,shy)
    local mysw={}
    mysw.x=shx
    mysw.y=shy
    mysw.r=3
    mysw.tr=25
    mysw.col=7
    mysw.spd=3.5
    add(shwaves,mysw)
end

--bullet 1 explosion
 function bulx(bulxx,bulxy)
    local myex={}
    myex.x=bulxx
    myex.y=bulxy
    myex.age=1
    add(bulex,myex)
 end
--bullet 2 explosion
function bulx2(bulxx,bulxy)
    local myex={}
    myex.x=bulxx
    myex.y=bulxy
    myex.age=1
    add(bulex2,myex)
end

--spawning enemies
function spawnen()
    local myen={}
    myen.x=rnd(120)
    myen.y=-8
    myen.spr=20
    myen.hp=5
    myen.flash=0

    add(en1,myen)
end

function spawnen2()
    local myen={}
    myen.x=(rnd(20)-40)
    myen.y=rnd(128)
    myen.spr=36
    myen.hp=3
    myen.flash=0

    add(en2,myen)
end

function spawnen3()
    local myen={}
    myen.x=rnd(120)
    myen.y=(rnd(50)+135)
    myen.hp=2
    myen.spr=33
    myen.flash=0

    add(en3,myen)
end

function spawnen4()
    local myen={}
    local myen={}
    myen.x=120
    myen.y=120
    myen.spr=54
    myen.hp=4
    myen.flash=0

    add(en4,myen)
end

--drawing the starfield
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

--blinking text
function blink() 
    local banim={5,5,6,6,7,7,6,6,5,5}
    if blinkt>#banim then
        blinkt=1
    end
    return banim[blinkt]
end

--stars animation
function animatestars()
    for i=1, #stars do
        local mystar=stars[i]
        mystar.y=mystar.y+mystar.spd
        if mystar.y>128 then
            mystar.y=mystar.y-128
        end
    end
end

--gammplay update stuff
function update_game()
    cls(0)
    --ship sprite neutral reset
    ship.spr=2

    --powerup spawn
    if t%100 == 0 then
        spawn_powerup()
    end

    --flame animation
    flamespr+=1
    if flamespr>8 then
        flamespr=4
    end

    --muzzle flash
    if mz>0 then
        mz=mz-2
    end
  
    --ship movement
    if btn(0) then  
        ship.x-=ship.spd
        ship.spr=1
    end
    if btn(1) then
        ship.x+=ship.spd
        ship.spr=3
    end
    if btn(2) then 
        ship.y-=ship.spd
    end
    if btn(3) then
        ship.y+=ship.spd
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

    --shooting
    if btn(4) then
        if bultimer<=0 then
        local newbul={}
        newbul.x=ship.x
        newbul.y=ship.y-5
        newbul.spr=9
        add(buls2,newbul)
        sfx(1)
        bultimer=10
        end
    end 
    bultimer-=1

    if btn(5) then
        if bultimer<=0 then
        local newbul={}
        newbul.x=ship.x
        newbul.y=ship.y-4
        newbul.spr=25
        add(buls,newbul)
        sfx(0)
        mz=3
        bultimer=6
        end
    end
    bultimer-=1

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
            spawnen()
        end
    end

    --moving enemies2
    for en in all(en2) do
        en.y+=0.1
        en.x+=1
        en.spr+=0.10
        if en.spr>=39 then
            en.spr=36
        end
        if en.x>=125 then
            en.x=-3
        end

        if en.y>128 then
            del(en2,en)
            spawnen2()
        end
    end

    --moving enemy 3
    for en in all(en3) do
        en.y-=1
        en.x-=.5
        en.spr+=0.25
        if en.spr>=36 then 
            en.spr=33
        end
        if en.y<-3 then
            en.y=125
        end
        if en.x<-3 then
            en.x=125
        end
    end

    --moving enemy 4
    for en in all(en4) do
        en.y+=0
        en.x+=0
        en.spr+=0.25
        if en.spr>=58 then
            en.spr=54
        end
    end


    --collision bullets x enemies
    --bullet 1 enemy 1
    for en in all(en1) do
        for mybul in all(buls) do
            if col(en, mybul) then
                sfx(5)
                del(buls,mybul)
                csparks(en.x+4,en.y+4)
                smol_shwave(mybul.x,mybul.y)
                en.hp-=1
                en.flash=2
                if en.hp<=0 then
                    sfx(4)
                    del(en1,en)
                    spawnen()
                    score+=1
                    explode(en.x+4,en.y+4)
                    explode2(en.x+4,en.y+4)
                end
            end
        end
    end
    --bullet 2 enemy 1
    for en in all(en1) do
        for mybul in all(buls2) do
            if col(en, mybul) then
                sfx(5)
                del(buls2,mybul)
                bulx2(en.x+4,en.y+4)
                csparks(en.x+4,en.y+4)
                en.hp-=1
                en.flash=2
                if en.hp<=0 then
                    sfx(4)
                    del(en1,en)
                    spawnen()
                    score+=1
                    explode(en.x+4,en.y+4)
                    explode2(en.x+4,en.y+4)
                end
            end
        end
    end

    --bullet 1 enemy 2
    for en in all(en2) do
        for mybul in all(buls) do
            if col(en, mybul) then
                sfx(5)
                del(buls,mybul)
                csparks(en.x+4,en.y+4)
                smol_shwave(mybul.x,mybul.y)
                en.hp-=1
                en.flash=2
                if en.hp<0 then
                sfx(4)
                del(en2,en)
                spawnen2()
                score+=1
                explode(en.x,en.y)
                explode2(en.x+4,en.y+4)
                end
            end
        end
    end
    -- bullet 2 enemy 2
    for en in all(en2) do
        for mybul in all(buls2) do
            if col(en, mybul) then
                sfx(5)
                del(buls2,mybul)
                csparks(en.x+4,en.y+4)
                bulx2(mybul.x,mybul.y)
                en.hp-=1
                en.flash=2
                if en.hp<=0 then
                    sfx(4)
                    del(en2,en)
                    spawnen2()
                    score+=1
                    explode(en.x,en.y)
                    explode2(en.x+4,en.y+4)
                end
            end
        end
    end

    --bullet 1 enemy 3

    for en in all(en3) do
        for mybul in all(buls) do
            if col(en, mybul) then
                sfx(5)
                del(buls,mybul)
                csparks(en.x+4,en.y+4)
                smol_shwave(mybul.x,mybul.y)
                en.hp-=1
                en.flash=2
                if en.hp<=0 then
                    sfx(4)
                    del(en3,en)
                    spawnen3()
                    score+=1
                    explode(en.x+4,en.y+4)
                    explode2(en.x+4,en.y+4)
                end
            end
        end
    end

    --bullet 2 enemy 3

    for en in all(en3) do
        for mybul in all(buls2) do
            if col(en, mybul) then
                sfx(5)
                del(buls2,mybul)
                csparks(en.x+4,en.y+4)
                bulx2(mybul.x,mybul.y)
                en.hp-=1
                en.flash=2
                if en.hp<=0 then
                    sfx(4)
                    del(en3,en)
                    spawnen3()
                    score+=1
                    explode(en.x,en.y)
                    explode2(en.x+4,en.y+4)
                end
            end
        end
    end

    --collision ship x enemies
    if invul<=0 then
        for en in all(en1) do
            if col(en,ship) then
                if shield>=50 then
                    shield-=50
                elseif shield<=0 then       
                hp-=1
                end
                sfx(2)
                explode(ship.x+4,ship.y+4,true)
                invul=60
            end
        end   
        else
            invul-=1
    end

    if invul<=0 then
        for en in all(en2)do
            if col(en,ship) then
                if shield>=50 then
                    shield-=50
                elseif shield<=0 then       
                hp-=1
                end
                sfx(2)
                invul=60
                explode(ship.x+4,ship.y+4,true)
            end
        end 
        else
            invul-=1
    end

    if invul<=0 then
        for en in all(en3)do
            if col(en,ship) then
                if shield>=50 then
                    shield-=50
                elseif shield<=0 then       
                hp-=1
                end
                sfx(2)
                invul=60
                explode(ship.x+4,ship.y+4,true)
            end
        end 
        else
            invul-=1
    end

    if invul<=0 then
        for en in all(en4)do
            if col(en,ship) then
                if shield>=50 then
                    shield-=50
                elseif shield<=0 then       
                hp-=1
                end
                sfx(2)
                invul=60
                explode(ship.x+4,ship.y+4,true)
            end
        end 
        else
            invul-=1
    end

    --powerup collision
    for p in all(powerups) do
        if col(p,ship) then
            if p.type=="shield" then
                shield=min(shield+25,100)
                sfx(6)
            end
            del(powerups,p)
        end
    end

    if hp<=0 then
        mode="gover"
    end

    if mode =="gover" then
        sfx(3)
    end 
end

--start screen
function update_start()
    if btnp(4) or btnp(5) then
        mode="splash"
    end
end

--game over screen
function update_gover()
    if btnp(4) or btnp(5) then
        mode="start"
    end
end

--splash screen
function update_splash()
    if btnp(4) or btnp(5) then
        startgame()
    end
end

function _update()
    t+=1
    blinkt+=1

    --game states
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
    draw_shield()

    if invul<=0 then
        drawmyspr(ship)
    else --invul state
        if sin(t/5)<-0.5 then
            for i=1,15 do
                pal(i,7)
            end
        drawmyspr(ship)
        pal()
        end
    end

       --engine fire location
    if invul<=0 then
       spr(flamespr,ship.x,ship.y+8) 
    else --invul state
        if sin(t/5)<-0.5 then
            spr(flamespr,ship.x,ship.y+8)
        end 
    end

    --drawing bullets
    --bullet 1
    for mybul in all(buls) do
        drawmyspr(mybul)
        mybul.spr+=0.25
        if mybul.spr>=29 then
            mybul.spr=25
        end
    end
    --bullet 2
    for mybul in all(buls2) do
        drawmyspr(mybul)
        mybul.spr+=0.5
        if mybul.spr>=13 then
            mybul.spr=9
        end
    end

    --bullet explosion
    --[[local exframes={41,42}
    for myex in all(bulex) do
        spr(exframes[myex.age],myex.x,myex.y)
            myex.age+=1
                if myex.age>#exframes then
                    del(bulex,myex)
                end
    end
    ]]
    local exframes={58,59,58,59,58,59}
    for myex in all(bulex2) do
        spr(exframes[myex.age],myex.x-2,myex.y)
            myex.age+=1
            if myex.age>#exframes then
                del(bulex2,myex)
            end
    end
    

    --drawing enemies
    for en in all(en1) do
        if en.flash>0 then
            en.flash-=1
            for i=1,15 do
                pal(i,7)
            end
        end
        drawmyspr(en)
        pal()
    end

    for en in all(en2) do
        if en.flash>0 then
            en.flash-=1
            for i=1,15 do
                pal(i,7)
            end
        end
        drawmyspr(en)
        pal()
    end   

    for en in all(en3) do
        if en.flash>0 then
            en.flash-=1
            for i=1,15 do
                pal(i,7)
            end
        end
        drawmyspr(en)
        pal()
    end

    for en in all(en4) do
        if en.flash>0 then
            en.flash-=1
            for i=1,15 do
                pal(i,7)
            end
        end
        drawmyspr(en)
        pal()
    end

    --bullet 1 muzzle flash
    if mz>0 then 
        circfill(ship.x+3,ship.y-2,mz,7)
    end

    --drawing particles
    for myp in all(parts) do
        local pc=7
        
        if myp.blue then
            pc=page_blue(myp.age)
        else
            pc=page_red(myp.age)
        end
            
        circfill(myp.x,myp.y,myp.size,pc)
        myp.x+=myp.sx
        myp.y+=myp.sy
        myp.sx=myp.sx*0.85 --friction
        myp.sy=myp.sy*0.85
        myp.age+=1
            if myp.age>=myp.maxage then
                myp.size-=0.5
                if myp.size<0 then
                del(parts,myp)
                end
            end
        end

    for myp in all(parts2) do
        local pc=7
        if myp.age>15 then
            pc=5
        elseif myp.age>12 then
            pc=2
        elseif myp.age>9 then
            pc=8
        elseif myp.age>7 then
            pc=9
        elseif myp.age>5 then
            pc=10
        end
        pset(myp.x,myp.y,pc)
        myp.x+=myp.sx
        myp.y+=myp.sy
        myp.sx=myp.sx*0.85
        myp.sy=myp.sy*0.85
        myp.age+=1
            if myp.age>myp.maxage then
                del(parts2,myp)
            end

    
    end

    --drawing sparks

    for myp in all(sparks) do
        local pc=7
        if myp.age>15 then
            pc=5
        elseif myp.age>12 then
            pc=2
        elseif myp.age>9 then
            pc=8
        elseif myp.age>7 then
            pc=9
        elseif myp.age>5 then
            pc=10
        end
        pset(myp.x,myp.y,pc)
        myp.x+=myp.sx
        myp.y+=myp.sy
        myp.sx=myp.sx*0.85
        myp.sy=myp.sy*0.85
        myp.age+=2
        if myp.age>myp.maxage then
            del(sparks,myp)
        end  
    end

--drawing powerups
    for p in all(powerups) do
        spr(p.spr,p.x,p.y)
        p.spr+=0.25
        if p.spr>=53 then
            p.spr=49
        end
    end


--drawing shockwaves
    for mysw in all(shwaves) do
        circ(mysw.x,mysw.y,mysw.r,mysw.col)
        mysw.r+=mysw.spd
        if mysw.r>15 then
            mysw.col=6
        end
        if mysw.r>mysw.tr then
            del(shwaves,mysw)
        end
    end

    --score test placeholder
    print("score: "..score,40,1,12) 

    --hp
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

--start screen
function draw_start()
    cls(1)
    print("tane's galactic quest",20,40,12)
    print("press butan",36,64,blink())
end

--game over screen
function draw_gover()
    cls(5)
    print("you have died like a noob",20,20,8)
    print("pres butan to restart",15,40,13)
end

--splash screen
function draw_splash()
    cls(14)
    print("level 1", 64,64,7)
    spr(9,20,40)
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

--starting gameplay stuff
function startgame()
    mode="game"

    t=0

    ship={x=64,y=64,spr=2,spd=2}

    flamespr=4 --flame sprite
    mz=0 --muzzle flash state
    
    bultimer=0

    score=0

    hp=4
    shield=100
    invul=0

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
    en2={}
    en3={}
    en4={}
    --particles
    parts={}
    parts2={}
    sparks={}
    scratches={}
    --bullet explosion
    bulex={}
    bulex2={}
    --
    powerups={}
    --shield booster spawn
    sboost={}
    --shockwave
    shwaves={}
    --enemy spawn
    spawnen()
    spawnen2()
    spawnen3()
    spawnen4()  
 end
