obj_plrHurtbox.image_alpha = 0;
particlePart = part_system_create(partc_redShatter);
part_system_position(particlePart,obj_plrHurtbox.x, obj_plrHurtbox.y);
audio_play_sound(snd_soulShatter,10,false,1);