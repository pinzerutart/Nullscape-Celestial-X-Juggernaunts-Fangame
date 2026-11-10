camera_set_view_size(view_camera[0],global.defaultCamWidth * global.cameraZoom,global.defaultCamHeight * global.cameraZoom);
surface_resize(application_surface, global.defaultCamWidth, global.defaultCamHeight);

var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

obj_gameOverScreenThing.sprite_index = spr_gameOverRedScreen;
obj_gameOverScreenThing.image_alpha = 0.6;
obj_gameOverScreenThing.x = global.camPositionX - (camWidth);
obj_gameOverScreenThing.y = global.camPositionY - (camWidth );
obj_gameOverScreenThing.image_xscale = 25 * global.camformulaWidth;
obj_gameOverScreenThing.image_yscale = 25 * global.camformulaHeight;

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

var quotes = ["YOU FOUGHT IN VAIN.", "FAREWELL.", "FELLED.", "NEXT.", "MERELY MORTAL.", "FRAGILE."]

var _activity = new DiscordActivity();
_activity.type = DiscordActivityTypes.Playing;
_activity.details = quotes[irandom_range(0,array_length(quotes) - 1)];
_activity.state = "-FAIL/0";

var _ts = new DiscordActivityTimestamps();
_activity.timestamps = _ts;

discord_social_client_update_rich_presence(_activity, function(_result) {
    if (!_result.successful) show_debug_message(_result.error);
});