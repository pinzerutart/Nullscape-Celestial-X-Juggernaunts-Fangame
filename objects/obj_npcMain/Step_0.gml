if (!instance_exists(thePlayer)) {
    exit;
}

if enemyType == 998 {
	if celesteIntro == false {
		global.plrSpeed += 25;
		global.plrResistance += 95;
		global.plrAnchor += 1;
		global.plrSoftlock += 1;
		obj_plrTorso.image_alpha = 0;
		obj_plrLegs.image_alpha = 0;
		body.image_xscale = 1.25;
		body.image_yscale = 1.25;
		//HP = 0;
		
		array_push(attacksAllowed,"FALL","CRUMBLE", "ORBS");
		//array_push(attacksAllowed,"DAGGERS","CRUMBLE", "ORBS");
		
		instance_create_layer(x, y, global.layerBattleID, obj_upg_Wings);
		instance_create_layer(x, y, global.layerBattleID, obj_upg_GravityCoil);
		
//partc_celestialFollowOrbs
		_ps = part_system_create();
		part_system_draw_order(_ps, true);
		part_system_global_space(_ps, true);
		part_system_depth(_ps,body.depth + 1);

//Emitter
		_ptype1 = part_type_create();
		part_type_sprite(_ptype1, spr_celestial_circle, false, false, false)
		part_type_size(_ptype1, 3, 3, -0.05, 0);
		part_type_scale(_ptype1, 1, 1);
		part_type_speed(_ptype1, 2, 2, 0, 0);
		part_type_direction(_ptype1, 0, 360, 0, 0);
		part_type_gravity(_ptype1, 0, 0);
		part_type_orientation(_ptype1, 0, 0, 0, 0, false);
		part_type_colour3(_ptype1, $000000, $232323, $FFFFFF);
		part_type_alpha3(_ptype1, 1, 1, 1);
		part_type_blend(_ptype1, false);
		part_type_life(_ptype1, 60, 60);

		var _pemit1 = part_emitter_create(_ps);
		part_emitter_region(_ps, _pemit1, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
		part_emitter_stream(_ps, _pemit1, _ptype1, 6);
		part_emitter_interval(_ps, _pemit1, 0.2, 0.2, time_source_units_seconds);


		
		
		Resistance += 100;
		celesteIntro = true;
		body.image_alpha = 0;
		catk = 999;
		body.sprite_index = spr_celestial_cocon;
		body.image_speed = 1;
		var timeMultiplier = 1;
		skipCutscene = false;
		if global.seenCutscene_Celestial == true or debug_mode == true { timeMultiplier = 0.05; skipCutscene = true; }
	
		call_later(1,time_source_units_seconds,function(){ celesteAppearedIntro = false; audio_play_sound(mus_celestial_intro,0,false); })
		call_later(1.5,time_source_units_seconds,function(){ if skipCutscene == false { celestialStartIntroText = true; } })
		
		
		call_later(17.5 * timeMultiplier,time_source_units_seconds,function(){
			if skipCutscene == true { audio_play_sound(snd_celestial_talk4,1,false); }
			body.image_speed = 1;
			body.image_index = 0;
			body.sprite_index = spr_celestial_eyesOpenning;
			
			stopAnimOnEnd = true;
		})
		
		call_later((20 * timeMultiplier) + 1.5,time_source_units_seconds,function(){
			celestialStartIntroText = false;
			body.image_speed = 1;
			body.image_index = 0;
			body.sprite_index = spr_celestial_breakFree;
			
			call_later(1.5,time_source_units_seconds,function(){ celestialDisappearIntro = false; })
		})
		
		call_later((20 * timeMultiplier) + 3.5,time_source_units_seconds,function(){
			stopAnimOnEnd = false;
			positionXTo = x;
			positionYTo = y;
			startPositiong += 1;
			
			global.inDanger += 1;
			global.plrAnchor -= 1;
			global.plrSoftlock -= 1;
			obj_plrTorso.image_alpha = 1;
			obj_plrLegs.image_alpha = 1;
			
			audio_stop_sound(mus_celestial_intro);
			audio_play_sound(snd_celestial_screamIntro,0,false);
			call_later(1.5,time_source_units_seconds,function(){
				themeMusic = audio_play_sound(mus_nullscape_doesntEndHere,0,false);
				celesteAppearedIntro = false;
				catk = 0;
				Softlock -= 1;
				Resistance -= 100;
				
				global.seenCutscene_Celestial = true;
				celestialActivity = "A DIVINE's battle.";
			})
		})
		
		
	};
	
	if celesteAppearedIntro == false {
		body.image_alpha += 0.05;
		
		if body.image_alpha >= 1 { body.image_alpha = 1; celesteAppearedIntro = true; }
	};
	if celestialDisappearIntro == false {
		body.image_alpha -= 0.05;
		
		if body.image_alpha <= 0 { body.image_alpha = 0; celestialDisappearIntro = true; }
	};
	
	if part_system_exists(_ps2) { part_system_position(_ps2, x,y); }
};

// VISUAL
body.x = x + bodyXOffset;
body.y = y + bodyYOffset;
distanceToPlayer = point_distance(x,y,thePlayer.x,thePlayer.y);
// IDLES
if enemyType == 998 {
	if catk != 999 and part_system_exists(_ps) { part_system_position(_ps, x, y); }
	if catk == 0 {
		body.sprite_index = spr_celestial_Idle;
		body.image_speed = 1;
	}
	if startPositiong >= 1 and Softlock <= 0 {
		x = lerp(x,positionXTo,0.1);
		y = lerp(y,positionYTo,0.1);
	}
	
	if celestialAttackAddedCounter == 0 and HP <= MaxHp * 0.935 {
		celestialAttackAddedCounter += 1;
		array_push(attacksAllowed,"CEASE");
	}else if celestialAttackAddedCounter == 1 and HP <= MaxHp * 0.8 {
		celestialAttackAddedCounter += 1;
		array_push(attacksAllowed,"CUTTER");
	}else if celestialAttackAddedCounter == 2 and HP <= MaxHp * 0.7 {
		celestialAttackAddedCounter += 1;
		array_push(attacksAllowed,"BITTER");
	}else if celestialAttackAddedCounter == 3 and HP <= MaxHp * 0.6 {
		celestialAttackAddedCounter += 1;
		array_push(attacksAllowed,"INCINERATE");
	}else if celestialAttackAddedCounter == 4 and HP <= MaxHp * 0.5 {
		celestialAttackAddedCounter += 1;
		array_push(attacksAllowed,"DEATH IN BLOOM");
		celestialActivity = "Struggle.";
		if irandom_range(1,2) == 1 {
			audio_play_sound(snd_celestial_scream1,2,false,0.4);
		} else {
			audio_play_sound(snd_celestial_scream2,2,false,0.4);
		}
		
		var multiplier = 1;
		if irandom_range(1,2) == 1 { multiplier = -1; }
		var celesteXPos = random_range(0,500) * multiplier;
		positionXTo = x + celesteXPos;
		positionYTo = thePlayer.y - 200;
		
		Softlock += 1;
		Resistance += 90;
		
		_ps2 = part_system_create();
		part_system_draw_order(_ps2, true);
		part_system_depth(_ps2,body.depth + 1);
		part_system_position(_ps2, x,y);
		
		_ptype2 = part_type_create();
		part_type_sprite(_ptype2, spr_circleHole, false, false, false)
		part_type_size(_ptype2, 0, 0, 0.1, 0);
		part_type_scale(_ptype2, 1, 1);
		part_type_speed(_ptype2, 0, 0, 0, 0);
		part_type_direction(_ptype2, 0, 180, 0, 0);
		part_type_gravity(_ptype2, 0, 278);
		part_type_orientation(_ptype2, 90, 90, 0, 0, false);
		part_type_colour3(_ptype2, $FF00DD, $6868FF, $7272FF);
		part_type_alpha3(_ptype2, 0.831, 0.114, 0);
		part_type_blend(_ptype2, true);
		part_type_life(_ptype2, 25, 50);

		_pemit2 = part_emitter_create(_ps2);
		part_emitter_region(_ps2, _pemit2, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
		part_emitter_stream(_ps2, _pemit2, _ptype2, 1);
		part_emitter_interval(_ps2, _pemit2, 0.1, 0.1, time_source_units_seconds);

		call_later(2.5,time_source_units_seconds,function(){Softlock -= 1; Resistance -= 90; part_emitter_stream(_ps2, _pemit2, _ptype2, 0); });
		call_later(3.25,time_source_units_seconds,function(){ if part_system_exists(_ps2) { part_system_destroy(_ps2); part_type_destroy(_ptype2); } });
		
	}
}


// ATTACKS
if enemyType == 998 and catk <= 0 and Softlock <= 0 {
	var attackGot = celestialNextAttack;
	var storedAttackGot = attackGot;
	array_delete(attacksAllowed,numberGot,1);
	
	var attackCycleCD = 3;
	if HP > MaxHp * 0.935 { attackCycleCD = 1; }
	if HP <= MaxHp * 0.935 and HP > MaxHp * 0.8 { attackCycleCD = 2; }
	if HP <= 0 { attackCycleCD += 1 }
	if attackGot == "DEATH IN BLOOM" { attackCycleCD += 5; }
	if attackGot == "CUTTER" { attackCycleCD += 1; }
	
	attackInCD[$ storedAttackGot] = attackCycleCD + 1;
	
	numberGot = irandom_range(0,array_length(attacksAllowed) - 1);
	show_debug_message(numberGot);
	celestialNextAttack = attacksAllowed[numberGot];
	
	var names = variable_struct_get_names(attackInCD);
	for (var i = 0; i < array_length(names); i++) {
		var name = names[i];
		attackInCD[$ name] -= 1;
		
		if attackInCD[$ name] <= 0 {
			array_push(attacksAllowed,name);
			variable_struct_remove(attackInCD,name);
		}
	}
	if attackGot == "FALL" {
		catk += 1;
		var bonusBeam = 0;
		var bonusFinalBeam = 0;
		var cdSeconds = 5;
		
		if HP <= MaxHp * 0.65 { bonusFinalBeam += 1; cdSeconds -= 0.5 }
		if HP <= MaxHp * 0.3 { bonusFinalBeam += 1; cdSeconds -= 0.5 }
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_FALL,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		
		if global.celestialHardmode == true { bonusFinalBeam += 1; }
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		for (var i = 1; i <= 3; i++) {
			call_later((i - 1) * 0.85,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				
				var multiplier = 1;
				if thePlayer.looking == "L" { multiplier = -1; }
				var celesteXPos = random_range(200,450) * multiplier;
				positionXTo = x + celesteXPos;
				positionYTo = thePlayer.y;
				
				var beam = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Beam);
				beam.bangStart = 0.75;
				beam.waitForStartBang = false;
				if irandom_range(1,2) == 1 {
					audio_play_sound(snd_celestial_beamVariant1,2,false,1.35,0,0.75);
				} else {
					audio_play_sound(snd_celestial_beamVariant2,2,false,1.35,0,0.75);
				}
				if global.celestialHardmode == true {
					var beam = instance_create_depth(positionXTo,positionYTo,thePlayer.depth - 1,obj_celestial_Beam);
					beam.bangStart = 1;
					beam.waitForStartBang = false;
				}
				
				if HP <= 0 { 
					for (var i = 1; i <= 6; i++) {
						if (!instance_exists(thePlayer)) { exit; }
				
						var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Circle);
						circle.bangStart = 0.75;
						circle.scale = random_range(0.9,1.1);
						circle.waitForStartBang = false;
					};
				}
			});
		};
		
		for (var i = 1; i <= 2 + bonusFinalBeam; i++) {
			call_later(2.55,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				
				positionXTo = thePlayer.x
				positionYTo = thePlayer.y - 125;
				
				var beam = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Beam);
				beam.bangStart = 1;
				beam.waitForStartBang = false;
			
				audio_play_sound(snd_celestial_beamFinal,2,false);
			});
		};
		call_later(2.55,time_source_units_seconds,function(){
			if (!instance_exists(thePlayer)) { exit; }
			if HP <= 0 { 
				var beam = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Beam);
				beam.bangStart = 1;
				beam.randomAngleRotate = 0;
				beam.waitForStartBang = false;
				
				var beam = instance_create_depth(thePlayer.x + 800,thePlayer.y,thePlayer.depth - 1,obj_celestial_Beam);
				beam.bangStart = 1;
				beam.randomAngleRotate = 90;
				beam.waitForStartBang = false;
				var beam = instance_create_depth(thePlayer.x - 800,thePlayer.y,thePlayer.depth - 1,obj_celestial_Beam);
				beam.bangStart = 1;
				beam.randomAngleRotate = 90;
				beam.waitForStartBang = false;
			}
		});
	}else if attackGot == "CRUMBLE" { // +BITTER(non agro)
		catk += 1;
		var bonusCircles = 0;
		var cdSeconds = 1;
		
		if HP <= MaxHp * 0.75 { bonusCircles += 1; cdSeconds += 1; }
		if HP <= MaxHp * 0.4 { bonusCircles += 1; cdSeconds += 1.5; }
		if HP <= 0 { bonusCircles += 20; }
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_CRUMBLE,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		
		var multiplier = 1;
		if thePlayer.looking == "L" { multiplier = -1; }
		var celesteXPos = random_range(350,550) * multiplier;
		positionXTo = thePlayer.x + celesteXPos;
		
		call_later(cdSeconds,time_source_units_seconds,function(){ catk -= 1; });
		
		for (var i = 1; i <= 1 + bonusCircles; i++) {
			var _time = 0.5;
			if HP <= 0 { _time = 0.05 }
			call_later(i * _time,time_source_units_seconds,function(){
				var _pitch = 0.3;
				var amountofCircles = 6;
				var _volume = 1.6;
				if HP <= 0 { amountofCircles = 1; _volume = 1; }
				if global.celestialHardmode == true { _pitch = 0.5; }
				audio_play_sound(snd_celestial_crumbleSound,1,false,_volume,0,_pitch);
				
				for (var i = 1; i <= amountofCircles; i++) {
					if (!instance_exists(thePlayer)) { exit; }
				
					var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Circle);
					circle.bangStart = 2;
					circle.scale = random_range(0.9,1.1);
					if global.celestialHardmode == true { circle.bangStart = 1.35; }
					circle.waitForStartBang = false;
				};
			});
		}
	}else if attackGot == "CUTTER" { // Futile(Non Angro) + (Pizza Cutter + Crumble)
		catk += 1;
		var bonusCuts = 2;
		var cdSeconds = 5;
		celestialCutterAmountDid = 0;
		positionYTo = thePlayer.y - 600;
		
		if HP <= MaxHp * 0.65 { bonusCuts += 1; cdSeconds += 1.3; }
		if HP <= MaxHp * 0.5 { cdSeconds = 4.5; }
		if global.celestialHardmode == true { bonusCuts += 1; cdSeconds += 0.5;  }
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_CUT,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		
		if celestialNextAttack == "CEASE" { cdSeconds += 1 }
		call_later(cdSeconds,time_source_units_seconds,function(){ catk -= 1; });
		
		for (var i = 1; i <= 1 + bonusCuts; i++) {
			var timerThing = 1.7;
			if HP <= MaxHp * 0.5 { timerThing = 1; }
			if global.celestialHardmode == true { timerThing *= 0.8; }
			
			call_later((i - 1) * timerThing,time_source_units_seconds,function(){
				var amountOfCuts = 1;
				//if global.celestialHardmode == true { amountOfCuts += 1; }
				for (var i = 1; i <= amountOfCuts; i++) {
					if (!instance_exists(thePlayer)) { exit; }
					celestialCutterAmountDid += 1;
				
					audio_play_sound(snd_celestial_pizzaCutterCharge,2,false,0.45,0,1);
					
					var multiplier = 1;
					if irandom_range(1,2) == 2 { multiplier = -1; }
					var celesteXPos = irandom_range(700,950) * multiplier;
					positionXTo = thePlayer.x + celesteXPos;
					positionYTo = thePlayer.y - random_range(-170,250);
				
					var cutter = instance_create_depth(x,y,thePlayer.depth - 1,obj_celestial_PizzaCutter);
					cutter.bangStart = 2;
					cutter.waitForStartBang = false;
				
					var bonusCuts = 1 + 2;
					if HP <= MaxHp * 0.65 { bonusCuts += 1; }
					if global.celestialHardmode == true { bonusCuts += 1; }
				
					if celestialCutterAmountDid != bonusCuts {
						call_later(2,time_source_units_seconds,function(){ audio_play_sound(snd_celestial_pizzaCutterUse,2,false,0.45,0,1); });
					}else if celestialCutterAmountDid == bonusCuts{
						call_later(2,time_source_units_seconds,function(){ audio_play_sound(snd_celestial_pizzaCutterFinal,2,false,0.45,0,1); });
					}
				}
			});
		}
	}else if attackGot == "CEASE" {
		if (!instance_exists(thePlayer)) { exit; }
		catk += 1;
		var cdSeconds = 2;
		var amountOfBeams = 5;
		var amountOfTime = 1.15;
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_CEASE,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		if HP <= MaxHp * 0.65 {
			amountOfBeams = 7;
			amountOfTime = 2;
			
			var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Circle);
			circle.randomPosition = thePlayer.x;
			circle.x = thePlayer.x;
			circle.scale = 3;
			circle.bangStart = 2;
			circle.waitForStartBang = false;
		}
		
		if HP <= MaxHp * 0.65 and global.celestialHardmode == true {
			audio_play_sound(snd_celestial_beamVariant1,2,false,1.6,0,0.3);
			
			for (var i = 1; i <= 5; i++) {
				if (!instance_exists(thePlayer)) { exit; }
				
				var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Circle);
				circle.bangStart = 2;
				circle.waitForStartBang = false;
			};
		}
		
		audio_play_sound(snd_celestial_chargeCease,2,false,0.25,0,1.15);
		
		call_later(amountOfTime,time_source_units_seconds,function(){
			audio_play_sound(snd_celestial_impactCease,2,false,0.25,0,1);
		});
		
		positionXTo = thePlayer.x
		positionYTo = thePlayer.y - 300;
		
		for (var i = 1; i <= amountOfBeams; i++) {
			if (!instance_exists(thePlayer)) { exit; }
			var amountOfTime = 1.15;
			if HP <= MaxHp * 0.65 {amountOfTime = 2;}
			
			var multiplierX = 1;
			if irandom_range(1,2) == 2 {multiplierX = -1;}
			var multiplierY = 1;
			if irandom_range(1,2) == 2 {multiplierY = -1;}
			
			var randomOffsetX = (random_range(200,700) * multiplierX);
			var randomOffsetY = (random_range(200,500) * multiplierY);
			
			var beam = instance_create_depth(thePlayer.x + randomOffsetX,thePlayer.y + randomOffsetY,thePlayer.depth - 1,obj_celestial_Beam);
			beam.bangStart = amountOfTime;
			beam.waitForStartBang = false;
			
			if global.celestialHardmode == true {
				var beam1 = instance_create_depth(thePlayer.x - randomOffsetX,thePlayer.y - randomOffsetY,thePlayer.depth - 1,obj_celestial_Beam);
				beam1.bangStart = amountOfTime + random_range(0.3,1);
				beam1.dmgMultiplier -= 0.5;
				beam1.sizeMultiplier -= 0.5;
				beam1.waitForStartBang = false;
				
				var randomSoundGot = irandom_range(1,2);
				if randomSoundGot == 1 {
					audio_play_sound(snd_celestial_beamVariant1,1,false,0.5,0,amountOfTime);
				} else if randomSoundGot == 2 {
					audio_play_sound(snd_celestial_beamVariant2,1,false,0.5,0,amountOfTime);
				}
			}
		};
	}else if attackGot == "INCINERATE" {
		if (!instance_exists(thePlayer)) { exit; }
		catk += 1;
		var cdSeconds = 2.5;
		var amountOfOrbs = 7;
		
		if global.celestialHardmode == true { cdSeconds -= 0.5; }
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_INCINERATE,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		audio_play_sound(snd_celestial_incinerate,2,false,1.5);
		
		for (var i = 1; i <= amountOfOrbs; i++) {
			call_later(i * 0.05,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				var orb = instance_create_depth(x,y,thePlayer.depth - 1,obj_celestial_CuttingOrb);
				orb.bangStart = random_range(0.8,1.2);
				orb.waitForStartBang = false;
			});
		};
	}else if attackGot == "DEATH IN BLOOM" {
		if (!instance_exists(thePlayer)) { exit; }
		catk += 1;
		var cdSeconds = 18.5;
		
		celestialDialogFunction(celestial_dlg_DEATHINBLOOM,2);
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		audio_sound_gain(themeMusic,0.3,500);
		audio_play_sound(snd_celestial_DIBcharge,10,false,0.6);
		call_later(5.5,time_source_units_seconds,function(){ audio_play_sound(snd_celestial_DIBfire,10,false,0.6); });
		call_later(17.5,time_source_units_seconds,function(){ audio_sound_gain(themeMusic,1,500); });
		
		var bloomBeam = instance_create_depth(x,y,thePlayer.depth + 1,obj_celestial_DeathBloom);
		bloomBeam.coreObject = self;
		bloomBeam.objectToLook = thePlayer;
		bloomBeam.waitForStartBang = false;
		
		if global.celestialHardmode == true {
			var bloomBeam1 = instance_create_depth(x,y,thePlayer.depth + 1,obj_celestial_DeathBloom);
			bloomBeam1.coreObject = self;
			bloomBeam1.objectToLook = thePlayer;
			bloomBeam1.mainOne = false;
			bloomBeam1.angleOffset = 35;
			bloomBeam1.waitForStartBang = false;
			
			var bloomBeam2 = instance_create_depth(x,y,thePlayer.depth + 1,obj_celestial_DeathBloom);
			bloomBeam2.coreObject = self;
			bloomBeam2.objectToLook = thePlayer;
			bloomBeam2.mainOne = false;
			bloomBeam2.angleOffset = -35;
			bloomBeam2.waitForStartBang = false;
		}
		
	} else  if attackGot == "ORBS" {
		var cdSeconds = 2;
		var amountOfOrbs = 9;
		catk += 1;
		
		positionXTo = thePlayer.x
		positionYTo = thePlayer.y - 300;
		
		if HP <= MaxHp * 0.65 {cdSeconds -= 0.5; amountOfOrbs += 3; }
		if HP <= MaxHp * 0.3 {cdSeconds -= 0.5; amountOfOrbs += 2; }
		
		call_later(cdSeconds, time_source_units_seconds,function(){ catk -= 1; });
		for (var i = 1; i <= amountOfOrbs; i++) {
			call_later(i * 0.2,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				
				var xOffset = random_range(100,800);
				if irandom_range(1,2) == 1 { xOffset *= -1 }
				var yOffset = random_range(-150,260);
			
				var orb = instance_create_depth(thePlayer.x + xOffset,thePlayer.y + yOffset,thePlayer.depth - 1,obj_celestial_Orb);
				orb.bangStart = random_range(1.2,1.5);
				orb.waitForStartBang = false;
				
				if HP <= 0 { 
					var xOffset = random_range(200,800);
					if irandom_range(1,2) == 1 { xOffset *= -1 }
					var yOffset = random_range(-150,260);
			
					var orb = instance_create_depth(thePlayer.x + xOffset,thePlayer.y + yOffset,thePlayer.depth - 1,obj_celestial_Orb);
					orb.bangStart = random_range(1.2,1.5);
					orb.scale = 0.5;
					orb.dmgMultiplier = 0.5;
					orb.waitForStartBang = false;
				}
			});
		};
	} else  if attackGot == "REMEMBRANCE" {
		var cdSeconds = 2.5;
		var beams = 3;
		catk += 1;
		
		positionXTo = thePlayer.x
		positionYTo = thePlayer.y - 300;
		celestialMemoryAmountDid = 0;
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_REMEMBRANCE,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		celestialBitterThingy = 1;
		
		call_later(cdSeconds, time_source_units_seconds,function(){ catk -= 1; celestialBitterThingy = 2; });
		
		call_later(4.5, time_source_units_seconds,function(){ audio_play_sound(snd_celestial_memorySlashFire,10,false,0.6); });
		for (var i = 1; i <= beams; i++) {
			call_later((i - 1) * 1,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				audio_play_sound(snd_celestial_memorySlashSet,10,false,0.4,0,1.5);
				celestialMemoryAmountDid += 1;
				
				var duplicates = 0;
				if global.celestialHardmode == true { duplicates += 1; }
				
				celestial_Memory_xOffset = random_range(-600,600);
				celestial_Memory_yOffset = random_range(-600,600);
				positionXTo = thePlayer.x + celestial_Memory_xOffset
				positionYTo = thePlayer.y + celestial_Memory_yOffset;
					
				for (var i = 1; i <= 1 + duplicates; i++) {
					var beams = instance_create_depth(thePlayer.x + celestial_Memory_xOffset,thePlayer.y + celestial_Memory_yOffset,thePlayer.depth - 1,obj_celestial_MemorySlash);
					beams.bangStart = 4.85 - ((celestialMemoryAmountDid - 1) * 1);
					if global.celestialHardmode == true {
						if i == 1 { beams.randomAngleRotate = beams.image_angle + 250; }
						if i == 2 { beams.randomAngleRotate = beams.image_angle - 250; }
					}
					beams.bitterType = irandom_range(1,3);
					beams.waitForStartBang = false;
				}
			});
		};
	}else  if attackGot == "DAGGERS" {
		var cdSeconds = 4;
		var beams = 4;
		catk += 1;
		
		positionXTo = thePlayer.x
		positionYTo = thePlayer.y - 300;
		celestialDaggerAmountDid = 0;
		
		if global.celestialHardmode == true { cdSeconds = 3.25; }
		
		if !struct_exists(celestialDialogATKsSaid,attackGot) { celestialDialogFunction(celestial_dlg_SILENCE,2); }
		celestialDialogATKsSaid[$ attackGot] = true;
		celestialBitterThingy = 1;
		
		call_later(cdSeconds, time_source_units_seconds,function(){ catk -= 1; celestialBitterThingy = 2; });
		
		call_later(2.5, time_source_units_seconds,function(){ audio_play_sound(snd_celestial_daggerAim,10,false,0.4); });
		audio_play_sound(snd_celestial_daggerSpawn,10,false,0.6); 
		for (var i = 1; i <= beams; i++) {
			if (!instance_exists(thePlayer)) { exit; }
			celestialDaggerAmountDid += 1;
					
			var dagger = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestial_Dagger);
			var formulaT = ((celestialDaggerAmountDid - 1) * 0.5);
			var doubler = 1;
			if global.celestialHardmode == true { doubler = 0.75; }
			dagger.bangStart = (0.5 + formulaT) * doubler;
			dagger.aimStart = 2.5 * doubler;
			dagger.fireStart = (2.5 + formulaT + 1) * doubler;
			dagger.coreObject = obj_plrHurtbox;
			dagger.waitForStartBang = false;
		};
	}
	lastAttackID = attackGot;
};

