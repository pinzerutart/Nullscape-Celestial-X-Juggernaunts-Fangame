if not instance_exists(obj_PlayerPlat) {
	exit;
}

var ability = function() {
	if cd == false and global.plrSoftlock <= 0 {
		cd = true;
		instance_destroy(hitbox);
		global.plrSoftlock += 1;
		
		obj_plrTorso.image_index = 0;
		if catk == 1 { 
			global.plrAnimChange -= 1;
			global.plrSpeed -= 15;
			
			obj_plrTorso.stopOnEndAnim += 1;
			obj_PlayerPlat.canJump -= 1;
			
			obj_plrTorso.sprite_index = spr_plrBodyPlatformer_Sword1;
		}else if catk == 2 { 
			obj_plrTorso.sprite_index = spr_plrBodyPlatformer_Sword2;
		};
		obj_plrTorso.image_speed = 1.2;
		
		if catk == 1 {
			obj_PlayerPlat.torsoYOffset -= 10.5;
			obj_PlayerPlat.torsoXOffsetRight += 5.5;
			obj_PlayerPlat.torsoXOffsetLeft += -5.5;
			obj_PlayerPlat.otherIdle += 1;
		};
		
		call_later(0.25,time_source_units_seconds,function(){
			global.plrSoftlock -= 1;
		});
		
		
		if catk == 1 {
			clearTime = 0.3;
		}else if catk == 2 {
			clearTime = 0.3;
		};
		
		if catk == 1 {
			alarm[0] = game_get_speed(gamespeed_fps) * 0.25;
		}else if catk == 2{
			alarm[0] = game_get_speed(gamespeed_fps) * 0.35;
		};
		
		var offsets = 30;
		if obj_PlayerPlat.looking == "L" { offsets *= -1; }
	
		hitbox = instance_create_layer(obj_PlayerPlat.x + offsets,obj_PlayerPlat.y,global.layerBattleID,obj_ABH_Sword);
		hitbox.image_alpha = 0;
		hitbox.image_yscale = 0.15;
		hitbox.image_xscale = 0.175;
		
		if catk == 1 { 
			catk = 2;
		}else if catk == 2 { 
			catk = 1;
		};
	}
}

if instance_exists(hitbox) {
	var offsets = 30;
	if obj_PlayerPlat.looking == "L" { offsets *= -1 }
	
	hitbox.x = obj_PlayerPlat.x + offsets;
	hitbox.y = obj_PlayerPlat.y;
}

if clearTime > 0 {
	clearTime -= delta_time / 1000000;
	if cleared == true {
		cleared = false;
	}
}else if clearTime <= 0 {
	if cleared == false {
		cleared = true;
		obj_PlayerPlat.canJump += 1;
		
		if catk == 2 {
			catk = 1;
		}
		
		obj_PlayerPlat.torsoXOffsetRight -= 5.5;
		obj_PlayerPlat.torsoXOffsetLeft -= -5.5;
		
		global.plrSpeed += 15;
	
		instance_destroy(hitbox)
		global.plrAnimChange += 1;
		obj_PlayerPlat.torsoYOffset += 10.5;
		obj_PlayerPlat.otherIdle -= 1;
		obj_plrTorso.stopOnEndAnim -= 1;
				
		obj_plrTorso.image_index = obj_plrLegs.image_index;
	}
}

button_key = keyboard_check(ord("Z")) or keyboard_check(vk_enter) or mouse_check_button(mb_left);
if button_key {
	ability()
}
