f4Thing = 0;
audio_master_gain(0.4);
global.defaultCamWidth = window_get_width();
global.defaultCamHeight = window_get_width();
updateWindowCD = false;
global.cameraZoom = 1;
lastCamZoom = 1;
lastRoom = room;
maxZoom = 3;
startCode = false;


discord_social_init();
discord_social_client_set_application_id(1565368236126638120);

var _activity = new DiscordActivity();
_activity.type = DiscordActivityTypes.Playing;
_activity.details = "USER'S OWN PRISON.";
_activity.state = "-0/0";

var _ts = new DiscordActivityTimestamps();
_activity.timestamps = _ts;

discord_social_client_update_rich_presence(_activity, function(_result) {
    if (!_result.successful) show_debug_message(_result.error);
});

alarm[1] = game_get_speed(gamespeed_fps) * 0.5