if celestialBitterThingy == 1 {
	image_blend = lerp(image_blend,make_colour_rgb(120,120,120),0.05);
	image_xscale = lerp(image_xscale,0.3,0.05);
	image_yscale = lerp(image_yscale,0.3,0.05);
} else if celestialBitterThingy == 2 {
	image_blend = lerp(image_blend,make_colour_rgb(255,255,255),0.1);
	image_xscale = lerp(image_xscale,1.25,0.1);
	image_yscale = lerp(image_yscale,1.25,0.1);
	
	if image_xscale > 1.24 {
		celestialBitterThingy = 0;
		image_xscale = 1.25;
		image_yscale = 1.25;
		image_blend = make_colour_rgb(255,255,255);
	}
}

// STUFF
if HP >= MaxHp{HP = MaxHp;}

if (InvF > 0){
	InvF -= delta_time / 1000000;
}else{
}

if x > thePlayer.x and looking = "L" and lookAtPlayer >= 1 {
	looking = "R";
	body.image_xscale *= -1;
}else if x < thePlayer.x and looking = "R" and lookAtPlayer >= 1 {
	looking = "L";
	body.image_xscale *= -1;
}

if HP != lastHP {
	if enemyType == 998 and distanceToPlayer <= 150 {
		if x > thePlayer.x {
			global.plrForce[0] = 20;
		} else if x < thePlayer.x {
			global.plrForce[0] = -20;
		}
		
		var _activity = new DiscordActivity();
		_activity.type = DiscordActivityTypes.Playing;
		_activity.details = celestialActivity;
		_activity.state = string(MaxHp - HP)+"/"+string(MaxHp);
		
		discord_social_client_update_rich_presence(_activity, function(_result) {
			if (!_result.successful) show_debug_message(_result.error);
		});
	}
	shakeObj(self,0.04,40,0.5,false);
	lastHP = HP;
}

