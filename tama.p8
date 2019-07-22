pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	tama_init()
	menu_init()
	stats_init()
	food_init()
	wash_init()
	play_init()
end

function _update()
 tama_update()
 menu_update()
 stats_update()
 food_update()
 wash_update()
 play_update()
end

function _draw()
	cls()
	tama_draw()
	menu_draw()
	stats_draw()
	food_draw()
	wash_draw()
	play_draw()
end
-->8
function tama_init()
	tama={}
	tama.sprt=1
	tama.tmr=0
	tama.food=false
	tama.wash=false
	tama.play=false
end

function tama_update()
	tama.tmr+=1
	if tama.tmr%15==2 then
		tama.sprt+=1
	end
	if tama.sprt>4 then
		tama.sprt=1
	end
end

function tama_draw()
	spr(tama.sprt,64,64)
end
-->8
function food_init()
	food={}
	food.y=-10
	food.dy=10
	food.sprt=0
	food.tmr=0
end

function food_update()
	if tama.food then
		food.tmr+=1
		if food.tmr%15==2 then
			food.y+=food.dy
		end
		if food.y>64 then
			food.y=-10
			food.tmr=0
			tama.food=false
		end
	end
end

function food_draw()
	spr(food.sprt,64,food.y)
end
-->8
function menu_init()
	menu={}
	menu.y=0
	menu.dy=7
end

function stats_init()
	-- stats={}
	-- stats.food=110
	-- stats.wash=100
	-- stats.play=115
	-- stats.yd=10
end

function menu_update()
	if btnp(3) and menu.y<14 then
		menu.y+=menu.dy
	end
	if btnp(2) and menu.y>0 then
		menu.y-=menu.dy
	end
 if btnp(1) and menu.y==0 then
 	tama.food=true
 end
 if btnp(1) and menu.y==7 then
 	tama.wash=true
 end
 if btnp(1) and menu.y==14 then
 	tama.play=true
 end
end

function stats_update()
end

function menu_draw()
	print('food',7,0)
	print('wash',7,7)
	print('play',7,14)
	print('>',0,menu.y)
end

function stats_draw()
	-- rectfill(10,120,14,stats.food)
	-- rectfill(17,120,21,stats.wash)
	-- rectfill(24,120,28,stats.play)
end
-->8
function wash_init()
	wash={}
	wash.y=-10
	wash.sprt=5
	wash.tmr=0
end

function wash_update()
	if tama.wash then
		wash.tmr+=1
		wash.y=64
		if wash.tmr%15==2 then
			wash.sprt+=1
			if wash.tmr>120 then
				wash.tmr=0
				wash.y=-10
				tama.wash=false
			end
		end
		if wash.sprt>6 then
			wash.sprt=5
		end
	end
end

function wash_draw()
	spr(wash.sprt,64,wash.y)
end
-->8
function play_init()
	play={}
	play.x=-10
	play.dx=10
	play.sprt=0
	play.tmr=0
end

function play_update()
	if tama.play then
		play.tmr+=1
		if play.tmr%15==2 then
			play.x+=play.dx
		end
		if play.x>128 then
			play.x=-10
			play.tmr=0
			tama.play=false
		end
	end
end

function play_draw()
	spr(play.sprt,play.x,64)
end
__gfx__
0000000000000d00000020000200d000000d00000000000006067000006700000000000000000000000000000000000000000000000000000000000000000000
0000000000000000202dd2000000000d000002000000000000066060006600000000000000000000000000000000000000000000000000000000000000000000
00700700d02dd2020266662d002dd200002000000004900006700000000000670000000000000000000000000000000000000000000000000000000000000000
0007700002d66d200de66ed002d66d20000dd0000044490006600670670060660000000000000000000000000000000000000000000000000000000000000000
000770002d666ed20d6666d02de666d202d66d200040440000000660660000000000000000000000000000000000000000000000000000000000000000000000
00700700d6e6666d0dd66dd0d6666e6d2d6666d20004400000670000000670060000000000000000000000000000000000000000000000000000000000000000
000000002d6666d2022dd2202d6666d2dde66edd0000000000660006060660000000000000000000000000000000000000000000000000000000000000000000
0000000002dddd200000000002dddd2022dddd220000000060000000000000000000000000000000000000000000000000000000000000000000000000000000