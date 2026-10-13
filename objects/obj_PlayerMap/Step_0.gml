if global.inPlatformer >= 1 {
	ptorso.image_speed = 0;
	plegs.image_speed = 0;
	ptorso.image_index = 0;
	plegs.image_index = 0;
	
	if madeInvisible == false {
		madeInvisible = true;
		ptorso.image_alpha -= 1;
		plegs.image_alpha -= 1;
	}
	
	bA = false;
	bD = false;
	bW = false;
	bS = false;
	
	exit;
}else if global.inPlatformer <= 0 {
	if madeInvisible == true {
		madeInvisible = false;
		ptorso.image_alpha += 1;
		plegs.image_alpha += 1;
	}
}

//show_debug_message(global.plrForce[0])

// VISUAL
ptorso.x = x;
ptorso.y = y - 33;
plegs.x = x;
plegs.y = y - 33;

hurtBox.x = x;
hurtBox.y = y - 33;


	if global.plrForce[1] != 0 {
		if global.plrForce[1] > 0 {
			changedDirectionOfAnim = true;
			if global.plrAnimChange >= 1 {
				ptorso.sprite_index = spr_playerBodyVertical_down;
				plegs.sprite_index = spr_playerLegsVertical;
			}		
			ptorso.image_xscale = 1
			plegs.image_xscale = 1
			looking = "D"
		}else if global.plrForce[1] < 0  {
			changedDirectionOfAnim = true;
			
			if global.plrAnimChange >= 1 {
				ptorso.sprite_index = spr_playerBodyVertical;
				plegs.sprite_index = spr_playerLegsVertical;
			}
			ptorso.image_xscale = -1
			plegs.image_xscale = -1
			looking = "U"
		}
	}
	if global.plrForce[0] != 0 {
		if global.plrForce[0] > 0 {
			changedDirectionOfAnim = true;
			
			if global.plrAnimChange >= 1 {
				ptorso.sprite_index = spr_playerBodyHorizontal;
				plegs.sprite_index = spr_playerLegsHorizontal;
			}
			ptorso.image_xscale = 1
			plegs.image_xscale = 1
			looking = "R"
		}else if global.plrForce[0] < 0  {
			changedDirectionOfAnim = true;
			
			if global.plrAnimChange >= 1 {
				ptorso.sprite_index = spr_playerBodyHorizontal;			
				plegs.sprite_index = spr_playerLegsHorizontal;
			}
			ptorso.image_xscale = -1
			plegs.image_xscale = -1
			looking = "L"
		}
	}



if (global.plrForce[0] != 0 or global.plrForce[1] != 0) {
	walking = true;
	
	if global.plrAnimChange >= 1 {
		ptorso.image_speed = global.plrSpeed / 80;
		plegs.image_speed = global.plrSpeed / 80;
	}
	
	if oneStepDo == false and global.plrAnimChange >= 1  {
		oneStepDo = true;
		ptorso.image_index += 1;
		plegs.image_index += 1;
	}
}
else{
	walking = false;
	oneStepDo = false;
	changedDirectionOfAnim = false;
	
	if global.plrAnimChange >= 1 {
		ptorso.image_speed = 0;
		plegs.image_speed = 0;
		ptorso.image_index = 0;
		plegs.image_index = 0;
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
}

var move = function(xGot,yGot) {
	if global.plrSpeed <= 0 { return }
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
if buttonMove {move(-global.plrSpeed,0)}

buttonMove = keyboard_check( ord("D") );
if buttonMove {move(global.plrSpeed,0)}

buttonMove = keyboard_check( ord("W") );
if buttonMove {move(0,-global.plrSpeed)}

buttonMove = keyboard_check( ord("S") );
if buttonMove {move(0,global.plrSpeed)}

// DIRECTION MOVE

buttonMove = keyboard_check_pressed( ord("A") );
if buttonMove and bA == false {global.plrForce[0] += -1; bA = true;}
buttonMove = keyboard_check_released( ord("A") );
if buttonMove and bA == true {global.plrForce[0] -= -1; bA = false;}

buttonMove = keyboard_check_pressed( ord("D") );
if buttonMove and bD == false {global.plrForce[0] += 1; bD = true;}
buttonMove = keyboard_check_released( ord("D") );
if buttonMove and bD == true {global.plrForce[0] -= 1; bD = false;}

buttonMove = keyboard_check_pressed( ord("W") );
if buttonMove and bW == false {global.plrForce[1] += -1; bW = true;}
buttonMove = keyboard_check_released( ord("W") );
if buttonMove and bW == true {global.plrForce[1] -= -1; bW = false;}

buttonMove = keyboard_check_pressed( ord("S") );
if buttonMove and bS == false {global.plrForce[1] += 1; bS = true;}
buttonMove = keyboard_check_released( ord("S") );
if buttonMove and bS == true {global.plrForce[1] -= 1; bS = false;}

// RUN System
var runSystem = function(running) {
	//show_debug_message(running)
	if running == 1 and isRunning == 0 {
		isRunning = 1;
		global.plrSpeed += 7;
	}
	else if running == 0 and isRunning == 1 {
		isRunning = 0;
		global.plrSpeed -= 7;
	}
}

pressedRun = keyboard_check_pressed(ord("X")) or keyboard_check_pressed(vk_shift) or autoRun == true;
if pressedRun {runSystem(1);}

releasedRun = (keyboard_check_released(ord("X")) or keyboard_check_released(vk_shift)) and autoRun == false;
if releasedRun {runSystem(0);}

buttonCheck = keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter);
if buttonCheck and global.plrSoftlock <= 0 and not instance_exists(obj_playerCheckBox) {
	var offsetX = 35;
	if looking == "L" {offsetX *= -1;}
	var offsetY = 0;
	if looking == "D" or looking == "U" {offsetX *= 0;}
	if looking == "D" {offsetY = 35;}
	if looking == "U" {offsetY = -40;}
	
	checkBox = instance_create_layer(x + offsetX,y + offsetY,layer_get_id("Instances"),obj_playerCheckBox);
	checkBox.image_xscale = 2.35;
	checkBox.image_yscale = 2.35;
	if looking == "U" {checkBox.image_yscale = 5;}
	
	call_later(0.1,time_source_units_seconds,function(){
		instance_destroy(checkBox);
	})
}

if (isRunning == 0 or (isRunning == 1 and global.plrForce[0] == 0 and global.plrForce[1] == 0)) and global.plrSP < global.plrMaxSP {
	var dt = delta_time / 1000000;
	var doubler = 1;
	if global.plrSP <= 0 {doubler -= 0.65;}
	global.plrSP += ((global.plrSPAdd * 25) * dt) * doubler;
}
else if isRunning == 1 and global.plrSP > 0 and (global.plrForce[0] != 0 or global.plrForce[1] != 0) and inDanger >= 1 {
	var dt = delta_time / 1000000;
	global.plrSP -= (global.plrSPDel * 25) * dt;
}

if isRunning == 1 and global.plrSP <= 0 {
	isRunning = 0;
	global.plrSpeed -= 7;
}

if global.plrHP <= 0 and died == false {
	died = true;
	global.camPositionX = camera_get_view_x(view_camera[0]);
	global.camPositionY = camera_get_view_y(view_camera[0]);
	
	global.soulPositionX = obj_plrHurtbox.x;
	global.soulPositionY = obj_plrHurtbox.y;
	audio_stop_all();
	
	room_goto(room_death);
}