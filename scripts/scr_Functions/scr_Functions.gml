global.particleHurtPart = part_system_create(partc_redHurt);
part_system_draw_order(global.particleHurtPart, true);
global.particleHurtType = part_type_create();
part_type_sprite(global.particleHurtType, spr_redParticle, false, false, false)
part_type_size(global.particleHurtType, 1, 1, -0.01, 0.1);
part_type_scale(global.particleHurtType, 1, 1);
part_type_speed(global.particleHurtType, 9, 12, -0.05, 0);
part_type_direction(global.particleHurtType, 50, 120, 0, 0);
part_type_gravity(global.particleHurtType, 0.3, 278);
part_type_orientation(global.particleHurtType, 0, 0, 0, 0, false);
part_type_colour3(global.particleHurtType, $FFFFFF, $FFFFFF, $FFFFFF);
part_type_alpha3(global.particleHurtType, 1, 1, 1);
part_type_blend(global.particleHurtType, false);
part_type_life(global.particleHurtType, 160, 160);
var _pemit1 = part_emitter_create(global.particleHurtPart);
part_emitter_region(global.particleHurtPart, _pemit1, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(global.particleHurtPart, _pemit1, global.particleHurtType, 0);
part_emitter_interval(global.particleHurtPart, _pemit1, 0.5, 0.5, time_source_units_seconds);


function generateID() {
    static _counter = 0;
    _counter++;
    return _counter;
};

function shakeObj(theObject, RcdS, Rstrength, Rlose, UorigPos) {
	var helper_shakeObj = instance_create_depth(0,0,0,obj_helper_shakeObj);
	helper_shakeObj.objectToShake = theObject;
	helper_shakeObj.strength = Rstrength;
	helper_shakeObj.lose = Rlose;
	helper_shakeObj.cdS = RcdS;
	helper_shakeObj.origPos = UorigPos;
	helper_shakeObj.startCode = true;
};

function damage(knockback,dmg,bonusDmg,atk,def,invF,sound,type){
	if global.plrInvF <= 0 {
		var actual_damage = dmg + (bonusDmg * atk) - (def * global.plrDF);
		var resistance = clamp(1 - (global.plrResistance / 100),-999,100);
		actual_damage *= resistance;
	
		global.plrHP -= actual_damage;
		global.plrInvF += invF;
		
		
		if room != room_death and actual_damage >= 5 {		
			part_particles_create(global.particleHurtPart,obj_plrHurtbox.x, obj_plrHurtbox.y,global.particleHurtType,( ceil(actual_damage / 18) ));
		}
		
		audio_play_sound(sound,2,false);
		
		if knockback != 0 {
			global.plrForce[0] += knockback[0];
			global.plrForce[1] += knockback[1];
		}
	};
};

function damageNpc(npc,knockback,dmg,bonusDmg,atk,def,invF,sound,type){
	if npc.InvF <= 0 {
		var damageToDo = dmg + (bonusDmg * atk);
		var actual_damage = damageToDo - (def * npc.DF);
		if (damageToDo * 0.05) >= actual_damage {actual_damage = damageToDo * 0.05}
		var resistance = clamp(1 - (npc.Resistance / 100),-999,100);
		actual_damage *= resistance;
		
		actual_damage = round(actual_damage);
	
		npc.HP -= actual_damage;
		npc.InvF += invF;
		
		audio_play_sound(sound,2,false);
	};
};

function heal(amount,bonusAmount,multiplier){
	var beforeHealHP = global.plrHP;
	var maxHP = global.plrMaxHP;
	
	if (beforeHealHP + amount) > maxHP {
		var formula1 = beforeHealHP - maxHP;
		amount -= formula1;
	}
	
	global.plrHP += (amount) + (bonusAmount * multiplier);
};

global.cTextINFO = [];
global.currentdialogID = 0;
global.currentLetters = 1;
global.letterCDThing = false;
global.currentLine = 0;

function textAppear(textTable,id_) {
	if global.currentdialogID != id_ {
		global.currentdialogID = id_;
		global.currentLine = 0;
		struct_foreach(textTable, function(key,value) { 
			var textAppearHeper = instance_create_depth(0,0,0,obj_helper_textAppear);
			textAppearHeper.waitTime = value[0].delay;
			textAppearHeper.lineData = value[0];
			textAppearHeper.stringOfThing = key;
			textAppearHeper.startCode = true;
		});
	};
	var lastIndex = array_length(global.cTextINFO) - 1;
	var	camWidth = camera_get_view_width(view_camera[0]);
	var	camHeight = camera_get_view_height(view_camera[0]);
	var	camX = camera_get_view_x(view_camera[0]);
	var	camY = camera_get_view_y(view_camera[0]);
	
	if (lastIndex >= 0) {
		var textInfo = global.cTextINFO[lastIndex];
		draw_set_font(textInfo.font);
		var text = textInfo.text_;
		var currentLetter = string_copy(text,global.currentLetters,global.currentLetters);
		
		
		var textToShow = string_copy(text, 1, global.currentLetters);
		var effectList = textInfo.effects;

		// Calculate line widths for centering
		var lineWidths = [];
		if (textInfo.origin_ == "center") {
			var tempStr = "";
			for (var i = 1; i <= string_length(text); i++) {
				var c = string_char_at(text, i);
				if (c == "\n") {
					array_push(lineWidths, string_width(tempStr));
					tempStr = "";
				} else {
					tempStr += c;
				}
			}
			array_push(lineWidths, string_width(tempStr));
		}

		var currentLineIndex = 0;
		var txtX = textInfo.pos[0];
		if (textInfo.origin_ == "center") { txtX -= lineWidths[0] / 2; }
		var txtY = textInfo.pos[1];


		for (var charIndex = 1; charIndex <= string_length(textToShow); charIndex++) {
		var character = string_char_at(textToShow, charIndex);
		
		if (character == "\n") {
			txtX = textInfo.pos[0];
			if (textInfo.origin_ == "center") { txtX -= lineWidths[0] / 2; }
			txtY += string_height("M") / 2;
			continue;
		};

		var OffsetX = 0;
		var OffsetY = 0;
		var OffsetRotation = 0;
		var cs1 = make_colour_rgb(255,255,255);
		var cs2 = make_colour_rgb(255,255,255);
		var cs3 = make_colour_rgb(255,255,255);
		var cs4 = make_colour_rgb(255,255,255);

		if (effectList != undefined) {
			for (var effectIndex = 0; effectIndex < array_length(effectList); effectIndex++) {
				var effect = effectList[effectIndex];
				var insideEffectRange = (charIndex >= effect.start and charIndex <= effect.endI);

				if (insideEffectRange and effect.type_ == "shake") {
					var editedTime = current_time * 0.05 + charIndex * 1.7;
					OffsetX += sin(editedTime) * effect.intensity;
					OffsetY += cos(editedTime * 1.3) * effect.intensity;
				};
				if (insideEffectRange and effect.type_ == "color") {
					cs1 = make_colour_rgb(effect.cs1[0],effect.cs1[1],effect.cs1[2]);
					cs2 = make_colour_rgb(effect.cs2[0],effect.cs2[1],effect.cs2[2]);
					cs3 = make_colour_rgb(effect.cs3[0],effect.cs3[1],effect.cs3[2]);
					cs4 = make_colour_rgb(effect.cs4[0],effect.cs4[1],effect.cs4[2]);
				};
				if (insideEffectRange and effect.type_ == "randomMovement") {
					var randSeed = charIndex * 123.45; 
					var driftSpeed = 0.003; 
					var waveShift = (charIndex mod 3) * 50; 
					if charIndex % 2 == 1 { driftSpeed *= 0.5 }
					var randomX = sin(current_time * driftSpeed + randSeed + waveShift) * cos(current_time * driftSpeed * 0.37 - randSeed);
					var randomY = cos(current_time * driftSpeed * 0.61 + randSeed * 1.2 + -waveShift) * sin(current_time * driftSpeed * 0.23 + randSeed);
   
					OffsetX += randomX * effect.intensity;
					OffsetY += randomY * effect.intensity;
				};
				if (insideEffectRange and effect.type_ == "randomRotations") {
					var randSeed = charIndex * 123.45; 
					var driftSpeed = 0.003; 
					var waveShift = (charIndex mod 3) * 50; 
					if charIndex % 2 == 1 { driftSpeed *= 0.5 }
					var randomRotation = sin(current_time * driftSpeed + randSeed + waveShift) * cos(current_time * driftSpeed * 0.37 - randSeed);
   
					OffsetRotation += randomRotation * effect.intensity;
				};
			};
		};
		draw_text_transformed_colour((camX + txtX) + OffsetX, (camY + txtY) + OffsetY, character, 1, 1, OffsetRotation, cs1, cs2, cs3, cs4, 1);

		txtX += string_width(character);
		};
					
		if global.letterCDThing == false and textInfo.speed_ > 0 {
			global.letterCDThing = true;
			if global.currentLetters < string_length(text) {
				global.currentLetters += 1;
			};
			var cdTime = textInfo.speed_;
			
			if currentLetter == "," or currentLetter == "." {
				cdTime *= 3
			};
			
			call_later(textInfo.speed_,time_source_units_seconds,function(){
				global.letterCDThing = false;
			});
			
			audio_play_sound(textInfo.txtSnd,1,false);
		} else if textInfo.speed_ <= 0 { global.currentLetters = string_length(text) }
	};
};


global.backgroundObject = 0;
global.battleMusic = 0;
global.layerBattleID = 0;
platformerCD = false;

function platformerModeEnable(fightID,plrX,plrY,enObj,enX,enY,introSpeed,backgroundID,battleMusicID){
	if global.inPlatformer >= 1 and platformerCD == false { exit }
	platformerCD = true;
	global.inPlatformer = 1;
	
	global.layerBattleID = layer_create(-100,"Fight");
	var playerPlat = instance_create_layer(plrX,plrY,global.layerBattleID,obj_PlayerPlat);
	playerPlat.x = plrX;
	playerPlat.y = plrY;
	var stats = instance_create_layer(0,0,global.layerBattleID,obj_statsSpawn);
	
	global.backgroundObject = instance_create_layer(0,0,global.layerBattleID,obj_square);
	global.backgroundObject.depth = 999;
	global.backgroundObject.image_xscale = 100;
	global.backgroundObject.image_yscale = 100;
	global.backgroundObject.image_alpha = 0;
	
	if backgroundID == 1 {
		global.backgroundObject.image_alpha = 1;
	}
	
	
	if battleMusicID != 0 {
		audio_play_sound(battleMusicID,0,true)
		
		global.battleMusic = battleMusicID;
	}
	
	call_later(0.1,time_source_units_seconds,function(){
		platformerCD = false;
	})
};

function platformerModeDisable(tpMap){
	if global.inPlatformer <= 0 and platformerCD == false { exit }
	platformerCD = true;
	if global.backgroundObject != 0 {
		instance_destroy(global.backgroundObject);
		
		global.backgroundObject = 0;
	}
	if global.battleMusic != 0 {
		audio_stop_sound(global.battleMusic);
		
		global.battleMusic = 0;
	}
	
	if tpMap == 1 {
		obj_PlayerMap.x = obj_PlayerPlat.x;
		obj_PlayerMap.y = obj_PlayerPlat.y;
	}
	obj_plrHurtbox.layer = layer_get_id("Instances");
	layer_destroy(global.layerBattleID);
	
	global.plrSpeed = 15;
	global.plrSP = global.plrMaxSP;
	global.plrMoving = 0;
	global.plrForce = [0,0];
	global.plrInvF = 0;
	global.plrSoftlock = 0;
	global.plrAnimChange = 2;
	
	global.inPlatformer = 0;
	
	call_later(0.1,time_source_units_seconds,function(){
		platformerCD = false;
	})
};