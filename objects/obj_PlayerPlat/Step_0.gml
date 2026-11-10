if global.plrDied == true { exit; }
// VISUAL
ptorso.x = x + torsoXOffset;
ptorso.y = y + torsoYOffset;
ptorso.image_angle = tilt;
plegs.x = x + legsXOffset;
plegs.y = y + legsYOffset;
plegs.image_angle = tilt;

if obj_plrHurtbox.canMove == false {
	hurtBox.x = x;
	hurtBox.y = y;
}

if global.inDanger > 0 {
	if hurtBox.image_alpha < 0.99 {
		hurtBox.image_alpha = lerp(hurtBox.image_alpha,1,0.1);
	}
}else if global.inDanger <= 0 and hurtBox.image_alpha > 0.01 {
	hurtBox.image_alpha = lerp(hurtBox.image_alpha,0,0.1);
}

if (global.plrForce[0] != 0 or global.plrForce[1] != 0 or global.plrMoving >= 1) and particleSoulCD == false {
	part_particles_create(particlePart,obj_plrHurtbox.x,obj_plrHurtbox.y,particleType,1);
}

if global.plrForce[1] != 0 {
	if global.plrForce[1] > 0.1 {
		if global.plrAnimChange >= 2 {
			ptorso.sprite_index = spritesBody.Jump;
			ptorso.image_index = 0
		}
		if global.plrAnimChange >= 1 {
			plegs.sprite_index = spritesLegs.Jump;
			plegs.image_index = 0
		}
	}
	if global.plrForce[1] < -0.1 {
		if global.plrAnimChange >= 2 {
			ptorso.sprite_index = spritesBody.Fall;
			ptorso.image_speed = 0.3;
		}
		if global.plrAnimChange >= 1 {
			plegs.sprite_index = spritesLegs.Fall;
			plegs.image_speed = 0.3;
		}
	}
}

if global.plrMoving == 1 {
	if global.plrForce[1] == 0 and global.plrAnimChange >= 2 {
		ptorso.sprite_index = spritesBody.Walk;
	}
	if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		plegs.sprite_index = spritesLegs.Walk;
	}
	if looking == "R" {
		ptorso.x = x + torsoXOffsetRight;
		ptorso.image_xscale = 1;
		plegs.image_xscale = 1;
	}else if looking == "L" {
		ptorso.x = x + torsoXOffsetLeft;
		ptorso.image_xscale = -1;
		plegs.image_xscale = -1;
	}
}else{
	if looking == "R" {
		ptorso.x = x + torsoXOffsetRight;
	}else if looking == "L" {
		ptorso.x = x + torsoXOffsetLeft;
	}
	if global.plrForce[1] == 0 and global.plrAnimChange >= 2 {
		if otherIdle <= 0 {
			ptorso.sprite_index = spritesBody.Idle;
		}else{
			ptorso.sprite_index = spritesBody.Walk;
		}
	}
	if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		if otherIdle <= 0 {
			plegs.sprite_index = spritesLegs.Idle;	
		}else{
			plegs.sprite_index = spritesLegs.Walk;	
		}
	}
}


if global.plrMoving == 1 {
	if global.plrForce[1] == 0 and global.plrAnimChange >= 2 {
		ptorso.image_speed = global.plrSpeed / 40;
	}
	if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		plegs.image_speed = global.plrSpeed / 40;
	}
	
	if oneStepDo == false {
		oneStepDo = true;
		if global.plrAnimChange >= 2  {
			ptorso.image_index = 1;
		}
		if global.plrAnimChange >= 1  {
			plegs.image_index = 1;
		}
	}
}
else{
	if global.plrForce[1] == 0 and global.plrAnimChange >= 2  {
		if otherIdle <= 0 {
			ptorso.image_speed = 1;
		}else{
			ptorso.image_speed = 0;
			ptorso.image_index = 0;
		}
	} else if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		if otherIdle <= 0 {
			plegs.image_speed = 1;
		}else{
			plegs.image_speed = 0;
			plegs.image_index = 0;
		}
	}
	
	if oneStepDo == true  {
		oneStepDo = false;
		
		if global.plrAnimChange >= 2  {
			ptorso.image_index = 0;
		}
		if global.plrAnimChange >= 1  {
			plegs.image_index = 0;
		}
	}
}

