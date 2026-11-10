if startCode == false { exit; }

camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);
currentX = camera_get_view_x(view_camera[0]);
currentY = camera_get_view_y(view_camera[0]);

pressedF4 = keyboard_check_pressed(vk_f11);
if pressedF4 {
    if f4Thing == 0 {
        f4Thing = 1;
        window_enable_borderless_fullscreen(true);
        window_set_fullscreen(true);
    } else if f4Thing == 1 {
        f4Thing = 0;
        window_set_fullscreen(false);
    }
}

if mouse_wheel_up() {
	if global.cameraZoom > 0.3 {
		global.cameraZoom -= 0.1;
	}
}

if mouse_wheel_down() {
	if global.cameraZoom < maxZoom {
		global.cameraZoom += 0.1;
	}
}

global.camformulaWidth = (camWidth / global.defaultCamWidth)
global.camformulaHeight = (camHeight / global.defaultCamHeight)

if (updateWindowCD == false and (window_get_width != global.defaultCamWidth or window_get_width != global.defaultCamHeight)) or lastRoom != room or global.cameraZoom != lastCamZoom {
	global.defaultCamWidth = window_get_width();
	global.defaultCamHeight = window_get_height();

	camera_set_view_size(view_camera[0],global.defaultCamWidth * global.cameraZoom,global.defaultCamHeight * global.cameraZoom);
	surface_resize(application_surface, global.defaultCamWidth, global.defaultCamHeight);
	
	updateWindowCD = true;
	lastRoom = room;
	lastCamZoom = global.cameraZoom;
	alarm[0] = game_get_speed(gamespeed_fps) * 0.5
}

discord_social_run_callbacks();