waitTime = 0;
lineData = [];
startCode = false;
alarmSuccess = false;
stringOfThing = "Idk"


startFunction = function() {
	global.currentLine += 1;
	global.currentLetters = 1;
	array_resize(global.cTextINFO,0);
	array_push(global.cTextINFO,
	{
	"type_": lineData.type_,
	"text_": lineData.text_,
	"pos": [lineData.pos[0],lineData.pos[1]],
	"icon": lineData.icon,
	"expression": lineData.expression,
	"speed_": lineData.speed_,
	"txtSnd": lineData.txtSnd,
	"font": lineData.font,
	"voiceLine": lineData.voiceLine,
	"code": lineData.code,
	});

	//show_debug_message(lineData);

	alarm[1] = game_get_speed(gamespeed_fps) * 1;
};