// STUFF

if global.plrHP >= global.plrMaxHP{ global.plrHP = global.plrMaxHP }

if (global.plrInvF > 0){
	global.plrInvF -= delta_time / 1000000;
	//show_debug_message(global.plrInvF)
	if invEffect == false and global.plrInvF >= 0.1 {
		invEffect = true
		if invEffectFirst == false{
			invEffectFirst = true;
			//image_alpha -= 0.5;
			ptorso.image_alpha -= 0.5;
			plegs.image_alpha -= 0.5;
		}
		
		if invEffectType == 0 {
			invEffectType = 1;
			alarm[1] = game_get_speed(gamespeed_fps) * 0.25;
		}else{
			invEffectType = 0;
			alarm[0] = game_get_speed(gamespeed_fps) * 0.25;
		}
	}
}else{
	if invEffectType == 0 and invEffectFirst == true {
			//image_alpha += 0.5;
			ptorso.image_alpha += 0.5;
			plegs.image_alpha += 0.5;
			invEffect = false;
		}
	if invEffectFirst == true {invEffectFirst = false }
};

var jump = function() {
	if global.plrAnchor > 0 { return }
	if place_meeting(x, y + 1, obj_collisionBlock_plat) or jumpSpare > 0 or (flyAmount > 0 and jumpHold <= 0) or jumpHold > 0 {
		if flyAmount > 0 and jumpHold <= 0 { 
			flyAmount -= delta_time / 1000000;
			if global.plrForce[1] < 11.5 {
				global.plrForce[1] += 1.5;
			}
			return;
		};
		if jumpHold > 0 { jumpHold -= delta_time / 1000000; };
		jumpSpare = 0;
		global.plrForce[1] = 10;
		jumpCD = true;
		call_later(0.05,time_source_units_seconds,function(){
			jumpCD = false;
		});
	};
};

var move = function() {
    if global.plrSpeed <= 0 or global.plrAnchor > 0 { return }
    var dt = delta_time / 100000

    var xForce = global.plrSpeed * dt
	xForce *= smoothWalkMultiplier;
	xForce *= walkDirectionMultiplier;
	var absedForce = abs(global.plrForce[0]);
	if absedForce < 30 { xForce *= 1 - absedForce / 30; } else { xForce = 0; }

    var _maxSlope = 9;  

	if (!place_meeting(x + xForce, y, obj_collisionBlock_plat)) {
		x += xForce;
		for (var i = 1; i <= _maxSlope; i++) {
			if (!place_meeting(x + xForce, y + i, obj_collisionBlock_plat)) {
				y += i;
				break;
			}
		}
	} else {
		for (var i = 1; i <= _maxSlope; i++) {
			if (!place_meeting(x + xForce, y - i, obj_collisionBlock_plat)) {
				x += xForce;
				y -= i;
				break;
			}
		}
	}
}

// MOVEMENT
move()

buttonMove = keyboard_check( ord("A") );
if buttonMove {
	walkDirectionMultiplier = lerp(walkDirectionMultiplier,-1,smoothWalkSpeed);
	tilt = lerp(tilt,5,0.55);
}

buttonMove = keyboard_check( ord("D") );
if buttonMove {
	walkDirectionMultiplier = lerp(walkDirectionMultiplier,1,smoothWalkSpeed);
	tilt = lerp(tilt,-5,0.55);
}

buttonJump = keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_space);
if buttonJump {
	if releasedJump == false and (place_meeting(x, y + 1, obj_collisionBlock_plat) or jumpSpare > 0) { jumpHold = defaultJumpHold; }
};

buttonJump = keyboard_check_released(ord("X")) or keyboard_check_released(vk_space);
if buttonJump {
	releasedJump = true;
	jumpSpare = 0;
	jumpHold = 0; 
};

buttonJump = keyboard_check(ord("X")) or keyboard_check(vk_space);
if buttonJump {
	jump();
};

