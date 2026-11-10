image_angle = random_range(-180,180);
image_alpha = 0;
image_yscale = 2;
image_xscale = 2;
image_blend = make_colour_rgb(213,0,254);

multiplier = 1;
if irandom_range(1,2) == 2 { multiplier = -1; }
beamBang = 0;
bangStart = 0.5;
aimStart = 3;
waitForStartBang = true;
bangStarting = false;
sizeMultiplier = 1;
dmgMultiplier = 1;
coreObject = 0;
xOffset = 0;
rgbData = [213,0,254];