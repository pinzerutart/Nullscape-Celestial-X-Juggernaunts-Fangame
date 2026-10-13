// VISUAL
ptorso.x = x + torsoXOffset;
ptorso.y = y + torsoYOffset;
plegs.x = x + legsXOffset;
plegs.y = y + legsYOffset;

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
			ptorso.sprite_index = spr_playerBodyPlatformerJump;
			ptorso.image_index = 0
		}
		if global.plrAnimChange >= 1 {
			plegs.sprite_index = spr_playerLegsPlatformerJump;
			plegs.image_index = 0
		}
	}
	if global.plrForce[1] < -0.1 {
		if global.plrAnimChange >= 2 {
			ptorso.sprite_index = spr_playerBodyPlatformerFall;
			ptorso.image_speed = 0.3;
		}
		if global.plrAnimChange >= 1 {
			plegs.sprite_index = spr_playerLegsPlatformerFall;
			plegs.image_speed = 0.3;
		}
	}
}

if global.plrMoving == 1 {
	if looking == "R" {
		if global.plrForce[1] == 0 and global.plrAnimChange >= 2 {
			ptorso.sprite_index = spr_playerBodyPlatformerWalk;
		}
		if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
			plegs.sprite_index = spr_playerLegsPlatformerWalk;
		}
		
		ptorso.x = x + torsoXOffsetRight;
		ptorso.image_xscale = 1;
		plegs.image_xscale = 1;
	}
	if looking == "L" {
		if global.plrForce[1] == 0 and global.plrAnimChange >= 2 {
			ptorso.sprite_index = spr_playerBodyPlatformerWalk;
		}
		if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
			plegs.sprite_index = spr_playerLegsPlatformerWalk;
		}		
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
			ptorso.sprite_index = spr_playerBodyPlatformerIdle;
		}else{
			ptorso.sprite_index = spr_playerBodyPlatformerWalk;
		}
	}
	if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		if otherIdle <= 0 {
			plegs.sprite_index = spr_playerLegsPlatformerIdle;	
		}else{
			plegs.sprite_index = spr_playerLegsPlatformerWalk;	
		}
	}
}


