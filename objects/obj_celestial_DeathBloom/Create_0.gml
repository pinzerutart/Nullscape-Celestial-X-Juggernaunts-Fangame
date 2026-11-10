image_angle = random_range(-180,180);
image_alpha = 0;


multiplier = 1;
if round(random_range(1,2)) == 2 {multiplier = -1;}
randomAngleRotate = image_angle + (random_range(20,40) * multiplier);
beamBang = 0;
bangStart = 5.5;
waitForStartBang = true;
bangStarting = false;
sizeMultiplier = 1;
dmgMultiplier = 1;
coreObject = 0;
objectToLook = 0;
mainOne = true;
angleOffset = 0;

_ps2 = false;
_ptype2 = false;
_pemit2 = false;

//partc_celestial_DIB_warning
_ps1 = part_system_create();
part_system_global_space(_ps1,false);
part_system_draw_order(_ps1, true);
part_system_depth(_ps1,depth);

//Emitter
_ptype1 = part_type_create();
part_type_sprite(_ptype1, spr_celestial_circle2, false, false, false)
part_type_size(_ptype1, 5, 5, 0.025, 0);
part_type_scale(_ptype1, 35, 0.5);
part_type_speed(_ptype1, 3, 3, 0, 0);
part_type_direction(_ptype1, 0, 360, 0, 0);
part_type_gravity(_ptype1, 0, 0);
part_type_orientation(_ptype1, 0, 0, 0, 0, false);
part_type_colour3(_ptype1, $00004F, $5454FF, $FFFFFF);
part_type_alpha3(_ptype1, 0.165, 0.039, 0);
part_type_blend(_ptype1, true);
part_type_life(_ptype1, 25, 25);

_pemit1 = part_emitter_create(_ps1);
part_emitter_region(_ps1, _pemit1, 0, 0, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(_ps1, _pemit1, _ptype1, 1);
part_emitter_interval(_ps1, _pemit1, 0.01, 0.01, time_source_units_seconds);

part_system_position(_ps1, x, y);
