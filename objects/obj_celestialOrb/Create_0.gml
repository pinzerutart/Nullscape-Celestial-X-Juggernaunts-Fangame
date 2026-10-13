image_yscale = 0;
image_xscale = 0;
image_alpha = 1;


multiplier = 1;
beamBang = 0;
bangStart = 1.5;
waitForStartBang = true;
bangStarting = false;
sizeThingy = 0.01
scaleThing = 1;
endedThing1 = false;
effectThingy = 0;

//Emitter
//partc_orbSpawnEffect
_ps = part_system_create();
part_system_draw_order(_ps, true);
part_system_depth(_ps,depth + 1);

_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_celestial_orbEffect, false, false, false)
part_type_size(_ptype1, 5, 5, 0.5, 0);
part_type_scale(_ptype1, 0, 1.2);
part_type_speed(_ptype1, 0, 0, 0, 0);
part_type_direction(_ptype1, 0, 180, 0, 0);
part_type_gravity(_ptype1, 0, 278);
part_type_orientation(_ptype1, 90, 90, 0, 0, false);
part_type_colour3(_ptype1, $8989FF, $6868FF, $7272FF);
part_type_alpha3(_ptype1, 0.831, 0.114, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 20, 20);

_pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);
part_emitter_interval(_ps, _pemit1, 0.05, 0.05, time_source_units_seconds);

part_system_position(_ps, x, y);
