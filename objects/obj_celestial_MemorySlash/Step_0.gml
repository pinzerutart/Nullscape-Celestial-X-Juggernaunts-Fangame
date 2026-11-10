if waitForStartBang == false and bangStarting == false { 
	sprite_index = asset_get_index("spr_celestial_memory"+string(bitterType)+"C");
	bangStarting = true;
	alarm[0] = game_get_speed(gamespeed_fps) * bangStart;
	alarm[3] = game_get_speed(gamespeed_fps) * 1;
	alarm[4] = game_get_speed(gamespeed_fps) * (bangStart - 2);
}

if beamBang == 1 or beamBang == 2{
	image_alpha = lerp(image_alpha, 0, 0.1);
} else if beamBang == 0 {
	image_yscale = lerp(image_yscale,0.7,0.15);
	image_xscale = lerp(image_yscale,0.7,0.15);
	image_angle = lerp(image_angle,randomAngleRotate,0.035);
	
	if startFollowing == 2 {
		x = obj_plrHurtbox.x;
		y = obj_plrHurtbox.y;
		image_alpha = lerp(image_alpha, 0.6, 0.1);
	} else if startFollowing == 1 { image_alpha = lerp(image_alpha, 0.3, 0.1);
	} else if startFollowing == 0 { image_alpha = lerp(image_alpha, 0, 0.1); }
}