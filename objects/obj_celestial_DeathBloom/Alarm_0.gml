depth = obj_PlayerPlat.depth - 2;

alarm[1] = game_get_speed(gamespeed_fps) * 12.5;

part_system_destroy(_ps1);
part_type_destroy(_ptype1);

//partc_celestial_DIB_outside
_ps1 = part_system_create();
part_system_global_space(_ps1, false);
part_system_draw_order(_ps1, true);
part_system_depth(_ps1,depth);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_celestial_circle2, false, false, false)
part_type_size(_ptype1, 5, 5, 0.025, 0);
part_type_scale(_ptype1, 35, 3);
part_type_speed(_ptype1, 5, 5, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $0000FF, $7C7CFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 0.231, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 25, 25);

var _pemit1 = part_emitter_create(_ps1);
part_emitter_region(_ps1, _pemit1, 0, 0, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps1, _pemit1, _ptype1, 1);
part_emitter_interval(_ps1, _pemit1, 0.01, 0.01, time_source_units_seconds);

part_system_position(_ps1, x, y);

//partc_celestial_DIB_inside
_ps2 = part_system_create();
part_system_global_space(_ps2, false);
part_system_draw_order(_ps2, true);
part_system_depth(_ps1,depth - 1);

//Emitter
_ptype2 = part_type_create();
part_type_sprite(_ptype2, spr_celestial_circle2, false, false, false)
part_type_size(_ptype2, 1, 1, 0.2, 0);
part_type_scale(_ptype2, 35, 2);
part_type_speed(_ptype2, 1, 1, 0, 0);
part_type_direction(_ptype2, 0, 360, 0, 0);
part_type_gravity(_ptype2, 0, 0);
part_type_orientation(_ptype2, 0, 0, 0, 0, false);
part_type_colour3(_ptype2, $000000, $000000, $000000);
part_type_alpha3(_ptype2, 1, 0.608, 0);
part_type_blend(_ptype2, false);
part_type_life(_ptype2, 25, 25);

_pemit2 = part_emitter_create(_ps2);
part_emitter_region(_ps2, _pemit2, 0, 0, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps2, _pemit2, _ptype2, 1);
part_emitter_interval(_ps2, _pemit2, 0.01, 0.01, time_source_units_seconds);

part_system_position(_ps2, x, y);

beamBang = 1;
