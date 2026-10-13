camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);
currentX = camera_get_view_x(view_camera[0]);
currentY = camera_get_view_y(view_camera[0]);


spBar = instance_create_layer(x, y, global.layerBattleID, obj_spBar);
spBar.image_blend = make_colour_rgb(108,207,255);
spBar.depth = -999;
spBar.image_xscale = 0.15;
spBar.image_yscale = 0.15;
spBorder = instance_create_layer(x, y, global.layerBattleID, obj_spBorder);
spBorder.image_blend = make_colour_rgb(39,180,250);
spBorder.depth = -999;
spBorder.image_xscale = 0.15;
spBorder.image_yscale = 0.15;
