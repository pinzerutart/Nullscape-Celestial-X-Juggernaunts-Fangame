if startCode == true {
	if alarmSuccess == false and global.currentLine == real(stringOfThing) {
		alarmSuccess = true;
		if waitTime > 0 {
			alarm[0] = game_get_speed(gamespeed_fps) * waitTime;
		} else if waitTime <= 0 {
			startFunction();	
		};
	};
};