if global.plrMoving == 1 {
	walking = true;
	
	if global.plrForce[1] == 0 and global.plrAnimChange >= 2 {
		ptorso.image_speed = global.plrSpeed / 320;
	}
	if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		plegs.image_speed = global.plrSpeed / 320;
	}
	
	if oneStepDo == false {
		oneStepDo = true;
		if global.plrAnimChange >= 2  {
			ptorso.image_index = 0;
		}
		if global.plrAnimChange >= 1  {
			plegs.image_index = 0;
		}
	}
}
else{
	walking = false;
	
	if global.plrForce[1] == 0 and global.plrAnimChange >= 2  {
		if otherIdle <= 0 {
			ptorso.image_speed = 0.2;
		}else{
			ptorso.image_speed = 0;
			ptorso.image_index = 1
		}
	} else if global.plrForce[1] == 0 and global.plrAnimChange >= 1  {
		if otherIdle <= 0 {
			plegs.image_speed = 0.2;
		}else{
			plegs.image_speed = 0;
			plegs.image_index = 1
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
	if place_meeting(x, y + 1, obj_collisionBlock_plat) or jumpSpare > 0 or flyAmount > 0 {
		if flyAmount > 0 { flyAmount -= delta_time / 1000000; };
		jumpSpare = 0;
		global.plrForce[1] = 10;
		jumpCD = true;
		call_later(0.05,time_source_units_seconds,function(){
			jumpCD = false;
		});
	};
};

var move = function(xGot) {
	if global.plrSpeed <= 0 { return }
	var dt = delta_time / 100000
	
	var xForce = xGot * dt
	if global.plrForce[0] > 0 { xForce *= 0.05; }
	
	if place_meeting(x, y, obj_collisionBlock_plat) {
		x -= sign(xForce)
	}
	
	if !place_meeting(x + xForce, y, obj_collisionBlock_plat) {
		x += xForce
	}
}

// MOVEMENT

buttonMove = keyboard_check( ord("A") );
if buttonMove {move(-global.plrSpeed)}

buttonMove = keyboard_check( ord("D") );
if buttonMove {move(global.plrSpeed)}

buttonJump = keyboard_check(ord("X")) or keyboard_check(vk_space);
if buttonJump {
	jump();
};

buttonJump = keyboard_check_released(ord("X")) or keyboard_check_released(vk_space);
if buttonJump {
	releasedJump = true;
	jumpSpare = 0;
	if defaultFlyAmount <= 0.3 { flyAmount = 0; }
};

// DIRECTION MOVE
isMoving = (keyboard_check( ord("A") ) or keyboard_check( ord("D") )) and not (keyboard_check( ord("A") ) and keyboard_check( ord("D") ));
if isMoving {
	global.plrMoving = 1;
}else {
	global.plrMoving = 0;
}

if global.inDanger <= 0 {
	if global.plrSP > 20 {
		global.plrSP -= 1;
	}else{
		global.plrSP = 20;
	}
	
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

dashed = keyboard_check_pressed(ord("Q"));
if dashed {
	if dashCD == false and global.plrSP > 30 and (global.plrForce[0] != 0 or global.plrMoving == 1) {
		global.plrSP -= 30
		dashCD = true
		global.plrSpeed += 100;
		call_later(1,time_source_units_seconds,function(){dashCD = false})
		call_later(0.5,time_source_units_seconds,function(){particleSoulCD = true})
		particleSoulCD = false;
		
		for (var i = 1; i <= 10; i++) {
			call_later(i * 0.035,time_source_units_seconds,function(){
				if died == false and instance_exists(ptorso) {
					global.plrSpeed -= 10;
				};
			});
		};
	};
};

// GRAVITY
var grav = 0.8;
var gravX = 0.4;
var maxFallSpeed = -30;


global.plrForce[1] -= grav;
if (global.plrForce[0] > 0) {
	global.plrForce[0] -= gravX;
}
if (global.plrForce[0] < 0) {
	global.plrForce[0] += gravX;
}


if (global.plrForce[1] < maxFallSpeed) {
    global.plrForce[1] = maxFallSpeed;
}


if (global.plrForce[1] > 0) or (global.plrForce[1] < 0) {
    if (place_meeting(x, y - global.plrForce[1], obj_collisionBlock_plat)) {
        while (!place_meeting(x, y - sign(global.plrForce[1]), obj_collisionBlock_plat)) {
            y -= sign(global.plrForce[1]);
        }
		if global.plrForce[1] < 0 and global.plrAnimChange >= 2 { ptorso.image_index = plegs.image_index; }
        global.plrForce[1] = 0;
		flyAmount = defaultFlyAmount;
		jumpSpare = 0.5;
		releasedJump = false;
    } else {
        y -= global.plrForce[1];
		if jumpSpare > 0 { jumpSpare -= 0.05; }
    }
}


if (global.plrForce[0] > 0) or (global.plrForce[0] < 0) {
    if (place_meeting(x - global.plrForce[0], y, obj_collisionBlock_plat)) {
        while (!place_meeting(x - sign(global.plrForce[0]), y, obj_collisionBlock_plat)) {
            x -= sign(global.plrForce[0]);
        }
    } else {
        x -= global.plrForce[0];
    }
}

if global.plrSP < global.plrMaxSP {
	var dt = delta_time / 1000000
	var doubler = 1
	if global.plrSP <= 0 {doubler -= 0.65}
	global.plrSP += ((global.plrSPAdd * 25) * dt) * doubler
} else if global.plrSP > global.plrMaxSP {
	global.plrSP = global.plrMaxSP;
}

if global.plrHP <= 0 and died == false {
	died = true
	global.camPositionX = camera_get_view_x(view_camera[0]);
	global.camPositionY = camera_get_view_y(view_camera[0]);
	
	global.soulPositionX = obj_plrHurtbox.x;
	global.soulPositionY = obj_plrHurtbox.y;

	audio_stop_all()
	part_system_destroy(particlePart);
	part_type_destroy(particleType);
	
	room_goto(room_death)
}