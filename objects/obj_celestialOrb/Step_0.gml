if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 or beamBang == 2 {
	if image_yscale > 0 {
		image_yscale = lerp(image_yscale,0,0.15);
		image_xscale = lerp(image_xscale,0,0.15);
	} else if image_yscale <= 0 {
		part_system_destroy(_ps);
		part_type_destroy(_ptype1);
		instance_destroy();
	}
} else if beamBang == 0 {
	image_yscale += sizeThingy;
	image_xscale += sizeThingy;
	part_system_position(_ps, x, y);
		
	if sizeThingy < 0.3 and endedThing1 == false { sizeThingy += 0.001 * scaleThing; scaleThing += 1;
	} else { endedThing1 = true; sizeThingy *= 0.9 }
	
	if effectThingy < 1 { effectThingy += 0.04; }
	
	part_type_scale(_ptype1, effectThingy, 2);
}

if global.plrHP <= 0 and beamBang == 0 { part_system_destroy(_ps); }