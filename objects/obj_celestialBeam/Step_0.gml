if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 or beamBang == 2 {
	if image_yscale > 0 {
		image_yscale = lerp(image_yscale,0,0.15);
		image_yscale -= 0.1;
	} else if image_yscale <= 0 {
		instance_destroy();
	}
} else if beamBang == 0 {
	image_yscale = lerp(image_yscale,7,0.15);
	image_angle = lerp(image_angle,randomAngleRotate,0.1);
}