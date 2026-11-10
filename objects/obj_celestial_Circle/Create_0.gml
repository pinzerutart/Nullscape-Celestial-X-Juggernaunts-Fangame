image_yscale = 0;
image_xscale = 0;
image_alpha = 1;
x += random_range(-650,650);

multiplier = 1;
if round(random_range(1,2)) == 2 {multiplier = -1;}
randomPosition = x + (random_range(200,3000) * multiplier);
beamBang = 0;
bangStart = 2;
waitForStartBang = true;
bangStarting = false;
scale = 1;

//partc_celestialCircle_efc1
_ps = 0;
_ptype1 = 0;