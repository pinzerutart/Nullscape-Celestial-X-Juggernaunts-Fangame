beamBang = 1;
sprite_index = spr_celestial_circle4_beam;
image_yscale = 4 * scale;
image_xscale = 2 * scale;
image_alpha = 1;

alarm[1] = game_get_speed(gamespeed_fps) * 0.1;

_ps = part_system_create();
part_system_depth(_ps,depth + 1);
part_system_draw_order(_ps, true);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_celestial_circleBig, false, false, false)
part_type_size(_ptype1, 1, 1, -0.01, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 8, 14, -0.1, 0);
part_type_direction(_ptype1, 0, 180, 0, 0);
part_type_gravity(_ptype1, 0.01, 278);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $7272FF, $5B5BFF, $6868FF);
part_type_alpha3(_ptype1, 1, 1, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 75, 150);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, 0, 0, -750, 750, ps_shape_rectangle, ps_distr_linear);
part_emitter_burst(_ps, _pemit1, _ptype1, 25 * scale);

part_system_position(_ps, x, y);
