image_yscale = 0;
image_xscale = 46;
image_angle = random_range(-180,180);
image_alpha = 0.7;


multiplier = 1;
if round(random_range(1,2)) == 2 {multiplier = -1;}
randomAngleRotate = image_angle + (random_range(20,40) * multiplier);
beamBang = 0;
bangStart = 0.5;
waitForStartBang = true;
bangStarting = false;