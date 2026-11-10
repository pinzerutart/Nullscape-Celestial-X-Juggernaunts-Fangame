beamBang = 2;
audio_play_sound(snd_celestial_daggerFire,10,false,0.3); 

if multiplier == 1 and (obj_PlayerPlat.walkDirectionMultiplier > 0 or global.plrMoving <= 0) {
	damage(0,50 * dmgMultiplier,5,obj_npcMain.ATK,5,0,snd_shieldBreak,0);
} else if multiplier == -1 and (obj_PlayerPlat.walkDirectionMultiplier < 0 or global.plrMoving <= 0) {
	damage(0,50 * dmgMultiplier,5,obj_npcMain.ATK,5,0,snd_shieldBreak,0);
}