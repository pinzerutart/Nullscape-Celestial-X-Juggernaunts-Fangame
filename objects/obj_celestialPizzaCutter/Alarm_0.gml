beamBang = 1;
sprite_index = spr_celestial_pizzaCutter2;
if global.celestialHardmode == true { sprite_index = spr_celestial_pizzaCutter2_Hard; }
image_alpha = 1;

alarm[1] = game_get_speed(gamespeed_fps) * 0.1;


//partc_celestialCutterParticles1
_ps = part_system_create();
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_celestial_circleBig, false, false, false)
part_type_size(_ptype1, 1, 1, 0, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 16, 23, -0.1, 0);
part_type_direction(_ptype1, 0, 180, 0, 0);
part_type_gravity(_ptype1, 0, 278);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FF1677);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 25, 250);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -1750, 1750, -1750, 1750, ps_shape_rectangle, ps_distr_linear);
part_emitter_burst(_ps, _pemit1, _ptype1, 100);

part_system_position(_ps, x, y);
