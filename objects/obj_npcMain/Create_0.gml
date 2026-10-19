// STATS
HP = 100;
MaxHp = 100;
wSpeed = 19;
ATK = 5;
DF = 0;
Resistance = 0;
Moving = 0;
Softlock = 0;
InvF = 0;


// VARIABLES
camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);

died = false;
looking = "R";
lookAtPlayer = 1;
enemyType = 0;
currentSpriteID = 0;
catk = 0;
cd1 = false;
bodyXOffset = 0;
bodyYOffset = 0;
distanceToPlayer = 99999;
thePlayer = obj_PlayerPlat;
stopAnimOnEnd = false;
lastAttackID = 0;
attacksAllowed = [];
attackInCD = {};
positionXTo = 0;
positionYTo = 0;
startPositiong = 0;
lastHP = HP

celesteIntro = false;
celesteAppearedIntro = false;
celestialDisappearIntro = true;
celestialComboAmount = -1;
celestialComboRestoreCD = false;
celestialOrbs = 1;
celestialCutterAmountDid = 0;
celestialAttackAddedCounter = 0;
celestialStartIntroText = false;
celestialDialogID = generateID();

// VISUAL
image_alpha = 0;


body = instance_create_depth(x, y, depth, obj_npcSprite);
body.npcMain = id;
body.image_xscale = 1;
body.image_yscale = 1;
body.image_speed = 1;

textTableIntro = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][0],
		"pos": [camWidth / 2, camHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk1,
		"code": "None",
		"delay": 0,
		"LineId": generateID(),
		"origin_": "center",
		"effects": [
			{ "start": 1, "endI": 999, "type_": "randomMovement", "intensity": random_range(1.5,2) },
			{ "start": 1, "endI": 999, "type_": "randomRotations", "intensity": random_range(5,7)  },
			{ "start": 1, "endI": 999, "type_": "color", "cs1": [255,82,137], "cs2": [255,82,137], "cs3": [255,82,137], "cs4": [255,82,137] },
		],
	}],
	
	"1": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][1],
		"pos": [camWidth / 2, camHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk1,
		"code": "None",
		"delay": 4,
		"LineId": generateID(),
		"origin_": "center",
		"effects": [
			{ "start": 1, "endI": 999, "type_": "randomMovement", "intensity": random_range(1.5,2) },
			{ "start": 1, "endI": 999, "type_": "randomRotations", "intensity": random_range(5,7)  },
			{ "start": 1, "endI": 999, "type_": "color", "cs1": [255,82,137], "cs2": [255,82,137], "cs3": [255,82,137], "cs4": [255,82,137] },
		],
	}],
	"2": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][2],
		"pos": [camWidth / 2, camHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk1,
		"code": "None",
		"delay": 4,
		"LineId": generateID(),
		"origin_": "center",
		"effects": [
			{ "start": 1, "endI": 999, "type_": "randomMovement", "intensity": random_range(1.5,2) },
			{ "start": 1, "endI": 999, "type_": "randomRotations", "intensity": random_range(5,7)  },
			{ "start": 1, "endI": 999, "type_": "color", "cs1": [255,82,137], "cs2": [255,82,137], "cs3": [255,82,137], "cs4": [255,82,137] },
		],
	}],
	"3": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][3],
		"pos": [camWidth / 2, camHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk1,
		"code": "None",
		"delay": 4,
		"LineId": generateID(),
		"origin_": "center",
		"effects": [
			{ "start": 1, "endI": 999, "type_": "randomMovement", "intensity": random_range(1.5,2) },
			{ "start": 1, "endI": 999, "type_": "randomRotations", "intensity": random_range(5,7)  },
			{ "start": 1, "endI": 999, "type_": "color", "cs1": [255,82,137], "cs2": [255,82,137], "cs3": [255,82,137], "cs4": [255,82,137] },
		],
	}],
	"4": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][4],
		"pos": [camWidth / 2, camHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk4,
		"code": "None",
		"delay": 4,
		"LineId": generateID(),
		"origin_": "center",
		"effects": [
			{ "start": 1, "endI": 999, "type_": "randomMovement", "intensity": random_range(1.5,2) },
			{ "start": 1, "endI": 999, "type_": "randomRotations", "intensity": random_range(5,7)  },
			{ "start": 1, "endI": 999, "type_": "color", "cs1": [255,82,137], "cs2": [255,82,137], "cs3": [255,82,137], "cs4": [255,82,137] },
		],
	}],
};

// Enemy Type 999 is "Flowery"
// Enemy Type 998 is "Celestial"