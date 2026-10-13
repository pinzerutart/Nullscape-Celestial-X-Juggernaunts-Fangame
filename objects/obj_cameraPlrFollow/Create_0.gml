var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);

var objectTo = obj_PlayerMap;
var yOffsetThing = 0;
doX = true;
doY = true;

if (instance_exists(obj_PlayerMap)) and global.inPlatformer <= 0 {
	objectTo = obj_PlayerMap;
	yOffsetThing = 33;
}

if (instance_exists(obj_PlayerPlat)) and global.inPlatformer >= 1 {
	objectTo = obj_PlayerPlat;
}
