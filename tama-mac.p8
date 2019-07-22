pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
function _init()
	make_menu()
	make_food()
	make_tama()
end

function _update()
 navigate_menu()
 anim_food()
	anim_tama()
end

function _draw()
	cls()
	draw_menu()
	draw_food()
	draw_tama()
end
-->8
function make_tama()
 t={}
	t.x=64
	t.y=64
	t.sprt=1
	t.tmr=0
	t.wait=0.25
end

function anim_tama()
	if time() - t.tmr > t.wait then
		t.sprt+=1
		t.tmr=time()
		
		if t.sprt > 4 then
			t.sprt=1
		end
	end
end

function draw_tama()
	spr(t.sprt,t.x,t.y)
end
-->8
function make_menu()
	m={}
	m.x=15
	m.y=20
	m.dy=7
	m.sprt=">"
end

function navigate_menu()
	if btnp(3) then
		if m.y < 34 then
			m.y=m.y+m.dy
		end
	end
	
	if btnp(2) then
		if m.y > 20 then
			m.y=m.y-m.dy
		end
	end
end

toggle={}
toggle.b=false
toggle.food=20

function toggle_menu()
	if m.y==toggle.food then
		if btn(5) then
			toggle.b=true
		else
			return
		end
	end
end

function draw_menu()
	print(m.sprt,m.x,m.y,7)
	print("feed",20,20,7)
 print("clean",20,27,7)
 print("play",20,34,7)
end
-->8
function make_food()
	f={}
	f.x=64
	f.y=-10
	f.dy=5
	f.tmr=0
	f.wait=0.25
	f.sprt=5
end

function anim_food()	
	if f.y < t.y and time() - f.tmr > f.wait then
		f.y+=f.dy
		f.tmr=time()
	elseif f.y >= t.y then
		f.y=-10
	end
end

function draw_food()
	spr(f.sprt,f.x,f.y)
	print(toggle.b,20,41,7)
	print(f.y,20,48,7)
	print(t.y,20,55,7)
end
__gfx__
0000000000000d00000020000200d000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000002202dd2000000000d000002000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700d02dd2000266662d002dd200002000000004900000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700002d66d200de66ed002d66d20000dd0000044490000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770002d666ed20d6666d02de666d202d66d200040440000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700d6e6666d0dd66dd0d6666e6d2d6666d20004400000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000002d6666d2022dd2202d6666d2dde66edd0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000002dddd200000000002dddd2022dddd220000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
