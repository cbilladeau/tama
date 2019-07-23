pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- tama, a virtual pet simulator
-- by c.billadeau
-- https://cbilladeau.github.io/tama
-->8
-- the loop
function _init()
	tama_init()
	ui_init()
	food_init()
	wash_init()
	play_init()
	stats_init()
end

function _update()
	tama_update()
	ui_update()
	food_update()
	wash_update()
	play_update()
	stats_update()
end

function _draw()
	cls()
	tama_draw()
	ui_draw()
	food_draw()
	wash_draw()
	play_draw()
	stats_draw()
end
-->8
-- states
function state_menu()
	update=menu_update
	draw=menu_draw
end

function state_egg()
	update=egg_update
	draw=egg_draw
end

function state_baby()
	update=baby_update
	draw=baby_draw
end

function state_teen()
	update=teen_update
	draw=teen_draw
end

function state_adult()
	update=adult_update
	draw=adult_draw
end

function state_dead()
	update=dead_update
	draw=dead_draw
end
-->8
-- tama
function tama_init()
	tama={}
	tama.sprt=1
	tama.tmr=0
	tama.dead=false
end

function tama_update()
	tama.tmr+=1
	if tama.tmr%15==2 then
		tama.sprt+=1
	end
	if tama.sprt>4 then
		tama.sprt=1
	end
	if tama.tmr>120 then
		tama.tmr=0
	end
end

function tama_draw()
	if not tama.dead then
		spr(tama.sprt,64,64)
	-- else
	-- 	state_dead()
	end
end
-->8
-- ui & stats
function ui_init()
	ui={}
	ui.y=0
	ui.dy=7
end

function stats_init()
	stats={}
	stats.food=10
	stats.wash=10
	stats.play=10
	stats.tmr=0
end

function ui_update()
	if btnp(3) and ui.y<14 then
		ui.y+=ui.dy
	end
	if btnp(2) and ui.y>0 then
		ui.y-=ui.dy
	end
	if btnp(4) and ui.y==0 then
		food.doing=true
	end
	if btnp(4) and ui.y==7 then
		wash.doing=true
	end
	if btnp(4) and ui.y==14 then
		play.doing=true
	end
end

function stats_update()
	stats.tmr+=1
	if stats.food<100 then
		stats.food=100
	end
	if stats.wash<100 then
		stats.wash=100
	end
	if stats.play<100 then
		stats.play=100
	end
	if stats.tmr%15==2 and not tama.dead then
		stats.food+=1
		stats.wash+=1
		stats.play+=1
	end
	if stats.food>=110 or stats.wash>=110 or stats.play>=110 then
		tama.dead=true
	end
	if stats.tmr>3000 then
		stats.tmr=0
	end
end

function ui_draw()
	print('food',7,0,7)
	print('wash',7,7,7)
	print('play',7,14,7)
	print('>',0,ui.y,7)
end

function stats_draw()
	rectfill(10,110,14,100,1)
	rectfill(17,110,21,100,1)
	rectfill(24,110,28,100,1)
	rectfill(10,110,14,stats.food,13)
	rectfill(17,110,21,stats.wash,13)
	rectfill(24,110,28,stats.play,13)
end
-->8
-- food state
function food_init()
	food={}
	food.doing=false
	food.y=-10
	food.dy=10
	food.sprt=5
	food.tmr=0
end

function food_update()
	if food.doing then
		food.tmr+=1
		if food.tmr%15==2 then
			food.y+=food.dy
		end
		if food.y>64 then
			food.y=-10
			food.tmr=0
			stats.food-=5
			food.doing=false
		end
	end
end

function food_draw()
	spr(food.sprt,64,food.y)
end
-->8
-- wash state
function wash_init()
	wash={}
	wash.doing=false
	wash.y=-10
	wash.sprt=6
	wash.tmr=0
end

function wash_update()
	if wash.doing then
		wash.tmr+=1
		wash.y=64
		if wash.tmr%15==2 then
			wash.sprt+=1
			if wash.tmr>120 then
				wash.tmr=0
				wash.y=-10
				stats.wash-=10
				wash.doing=false
			end
		end
		if wash.sprt>7 then
			wash.sprt=6
		end
	end
end

function wash_draw()
	spr(wash.sprt,64,wash.y)
end
-->8
-- play state
function play_init()
	play={}
	play.doing=false
	play.x=-10
	play.dx=10
	play.sprt=0
	play.tmr=0
end

function play_update()
	if play.doing then
		play.tmr+=1
		if play.tmr%15==2 then
			play.x+=play.dx
		end
		if play.x>128 then
			play.x=-10
			play.tmr=0
			stats.play-=5
			play.doing=false
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
