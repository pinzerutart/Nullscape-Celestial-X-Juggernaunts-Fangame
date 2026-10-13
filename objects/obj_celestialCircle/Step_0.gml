if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 or beamBang == 2 {
	if image_xscale > 0 {
		image_xscale -= 0.1 * scale;
	} else if image_xscale <= 0 {
		instance_destroy();
	}
} else if beamBang == 0 {
	image_yscale = lerp(image_yscale,2 * scale,0.1);
	image_xscale = lerp(image_xscale,3 * scale,0.1);
	x = lerp(x,randomPosition,0.06);
	y =  lerp(y,obj_plrHurtbox.y,0.2);
}