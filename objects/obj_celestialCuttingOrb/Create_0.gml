image_yscale = 0;
image_xscale = 0;
image_alpha = 1;
image_angle = irandom_range(0,360);


multiplier = 1;
beamBang = 0;
bangStart = 1;
waitForStartBang = true;
bangStarting = false;
xOffset = x + irandom_range(-200,200);
yOffset = y + irandom_range(-200,200);
_speed = 20;
_dir = 0;
_rotationSpeed = 0.05;
explodedT = false;
inverted = 1;


//partc_celestialCuttingOrb
_ps = part_system_create();
part_system_draw_order(_ps, true);
part_system_global_space(_ps, true);
part_system_depth(_ps,depth + 1);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_celestial_circle5, false, false, false)
part_type_size(_ptype1, 0.5, 0.5, -0.01, 0);
part_type_scale(_ptype1, 1, 1);
part_type_speed(_ptype1, 0.2, 1, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(_ptype1, 1, 0.522, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 60, 60);

var _pemit1 = part_emitter_create(_ps);
part_emitter_region(_ps, _pemit1, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps, _pemit1, _ptype1, 1);
part_emitter_interval(_ps, _pemit1, 0.01, 0.01, time_source_units_seconds);