// DIRECTION MOVE
var isMoving = (keyboard_check( ord("A") ) or keyboard_check( ord("D") )) and not (keyboard_check( ord("A") ) and keyboard_check( ord("D") ));
if isMoving {
	global.plrMoving = 1;
	smoothWalkMultiplier = lerp(smoothWalkMultiplier,1,smoothWalkSpeed);
}else {
	tilt = lerp(tilt,0,0.55);
	global.plrMoving = 0;
	smoothWalkMultiplier = lerp(smoothWalkMultiplier,0,smoothWalkSpeed);
}

if global.inDanger <= 0 {
	if keyboard_check( ord("A") ) { looking = "L"; }
	if keyboard_check( ord("D") ) { looking = "R"; }
} else if global.inDanger > 0 {
	if x > mouse_x {
		looking = "L";
		ptorso.image_xscale = -1;
		plegs.image_xscale = -1;
	};
	if x < mouse_x {
		looking = "R";
		ptorso.image_xscale = 1;
		plegs.image_xscale = 1;
	};
}

// GRAVITY
var grav = 0.8;
var gravX = 0.4;
var maxFallSpeed = -50;


if global.plrAnchor <= 0 { global.plrForce[1] -= grav; }
if (global.plrForce[0] > 0) {
	if global.plrAnchor > 0 { return }
	global.plrForce[0] -= gravX;
	if global.plrForce[0] < 0 { global.plrForce[0] = 0; }
}
if (global.plrForce[0] < 0) {
	if global.plrAnchor > 0 { return }
	global.plrForce[0] += gravX;
	if global.plrForce[0] > 0 { global.plrForce[0] = 0; }
}


if (global.plrForce[1] < maxFallSpeed) {
	if global.plrAnchor > 0 { return }
	global.plrForce[1] = lerp(global.plrForce[1],maxFallSpeed,0.05);
}


if (global.plrForce[1] > 0) or (global.plrForce[1] < 0) {
	if global.plrAnchor > 0 { return }
    if (place_meeting(x, y - global.plrForce[1], obj_collisionBlock_plat)) {
        while (!place_meeting(x, y - sign(global.plrForce[1]), obj_collisionBlock_plat)) {
            y -= sign(global.plrForce[1]);
        }
		if global.plrForce[1] < 0 and global.plrAnimChange >= 2 { ptorso.image_index = plegs.image_index; }
        global.plrForce[1] = 0;
		jumpSpare = 0.5;
		releasedJump = false;
		if keyboard_check(ord("X")) or keyboard_check(vk_space) { jumpHold = defaultJumpHold; }
		
		if flyAmount < defaultFlyAmount { flyAmount += flyRegen * (delta_time / 1000000) }
    } else {
        y -= global.plrForce[1];
		if jumpSpare > 0 { jumpSpare -= 0.05; }
    }
}


if (global.plrForce[0] > 0) or (global.plrForce[0] < 0) {
	if global.plrAnchor > 0 { return }
    if (place_meeting(x - global.plrForce[0], y, obj_collisionBlock_plat)) {
        while (!place_meeting(x - sign(global.plrForce[0]), y, obj_collisionBlock_plat)) {
            x -= sign(global.plrForce[0]);
        }
    } else {
        x -= global.plrForce[0];
    }
}

if global.plrSP < global.plrMaxSP and global.inDanger == 1 {
	var dt = delta_time / 1000000
	var doubler = 1
	if global.plrSP <= 0 {doubler -= 0.65}
	global.plrSP += ((global.plrSPAdd * 25) * dt) * doubler
} else if global.plrSP > global.plrMaxSP {
	global.plrSP = global.plrMaxSP;
}

if global.plrHP <= 0 and died == false {
	global.plrDied = true;
	died = true
	global.camPositionX = camera_get_view_x(view_camera[0]);
	global.camPositionY = camera_get_view_y(view_camera[0]);
	
	global.soulPositionX = obj_plrHurtbox.x;
	global.soulPositionY = obj_plrHurtbox.y;

	audio_stop_all()
	layer_destroy(global.layerBattleID);
	part_system_destroy(particlePart);
	part_type_destroy(particleType);
	
	/*var _duration = 1000;
	var _starTime = current_time;

	while (current_time - _starTime < _duration) {
	}*/
	
	call_later(5,time_source_units_frames,function(){ room_goto(room_death); });
}