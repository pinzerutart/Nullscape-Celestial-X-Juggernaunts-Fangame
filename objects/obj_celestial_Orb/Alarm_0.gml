beamBang = 1;
sprite_index = spr_celestial_orbExplode;
image_yscale = 13 * scale;
image_xscale = 13 * scale;
image_alpha = 1;
if part_system_exists(_ps) { part_emitter_stream(_ps, _pemit1, _ptype1, 0); }

alarm[1] = game_get_speed(gamespeed_fps) * 0.1;

if global.celestialHardmode == true {
	var _distance = point_direction(x, y, obj_PlayerPlat.x, obj_PlayerPlat.y);
	var _direction = point_direction(x, y, obj_PlayerPlat.x, obj_PlayerPlat.y);
	if _distance <= 20 * scale {
		global.plrForce[0] = lengthdir_x(((60 * scale) - _distance) / 3.5, _direction);
		global.plrForce[1] = lengthdir_y(((60 * scale) - _distance) / 3.5, _direction);
	}
	
	_ps2 = part_system_create();
	part_system_draw_order(_ps2, true);
	part_system_depth(_ps2,depth + 1);
	part_system_position(_ps2, x,y);
		
	_ptype2 = part_type_create();
	part_type_sprite(_ptype2, spr_circleHole, false, false, false)
	part_type_size(_ptype2, 0, 0, 0.3 * scale, 0);
	part_type_scale(_ptype2, 1, 1);
	part_type_speed(_ptype2, 0, 0, 0, 0);
	part_type_direction(_ptype2, 0, 180, 0, 0);
	part_type_gravity(_ptype2, 0, 278);
	part_type_orientation(_ptype2, 90, 90, 0, 0, false);
	part_type_colour3(_ptype2, $FF00DD, $6868FF, $7272FF);
	part_type_alpha3(_ptype2, 0.831, 0.114, 0);
	part_type_blend(_ptype2, true);
	part_type_life(_ptype2, 25, 50);

	_pemit2 = part_emitter_create(_ps2);
	part_emitter_region(_ps2, _pemit2, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
	part_emitter_burst(_ps2, _pemit2, _ptype2, 1);

	call_later(1,time_source_units_seconds,function(){ if part_system_exists(_ps2) { part_system_destroy(_ps2); part_type_destroy(_ptype2); } });
}