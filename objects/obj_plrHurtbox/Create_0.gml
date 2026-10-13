floating = false;
floatTime = 0;
forcePixelDestination = 10;
floatSpeed = 0.02;
startY = y;
canMove = false;
redSpeed = 20;
onTouchPossess = false;
moveShake = false;
lastHP = global.plrHP;
changeSprite = true;

image_index = 0;

/*
particlePart = 0;
particleType = 0;

touchedObject = function() {
	if onTouchPossess == true {
	canMove = false;
	onTouchPossess = false;
	global.plrPossesed = true;
	if global.inDanger <= 0 {
		image_alpha = 0;
	}
	
	particlePart = part_system_create();
	particleType = part_type_create();
	part_type_sprite(particleType, spr_redBorders, false, false, false);
	part_type_size(particleType, 0, 0, 0.15, 0);
	part_type_alpha2(particleType, 1, 0);
	part_type_life(particleType, 45, 45);

	part_particles_create(particlePart,obj_PlayerMap.x,obj_PlayerMap.y - 30,particleType,1);
	
	audio_play_sound(snd_grab,5,false);
	shakeObj(obj_PlayerMap,0.05,5,0.5,false);
	
	call_later(0.4,time_source_units_seconds,function(){
		global.plrAnchor -= 1;
		global.plrAnimChange += 2;
	});
	
	call_later(1,time_source_units_seconds,function(){
		part_system_destroy(particlePart);
		part_type_destroy(particleType);
	});
	
}
}
*/