if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 or beamBang == 2 {
	if image_yscale > 0 {
		image_yscale = lerp(image_yscale,0,0.15);
		image_xscale = lerp(image_xscale,0,0.15);
	} else if image_yscale <= 0.01 {
		part_system_destroy(_ps);
		part_type_destroy(_ptype1);
		instance_destroy();
	}
} else if beamBang == 0 {
	image_yscale += sizeThingy;
	image_xscale += sizeThingy;
	if part_system_exists(_ps) { part_system_position(_ps, x, y); }
		
	if sizeThingy < 0.3 * scale and endedThing1 == false { sizeThingy += (0.001 * scaleThing) * scale; scaleThing += 1;
	} else { endedThing1 = true; sizeThingy *= 0.9 }
	
	if effectThingy < 1 { effectThingy += 0.04 * scale; }
	
	if part_type_exists(_ptype1) { part_type_scale(_ptype1, effectThingy, 2); }
}

if global.plrDied == true and beamBang == 0 and part_system_exists(_ps) { part_system_destroy(_ps); part_type_destroy(_ptype1); }