beamBang = 1;
sprite_index = spr_celestial_orbExplode;
image_yscale = 13;
image_xscale = 13;
image_alpha = 1;
part_emitter_stream(_ps, _pemit1, _ptype1, 0);

alarm[1] = game_get_speed(gamespeed_fps) * 0.1;