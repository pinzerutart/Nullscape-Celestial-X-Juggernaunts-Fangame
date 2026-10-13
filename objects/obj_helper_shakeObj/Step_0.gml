if startCode == false { exit; }
if oneSideRun == false {
	oneSideRun = true;
	if strength < 0 { strength *= -1; Sided = 1; }
}

if (strength <= 0.04 and strength > 0) or (strength >= -0.04 and strength < 0) {
	strength = 0;
	instance_destroy();
	exit;
}

if inCooldown == false {
	inCooldown = true;
	
	alarm[0] = game_get_speed(gamespeed_fps) * cdS;
	
	if Sided == 0 { objectToShake.x += strength; }
	if Sided == 1 { objectToShake.y += strength; }
	
	if origPos == false { 
		if typeShake == 0 {
			strength *= -lose;
		}else {typeShake = -1;}
	}else {
		if typeShake > 0 {
			if Sided == 0 { objectToShake.x = origPos[0]; }
			if Sided == 1 { objectToShake.y = origPos[1]; }
			if Sided == 2 { objectToShake.x = origPos[0]; objectToShake.y = origPos[1]; }
		}
	}
	
	typeShake += 1;
}