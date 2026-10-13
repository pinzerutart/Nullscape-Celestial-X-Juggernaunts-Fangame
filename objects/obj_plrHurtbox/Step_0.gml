if (floating) {
    floatTime += floatSpeed;
    y = startY + sin(floatTime) * forcePixelDestination;
}

if changeSprite == true {
	var currentIndexToShow = 11 - round(((global.plrHP / global.plrMaxHP) * 11))
	image_index = currentIndexToShow;
}

if global.plrHP != lastHP {
	global.inDanger += 1;
	call_later(3,time_source_units_seconds,function(){
		global.inDanger -= 1;
	});
	
	if global.plrHP < lastHP {
		shakeObj(self,0.05,6,0.6,false);
	}
	
	lastHP = global.plrHP;
}

var move = function(xGot,yGot) {
	if canMove == false { return; }
	var dt = delta_time / 100000
	
	var xForce = xGot * dt
	
	if place_meeting(x, y, obj_collisionBlock) {
		x -= sign(xForce)
	}
	
	if !place_meeting(x + xForce, y, obj_collisionBlock) {
		x += xForce
	}
	
	var yForce = yGot * dt
	
	if place_meeting(x, y, obj_collisionBlock) {
		y -= sign(yForce)
	}
	
	if !place_meeting(x, y + yForce, obj_collisionBlock) {
		y += yForce
	}
	
}

// MOVEMENT

buttonMove = keyboard_check( ord("A") );
if buttonMove {move(-redSpeed,0)}

buttonMove = keyboard_check( ord("D") );
if buttonMove {move(redSpeed,0)}

buttonMove = keyboard_check( ord("W") );
if buttonMove {move(0,-redSpeed)}

buttonMove = keyboard_check( ord("S") );
if buttonMove {move(0,redSpeed)}

var pw = 1.5;
var ls = 0.85;
buttonMove = keyboard_check_pressed(ord("A")) or keyboard_check_pressed(ord("D"));
if buttonMove and moveShake == true { shakeObj(self,0.05,pw,ls,[x,y]); }
buttonMove = keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S"));
if buttonMove and moveShake == true { shakeObj(self,0.05,-pw,ls,[x,y]); }


