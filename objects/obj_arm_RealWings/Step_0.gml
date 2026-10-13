var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
var currentX = camera_get_view_x(view_camera[0]);
var currentY = camera_get_view_y(view_camera[0]);

Bar.image_xscale = clamp((obj_PlayerPlat.flyAmount / obj_PlayerPlat.defaultFlyAmount) / 6.7,0,1);