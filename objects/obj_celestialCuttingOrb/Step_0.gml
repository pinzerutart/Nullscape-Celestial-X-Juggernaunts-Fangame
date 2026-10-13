if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

if beamBang == 1 {
	image_yscale -= 0.0035;
	image_xscale -= 0.0035;
	
	if image_yscale <= 0.05 { 
		part_system_destroy(_ps);
		part_type_destroy(_ptype1);
		instance_destroy();
		exit;
	}
	
	var targetedDir = point_direction(x,y,obj_plrHurtbox.x,obj_plrHurtbox.y);
	_dir += angle_difference(targetedDir,_dir) * (_rotationSpeed);
	
	x += lengthdir_x(_speed,_dir);
	y += lengthdir_y(_speed,_dir);
	
	part_system_position(_ps,x,y);
} else if beamBang == 0 {
	image_yscale = lerp(image_yscale,1,0.1);
	image_xscale = lerp(image_xscale,1,0.1);
	x = lerp(x,xOffset,0.05);
	y = lerp(y,yOffset,0.05);
	
	part_system_position(_ps,x,y);
} else if beamBang == 2 {
	image_yscale -= 0.1;
	image_xscale -= 0.1;
	if image_yscale <= 0.01 { 
		instance_destroy();
	}
}

if beamBang == 2 and explodedT == false {
	explodedT = true;
	image_xscale = 4;
	image_yscale = 4;
	part_system_destroy(_ps);
	part_type_destroy(_ptype1);
	
	if global.celestialHardmode == true {
		var beam = instance_create_depth(x,y,obj_plrHurtbox.depth - 1,obj_celestialBeam);
		beam.bangStart = 0.75;
		beam.waitForStartBang = false;
		var randomSoundGot = irandom_range(1,2);
		if randomSoundGot == 1 {
			audio_play_sound(snd_celestial_beamVariant1,2,false,1.35,0,0.75);
		} else if randomSoundGot == 2 {
			audio_play_sound(snd_celestial_beamVariant2,2,false,1.35,0,0.75);
		}
	}
}

if global.plrHP <= 0 { part_system_destroy(_ps); }