if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 or beamBang == 2 {
	if image_yscale > 0 {
		image_alpha -= 0.035;
	} else if image_yscale <= 0 {
		alarm[2] = game_get_speed(gamespeed_fps) * 2
	}
} else if beamBang == 0 {
	image_alpha = lerp(image_alpha,0.7,0.15);
	image_yscale = lerp(image_yscale,3.5,0.15);
	image_xscale = lerp(image_yscale,3.5,0.15);
	image_angle = lerp(image_angle,randomAngleRotate,0.035);
}

if global.plrHP <= 0 and beamBang == 1 { part_system_destroy(_ps); }