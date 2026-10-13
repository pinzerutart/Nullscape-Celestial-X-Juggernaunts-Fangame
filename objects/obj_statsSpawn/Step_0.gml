camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);
currentX = camera_get_view_x(view_camera[0]);
currentY = camera_get_view_y(view_camera[0]);


//SP BAR
var spBarOffsetY = camHeight - (spBar.sprite_height * 1);
spBar.x = (currentX + (camWidth / 2));
spBar.y = (currentY + spBarOffsetY);

spBorder.x = spBar.x;
spBorder.y = spBar.y;



// FlY BAR
if instance_exists(obj_arm_RealWings) {
	var FlyBar = obj_arm_RealWings.Bar;
	var FlyBorder = obj_arm_RealWings.Border;
	
	var BarOffsetY = camHeight - (FlyBar.sprite_height * 2);
	FlyBar.x = (currentX + (camWidth / 2));
	FlyBar.y = (currentY + BarOffsetY);

	FlyBorder.x = FlyBar.x;
	FlyBorder.y = FlyBar.y;
}




