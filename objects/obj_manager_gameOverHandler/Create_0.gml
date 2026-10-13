var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

obj_gameOverScreenThing.sprite_index = spr_gameOverRedScreen;
obj_gameOverScreenThing.image_alpha = 0.6;
obj_gameOverScreenThing.x = global.camPositionX - (camWidth / 4);
obj_gameOverScreenThing.y = global.camPositionY - (camWidth / 4);

volumeOfSound = 1;
shakeT = 0;
shakeCD = false;
shakePower = 10;
if part_system_exists(global.particleHurtPart) { part_system_destroy(global.particleHurtPart); }

camera_set_view_pos(view_camera[0],global.camPositionX,global.camPositionY);

obj_plrHurtbox.x = global.soulPositionX;
obj_plrHurtbox.y = global.soulPositionY;

oldPos[0] = obj_plrHurtbox.x
oldPos[1] = obj_plrHurtbox.y

audio_play_sound(snd_damageUT_c,10,false,1);
alarm[0] = game_get_speed(gamespeed_fps) * 3.5;
alarm[2] = game_get_speed(gamespeed_fps) * 1;
