image_yscale = 0;
image_xscale = 0;
image_angle = random_range(-180,180);
image_alpha = 0;
bitterType = 1;

multiplier = 1;
if irandom_range(1,2) == 2 {multiplier = -1;}
randomAngleRotate = image_angle + (random_range(80,125) * multiplier);
beamBang = 0;
bangStart = 2.5;
waitForStartBang = true;
bangStarting = false;
startFollowing = 2;

if global.celestialHardmode == true { sprite_index = spr_celestial_pizzaCutter1_Hard; }

