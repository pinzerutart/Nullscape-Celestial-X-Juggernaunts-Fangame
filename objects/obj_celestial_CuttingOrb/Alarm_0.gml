beamBang = 1;
if obj_plrHurtbox.x < obj_npcMain.x { _dir = 180; }

var snd_celestial_fire = [snd_celestial_fire1, snd_celestial_fire2, snd_celestial_fire3];
audio_play_sound(snd_celestial_fire[irandom_range(0,2)],1,false,0.4);