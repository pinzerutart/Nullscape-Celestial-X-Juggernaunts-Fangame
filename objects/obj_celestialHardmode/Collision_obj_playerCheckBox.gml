instance_destroy(other);
if global.celestialHardmode == true {
	global.celestialHardmode = false;
	image_blend = make_colour_rgb(255,255,255);
} else if global.celestialHardmode == false {
	global.celestialHardmode = true;
	image_blend = make_colour_rgb(255,0,0);
}