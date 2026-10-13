if obj_gameOverScreenThing.image_alpha > 0 and whiteScreen == false {
	obj_gameOverScreenThing.image_alpha -= 0.025;
}
if obj_gameOverScreenThing.image_alpha < 1.3 and whiteScreen == true and theRedScreenEnd == false {
	obj_gameOverScreenThing.image_alpha += 0.01;
} else if obj_gameOverScreenThing.image_alpha > 0.05 and theRedScreenEnd == true {
	obj_gameOverScreenThing.image_alpha -= 0.025;
}

if obj_gameOverScreenThing.image_alpha >= 1.29 and whiteScreen == true and theRedScreenEnd == false {
	theRedScreenEnd = true;
	obj_plrHurtbox.image_alpha = 0;
}


if whiteScreen == true {
	if particleSizeGainThing > 0.01 {
		particleSizeGainThing -= 0.01;
		part_type_size(particleType,2,2,particleSizeGainThing,0);
	}
}

var visualChangePre = function(){
	selectedButton.color1 = make_colour_rgb(255,255,255);
	selectedButton.color2 = make_colour_rgb(255,255,255);
};

var visualChange = function(){
	if currentMenuId == 1 { exit; }
	selectedButton.color1 = make_colour_rgb(255,255,0);
	selectedButton.color2 = make_colour_rgb(255,255,0);
};

visualChange()

buttonMove = keyboard_check_pressed( ord("A") );
if buttonMove and buttonId > 0 and currentMenuId != 1 {
	buttonId -= 1;
	visualChangePre();
	selectedButton = currentButtons[buttonId];
	visualChange();
};
buttonMove = keyboard_check_pressed( ord("D") );
if buttonMove and buttonId < 1 and currentMenuId != 1 {
	buttonId += 1;
	visualChangePre();
	selectedButton = currentButtons[buttonId];
	visualChange();
};

if moveSoulCenter == true {
	soul.x = lerp(soul.x,675,0.05);
	soul.y = lerp(soul.y,376,0.05);
}

buttonPress = keyboard_check_pressed(ord("Z")) or keyboard_check_pressed(vk_enter);
if buttonPress {
	if currentMenuId == 0 {
		if buttonId == 0 {
			currentMenuId = 1;
			
			soul = instance_create_layer(retryButton.x + 50,retryButton.y,layer_get_id("Instances"),obj_plrHurtbox);
			soul.image_xscale = 2;
			soul.image_yscale = 2;
			
			instance_destroy(retryButton);
			instance_destroy(giveUpButton);
			instance_destroy(obj_titleGameover);
			
			alarm[2] = game_get_speed(gamespeed_fps) * 1.75;
			alarm[1] = game_get_speed(gamespeed_fps) * 0.7;
			alarm[0] = game_get_speed(gamespeed_fps) * 7;
		}else if buttonId == 1 {
			game_end();
		}
	}
}