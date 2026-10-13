if global.inPlatformer == 0 {
	platformerModeEnable(battleID,obj_PlayerMap.x,obj_PlayerMap.y,obj,objX,objY,introSpeed,backgroundID,battleTheme)
	//alarm[0] = game_get_speed(gamespeed_fps) * 3
	if disappearOneUse == true { instance_destroy(); }
}
