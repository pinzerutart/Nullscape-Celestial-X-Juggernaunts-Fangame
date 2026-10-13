retryButton = instance_create_layer(419,473,layer_get_id("Instances"),obj_mainMenu_Text);
retryButton.textTo = "Retry";
giveUpButton = instance_create_layer(750,473,layer_get_id("Instances"),obj_mainMenu_Text);
giveUpButton.textTo = "Give Up";

particlePart = 0;
particleType = 0;
buttonId = 0;
theRedScreenEnd = false;
selectedButton = retryButton;
currentMenuId = 0;
buttonsMainMenu = [
	retryButton,
	giveUpButton,
];
currentButtons = buttonsMainMenu;
soul = 0;
moveSoulCenter = false;
whiteScreen = false;
particleSizeGainThing = 1;