if HP <= 0 and died == false and death2 == false {
	if enemyType == 998 { 
		celestialActivity = "Desperation."; death2 = true;
		array_push(attacksAllowed, "REMEMBRANCE", "DAGGERS")
		audio_play_sound(snd_celestial_screamPhase2,2,false,0.4);
		var multiplier = 1;
		if irandom_range(1,2) == 1 { multiplier = -1; }
		var celesteXPos = random_range(0,500) * multiplier;
		positionXTo = x + celesteXPos;
		positionYTo = thePlayer.y - 200;
		
		Softlock += 1;
		Resistance += 100;
		
		_ps2 = part_system_create();
		part_system_draw_order(_ps2, true);
		part_system_depth(_ps2,body.depth + 1);
		part_system_position(_ps2, x,y);
		
		_ptype2 = part_type_create();
		part_type_sprite(_ptype2, spr_circleHole, false, false, false)
		part_type_size(_ptype2, 0, 0, 0.15, 0);
		part_type_scale(_ptype2, 1, 1);
		part_type_speed(_ptype2, 0, 0, 0, 0);
		part_type_direction(_ptype2, 0, 180, 0, 0);
		part_type_gravity(_ptype2, 0, 278);
		part_type_orientation(_ptype2, 90, 90, 0, 0, false);
		part_type_colour3(_ptype2, $FF00DD, $6868FF, $7272FF);
		part_type_alpha3(_ptype2, 0.831, 0.114, 0);
		part_type_blend(_ptype2, true);
		part_type_life(_ptype2, 50, 85);

		_pemit2 = part_emitter_create(_ps2);
		part_emitter_region(_ps2, _pemit2, -0.5, 0.5, -0.5, 0.5, ps_shape_rectangle, ps_distr_linear);
		part_emitter_stream(_ps2, _pemit2, _ptype2, 1);
		part_emitter_interval(_ps2, _pemit2, 0.065, 0.065, time_source_units_seconds);

		call_later(3.5,time_source_units_seconds,function(){Softlock -= 1; part_emitter_stream(_ps2, _pemit2, _ptype2, 0); });
		call_later(4.25,time_source_units_seconds,function(){ if part_system_exists(_ps2) { part_system_destroy(_ps2); part_type_destroy(_ptype2); } });
		
		return;
	}
	died = true;
	Softlock += 999;
	wSpeed -= 999;
	
	call_later(0.175,time_source_units_seconds,function(){
		instance_destroy(body);
		instance_destroy();
	})
}

if global.plrDied == true {
	if enemyType == 998 {
		if part_system_exists(_ps) { part_system_destroy(_ps); part_type_destroy(_ptype1); }
		if part_system_exists(_ps2) { part_system_destroy(_ps2); part_type_destroy(_ptype2); }
	}
}