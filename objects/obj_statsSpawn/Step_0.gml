camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);
currentX = camera_get_view_x(view_camera[0]);
currentY = camera_get_view_y(view_camera[0]);

// SP BAR
var spBarOffsetY = camHeight - (spBar.sprite_height * 1);
spBar.x = (currentX + (camWidth / 2));
spBar.y = (currentY + spBarOffsetY);
spBorder.x = spBar.x;
spBorder.y = spBar.y;

spBar.image_yscale = 0.15 * global.camformulaHeight;
spBorder.image_yscale = 0.15 * global.camformulaHeight;
spBorder.image_xscale = 0.15 * global.camformulaWidth;

// FlY BAR
if instance_exists(obj_upg_Wings) {
	var FlyBar = obj_upg_Wings.Bar;
	var FlyBorder = obj_upg_Wings.Border;
	
	var BarOffsetY = camHeight - (FlyBar.sprite_height * 2);
	FlyBar.x = (currentX + (camWidth / 2));
	FlyBar.y = (currentY + BarOffsetY);
	FlyBar.image_yscale = 0.15 * global.camformulaHeight;
	FlyBorder.image_xscale = 0.15 * global.camformulaWidth;
	FlyBorder.image_yscale = 0.15 * global.camformulaHeight;

	FlyBorder.x = FlyBar.x;
	FlyBorder.y = FlyBar.y;
}

// HP TEXT, ICON
redHP.x = spBorder.x + round(spBorder.sprite_width / 1.7);
redHP.y = currentY + (camHeight - (redHP.sprite_height * 1));

redHP.image_xscale = 2 * global.camformulaWidth;
redHP.image_yscale = 2 * global.camformulaHeight;