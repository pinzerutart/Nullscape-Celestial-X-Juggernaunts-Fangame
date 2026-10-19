var ability = function() {
	if cd == false and global.plrSoftlock <= 0 {
		cd = true;
		alarm[0] = game_get_speed(gamespeed_fps) * 0.185;
	}
}

if clearTime > 0 {
	clearTime -= delta_time / 1000000;
	if cleared == true {
		cleared = false;
	}
}else if clearTime <= 0 {
	if cleared == false {
		cleared = true;
	}
}

button_key = keyboard_check(ord("Z"));
if button_key {
	ability()
}