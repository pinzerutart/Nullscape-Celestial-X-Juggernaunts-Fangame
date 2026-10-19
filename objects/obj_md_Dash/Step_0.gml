var ability = function() {
	if cd == false and global.inDanger >= 1 and global.plrSP > 0 and global.plrSoftlock <= 0 and (global.plrForce[0] != 0 or global.plrMoving == 1) {
		cd = true
		thingLostAmount = 0;
		bonusSpeed = (global.plrSpeed = 40) / 2;
		endedDash = false;
		global.plrSpeed += 100;
		global.plrSpeed += bonusSpeed;
		alarm[0] = game_get_speed(gamespeed_fps) * 1;
		call_later(0.5,time_source_units_seconds,function(){ particleSoulCD = true; })
		particleSoulCD = false;
		
		for (var i = 1; i <= 10; i++) {
			call_later(i * 0.035,time_source_units_seconds,function(){
				if endedDash == true { exit; }
				if _p.died == false and instance_exists(_p.ptorso) {
					global.plrSpeed -= 10;
					global.plrSP -= 3;
					global.plrSpeed -= bonusSpeed / 10;
					thingLostAmount += 1;
					
					if global.plrSP <= 1 {
						global.plrSP = 0;
						global.plrSpeed -= (10 - thingLostAmount) * 10;
						endedDash = true;
						particleSoulCD = true;
					}
				};
			});
		};
	}
}

if (global.plrForce[0] != 0 or global.plrForce[1] != 0 or global.plrMoving >= 1) and particleSoulCD == false {
	part_particles_create(_p.particlePart,obj_plrHurtbox.x,obj_plrHurtbox.y,_p.particleType,1);
}

if clearTime > 0 {
	clearTime -= delta_time / 1000000;
	if cleared == true {
		cleared = false;
	}
}else if clearTime <= 0 {
	if cleared == false {
		cleared = true;
	}
}

button_key = keyboard_check(ord("Q"));
if button_key {
	ability()
}