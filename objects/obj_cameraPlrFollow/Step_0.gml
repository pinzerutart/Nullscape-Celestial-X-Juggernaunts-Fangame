var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var objectTo = obj_PlayerMap;
var yOffsetThing = 0;

if (instance_exists(obj_PlayerMap)) and global.inPlatformer <= 0 {
	objectTo = obj_PlayerMap;
	yOffsetThing = 33;
}

if (instance_exists(obj_PlayerPlat)) and global.inPlatformer >= 1 {
	objectTo = obj_PlayerPlat;
}


var targetX = objectTo.x - (camWidth / 2);
var targetY = (objectTo.y - yOffsetThing) - (camHeight / 2);

var currentX = camera_get_view_x(view_camera[0]);
var currentY = camera_get_view_y(view_camera[0]);

var newCamX = lerp(currentX,targetX,0.1);
var newCamY = lerp(currentY,targetY,0.1);

if doX == false { newCamX = camera_get_view_x(view_camera[0]); }
if doY == false { newCamY = camera_get_view_y(view_camera[0]); }

camera_set_view_pos(view_camera[0],newCamX,newCamY);
