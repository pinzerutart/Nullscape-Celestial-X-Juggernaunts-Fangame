if waitForStartBang == false and bangStarting == false { bangStarting = true;
	alarm[0] = game_get_speed(gamespeed_fps) * aimStart;
	alarm[1] = game_get_speed(gamespeed_fps) * bangStart;
	alarm[2] = game_get_speed(gamespeed_fps) * fireStart;
}


if beamBang == 0 {	
	image_alpha = lerp(image_alpha,1,0.1);
	rgbData[0] = lerp(rgbData[0],213,0.005);
	rgbData[1] = lerp(rgbData[1],0,0.005);
	rgbData[2] = lerp(rgbData[2],254,0.005);
	image_blend = make_colour_rgb(rgbData[0],rgbData[1],rgbData[2]);
	image_angle += 2 * multiplier;
} else if beamBang == 1 {
	//image_blend = lerp(image_blend, make_colour_rgb(213,0,254), 0.1);
	image_blend = make_colour_rgb(213,0,254);
	image_angle = lerp(image_angle, 90 * multiplier, 0.1);
} else if beamBang == 2 {
	if multiplier == 1 {
		xOffset = lerp(xOffset, sprite_width * -3, 0.1);
	} else if multiplier == -1 {
		xOffset = lerp(xOffset, sprite_width * 3, 0.1);
	}
	
	image_alpha = lerp(image_alpha,0,0.025);
}

var distanceThingy = sprite_width * 3;
var lengthdirXfFormula = coreObject.x + lengthdir_x(distanceThingy, image_angle - 90);
var lengthdirYfFormula = coreObject.y + lengthdir_y(distanceThingy, image_angle - 90);
x = lengthdirXfFormula + xOffset;
y = lengthdirYfFormula;

if global.plrDied == true {
}

