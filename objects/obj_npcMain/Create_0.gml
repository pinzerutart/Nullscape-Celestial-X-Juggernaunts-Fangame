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
lastHP = HP;
themeMusic = snd_nothing;
death2 = false;

celesteIntro = false;
celesteAppearedIntro = false;
celestialDisappearIntro = true;
celestialComboAmount = -1;
celestialComboRestoreCD = false;
celestialOrbs = 1;
celestialCutterAmountDid = 0;
celestialMemoryAmountDid = 0;
celestialDaggerAmountDid = 0;
celestial_Memory_xOffset = 0;
celestial_Memory_yOffset = 0;
celestialAttackAddedCounter = 0;
celestialStartIntroText = false;
celestialDialogID = generateID();
celestialNextAttack = "ORBS";
numberGot = 2;
celestialCurrentDialogTable = false;
celestialDialogATKsSaid = {}
celestialDialogFunction = function(table_,duration_) { celestialCurrentDialogTable = table_; celestialDialogID = generateID(); call_later(duration_,time_source_units_seconds,function(){ celestialCurrentDialogTable = false; });}
celestialBitterThingy = 0;
celestialActivity = "WILT";

// Particle Stuff
_ps1 = 0;
_ptype1 = 0;
_ps2 = 0;
_ptype2 = 0;

// VISUAL
image_alpha = 0;


body = instance_create_depth(x, y, depth, obj_npcSprite);
body.npcMain = id;
body.image_xscale = 1;
body.image_yscale = 1;
body.image_speed = 1;

// Enemy Type 999 is "Flowery"
// Enemy Type 998 is "Celestial"





// DIALOGS
celestialIntroText = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][0],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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


//CELESTIAL ATTACKS DIALOGS
celestial_dlg_FALL = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][5],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
};
celestial_dlg_CRUMBLE = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][6],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk2,
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
};
celestial_dlg_CEASE = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][7],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk3,
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
};
celestial_dlg_INCINERATE = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][8],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
};
celestial_dlg_BITTER = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][9],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
};
celestial_dlg_DEATHINBLOOM = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][10],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk2,
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
};
celestial_dlg_FUTILE = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][11],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk3,
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
};
celestial_dlg_REMEMBRANCE = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][12],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
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
};
celestial_dlg_CUT = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][14],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk2,
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
};
celestial_dlg_SILENCE = {
	"0": [{
		"type_": "Text",
		"text_": global.dialoguesTable[$ global.language][15],
		"pos": [global.defaultCamWidth / 2, global.defaultCamHeight - 300],
		"icon": "None",
		"expression": "None",
		"speed_": 0,
		"txtSnd": snd_nothing,
		"font": font_OMORI_CelestialTalk,
		"voiceLine": snd_celestial_talk2,
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
};
	