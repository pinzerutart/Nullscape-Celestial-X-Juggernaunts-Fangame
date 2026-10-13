obj_gameOverScreenThing.image_blend = c_white;
obj_gameOverScreenThing.image_alpha = -0.2;
var sndSound1 = audio_play_sound(snd_revival,10,false);

particlePart = part_system_create();
particleType = part_type_create();
part_type_sprite(particleType, spr_redNoBorders, false, false, false);
part_type_size(particleType, 2, 2, 1, 0);
part_type_alpha2(particleType, 1, 0);
part_type_life(particleType, 100, 100);

part_particles_create(particlePart,obj_plrHurtbox.x,obj_plrHurtbox.y,particleType,1);

whiteScreen = true;