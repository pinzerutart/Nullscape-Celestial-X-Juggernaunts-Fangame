image_yscale = 1;
image_xscale = 1;
image_angle = random_range(-180,180);
image_alpha = 0;


multiplier = 1;
if irandom_range(1,2) == 2 {multiplier = -1;}
randomAngleRotate = image_angle + (random_range(700,750) * multiplier);
beamBang = 0;
bangStart = 2.5;
waitForStartBang = true;
bangStarting = false;
_ps = 0;
_ptype1 = 0;


if global.celestialHardmode == true { sprite_index = spr_celestial_pizzaCutter1_Hard; }

