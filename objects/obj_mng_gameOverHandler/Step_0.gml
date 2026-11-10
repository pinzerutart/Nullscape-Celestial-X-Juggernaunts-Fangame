
if obj_gameOverScreenThing.image_alpha > 0 {
	obj_gameOverScreenThing.image_alpha -= 0.008;
}

if shakeCD == false and shakePower > 0 {
	shakeCD = true;
	alarm[1] = game_get_speed(gamespeed_fps) * 0.02;
	if shakeT == 0 {
		shakeT = 0;
		obj_plrHurtbox.x += random_range(-shakePower,shakePower);
		obj_plrHurtbox.y += random_range(-shakePower,shakePower);
		
		shakePower -= 0.2;
	}else {
		shakeT = 0;
		obj_plrHurtbox.x = oldPos[0];
		obj_plrHurtbox.y = oldPos[1];
	}
}