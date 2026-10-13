var camWidth = camera_get_view_width(view_camera[0]);
var camHeight = camera_get_view_height(view_camera[0]);
var currentX = camera_get_view_x(view_camera[0]);
var currentY = camera_get_view_y(view_camera[0]);

if enemyType == 998 {
	var color1 = make_colour_rgb(255,255,255);
	var color2 = make_colour_rgb(255,255,255);
	
	draw_set_font(font_homeVideo_2);
	var stringg = string( (0 - (HP - MaxHp)) ) + "/" + string(MaxHp)
	draw_text_colour(currentX + (camWidth / 2.1),(currentY + (camHeight / 1.15)),stringg,color1,color1,color2,color2,1);
}