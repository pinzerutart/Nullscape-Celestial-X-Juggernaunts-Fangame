if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 or beamBang == 2 {
	if image_xscale > 0 {
		image_xscale -= 0.1 * scale;
	} else if image_xscale <= 0 {
		alarm[2] = game_get_speed(gamespeed_fps) * 1;
	}
} else if beamBang == 0 {
	image_yscale = lerp(image_yscale,2 * scale,0.1);
	image_xscale = lerp(image_xscale,3 * scale,0.1);
	x = lerp(x,randomPosition,0.02);
	y =  lerp(y,obj_plrHurtbox.y,0.2);
}

if global.plrDied == true and beamBang >= 1 and part_system_exists(_ps) {
	part_system_destroy(_ps);
	part_type_destroy(_ptype1);
}