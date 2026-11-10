if waitForStartBang == false and bangStarting == false { bangStarting = true; alarm[0] = game_get_speed(gamespeed_fps) * bangStart; }

var pointDirection = point_direction(coreObject.x,coreObject.y,objectToLook.x,objectToLook.y)
var distanceToBoss = point_distance(coreObject.x,coreObject.y,objectToLook.x,objectToLook.y);
var beamSize = 60;

image_yscale = 8 * sizeMultiplier;
image_xscale = beamSize;

var halfBeam = sprite_width * 0.5;
var lengthdirXfFormula = coreObject.x + lengthdir_x(halfBeam, image_angle);
var lengthdirYfFormula = coreObject.y + lengthdir_y(halfBeam, image_angle);

x = lengthdirXfFormula;
y = lengthdirYfFormula;
if part_system_exists(_ps1) {
	part_system_position(_ps1, lengthdirXfFormula, lengthdirYfFormula);
}
if part_system_exists(_ps2) {
	part_system_position(_ps2, lengthdirXfFormula, lengthdirYfFormula);
}


var endFormula = pointDirection + 360 * round((image_angle - pointDirection) / 360);
var _speed = 3;
if global.celestialHardmode { _speed += 1 }
var finalFormula = lerp(image_angle, endFormula + angleOffset, _speed / 100);
image_angle = finalFormula;
if part_type_exists(_ptype1) { part_system_angle(_ps1, image_angle); }
if part_type_exists(_ptype2) { part_system_angle(_ps2, image_angle); }



if mainOne == true {
	if distanceToBoss <= 1000 and coreObject.enemyType == 998 {
		coreObject.positionXTo -= lengthdir_x((1000 - distanceToBoss) / 25,pointDirection);
		coreObject.positionYTo -= lengthdir_y((1000 - distanceToBoss) / 25,pointDirection);
	} else if distanceToBoss >= 20000 and coreObject.enemyType == 998 {
		coreObject.positionXTo += lengthdir_x(10,pointDirection);
		coreObject.positionYTo += lengthdir_y(10,pointDirection);
	}
}

if global.plrDied == true and part_system_exists(_ps1) {
	part_system_destroy(_ps1);
	part_type_destroy(_ptype1);
	
	if beamBang >= 1 {
		part_system_destroy(_ps2);
		part_type_destroy(_ptype2);
	}
}

