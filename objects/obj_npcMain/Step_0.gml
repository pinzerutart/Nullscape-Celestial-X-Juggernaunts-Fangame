if (!instance_exists(thePlayer)) {
    exit;
}

if enemyType == 998 {
	if celesteIntro == false {
		global.plrSpeed += 25;
		global.plrResistance += 90;
		global.plrAnchor += 1;
		global.plrSoftlock += 1;
		obj_plrTorso.image_alpha = 0;
		obj_plrLegs.image_alpha = 0;
		
		array_push(attacksAllowed,"FALL","CRUMBLE", "ORBS");
		//array_push(attacksAllowed,"INCINERATE","FALL");
		
		instance_create_layer(x, y, global.layerBattleID, obj_arm_RealWings);
		
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
	
		call_later(1,time_source_units_seconds,function(){ celesteAppearedIntro = false; audio_play_sound(mus_celestial_intro,0,false); })
		call_later(1.5,time_source_units_seconds,function(){ celestialStartIntroText = true; })
		
		
		call_later(17.5,time_source_units_seconds,function(){
			body.image_speed = 1;
			body.image_index = 0;
			body.sprite_index = spr_celestial_eyesOpenning;
			
			stopAnimOnEnd = true;
		})
		
		call_later(21.5,time_source_units_seconds,function(){
			celestialStartIntroText = false;
			body.image_speed = 1;
			body.image_index = 0;
			body.sprite_index = spr_celestial_breakFree;
			
			call_later(1.5,time_source_units_seconds,function(){ celestialDisappearIntro = false; })
		})
		
		call_later(23.5,time_source_units_seconds,function(){
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
			audio_play_sound(snd_celestial_introScreamLoud,0,false);
			call_later(1.5,time_source_units_seconds,function(){
				audio_play_sound(mus_nullscape_doesntEndHere,0,false);
				celesteAppearedIntro = false;
				catk = 0;
				Softlock -= 1;
				Resistance -= 100;
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
};
/*if enemyType == 998 and celestialComboRestoreCD == false{
	celestialComboRestoreCD = true;
	celestialComboAmount += 1;
	call_later(10,time_source_units_seconds,function(){ celestialComboRestoreCD = false; });
}*/

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
	}else if celestialAttackAddedCounter == 2 and HP <= MaxHp * 0.6 {
		celestialAttackAddedCounter += 1;
		array_push(attacksAllowed,"INCINERATE");
	}
}


// ATTACKS
if enemyType == 998 and catk <= 0 {
	var numberGot = irandom_range(0,array_length(attacksAllowed) - 1);
	show_debug_message(numberGot);
	var attackGot = attacksAllowed[numberGot];
	var storedAttackGot = attackGot;
	array_delete(attacksAllowed,numberGot,1);
	attackInCD[$ storedAttackGot] = 4;
	if HP > MaxHp * 0.935 { attackInCD[$ storedAttackGot] = 2; }
	if HP <= MaxHp * 0.935 and HP > MaxHp * 0.8 { attackInCD[$ storedAttackGot] = 3; }
	
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
		
		if HP <= MaxHp * 0.65 { bonusFinalBeam += 1; cdSeconds -= 1.5 }
		if HP <= MaxHp * 0.3 { bonusFinalBeam += 1; cdSeconds -= 1.5 }
		
		if global.celestialHardmode == true { bonusFinalBeam += 1; }
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		for (var i = 1; i <= 3; i++) {
			call_later(i * 0.85,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				
				var multiplier = 1;
				if thePlayer.looking == "L" { multiplier = -1; }
				var celesteXPos = random_range(200,450) * multiplier;
				positionXTo = x + celesteXPos;
				positionYTo = thePlayer.y;
				
				var beam = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestialBeam);
				beam.bangStart = 0.75;
				beam.waitForStartBang = false;
				var randomSoundGot = irandom_range(1,2);
				if randomSoundGot == 1 {
					audio_play_sound(snd_celestial_beamVariant1,2,false,1.35,0,0.75);
				} else if randomSoundGot == 2 {
					audio_play_sound(snd_celestial_beamVariant2,2,false,1.35,0,0.75);
				}
				if global.celestialHardmode == true {
					var beam = instance_create_depth(positionXTo,positionYTo,thePlayer.depth - 1,obj_celestialBeam);
					beam.bangStart = 1;
					beam.waitForStartBang = false;
				}
			});
		};
		
		for (var i = 1; i <= 2 + bonusFinalBeam; i++) {
			call_later(3.4,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				
				positionXTo = thePlayer.x
				positionYTo = thePlayer.y - 125;
				
				var beam = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestialBeam);
				beam.bangStart = 1;
				beam.waitForStartBang = false;
			
				audio_play_sound(snd_celestial_beamFinal,2,false);
			});
		};
	}else if attackGot == "CRUMBLE" { // +BITTER(non agro)
		catk += 1;
		var bonusCircles = 0;
		var cdSeconds = 1;
		
		if HP <= MaxHp * 0.75 { bonusCircles += 1; cdSeconds += 1; }
		if HP <= MaxHp * 0.4 { bonusCircles += 1; cdSeconds += 1.5; }
		
		var multiplier = 1;
		if thePlayer.looking == "L" { multiplier = -1; }
		var celesteXPos = random_range(350,550) * multiplier;
		positionXTo = thePlayer.x + celesteXPos;
		
		call_later(cdSeconds,time_source_units_seconds,function(){ catk -= 1; });
		
		for (var i = 1; i <= 1 + bonusCircles; i++) {
			call_later(i * 0.5,time_source_units_seconds,function(){
				var _pitch = 0.3;
				if global.celestialHardmode == true { _pitch = 0.5; }
				audio_play_sound(snd_celestial_beamVariant1,2,false,1.6,0,_pitch);
				
				for (var i = 1; i <= 5; i++) {
					if (!instance_exists(thePlayer)) { exit; }
				
					var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestialCircle);
					circle.bangStart = 2;
					if global.celestialHardmode == true { circle.bangStart = 1.35; }
					circle.waitForStartBang = false;
				};
			});
		}
	}else if attackGot == "CUTTER" { // Futile(Non Angro) + (Pizza Cutter + Crumble)
		catk += 1;
		var bonusCuts = 3;
		var cdSeconds = 8;
		celestialCutterAmountDid = 0;
		positionYTo = thePlayer.y - random_range(100,160);
		
		if HP <= MaxHp * 0.65 { bonusCuts += 1; cdSeconds += 1.75; }
		if HP <= MaxHp * 0.5 { cdSeconds = 8; }
		if global.celestialHardmode == true { bonusCuts += 2; }
		
		call_later(cdSeconds,time_source_units_seconds,function(){ catk -= 1; });
		
		for (var i = 1; i <= 1 + bonusCuts; i++) {
			var timerThing = 1.95;
			if HP <= MaxHp * 0.5 { timerThing = 1.25; }
			if global.celestialHardmode == true { timerThing *= 0.7; }
			
			call_later((i - 1) * timerThing,time_source_units_seconds,function(){
				var amountOfCuts = 1;
				//if global.celestialHardmode == true { amountOfCuts += 1; }
				for (var i = 1; i <= amountOfCuts; i++) {
					if (!instance_exists(thePlayer)) { exit; }
					celestialCutterAmountDid += 1;
				
					audio_play_sound(snd_celestial_pizzaCutterCharge,2,false,0.45,0,1);
					
					var multiplier = 1;
					if irandom_range(1,2) == 2 { multiplier = -1; }
					var celesteXPos = irandom_range(550,650) * multiplier;
					positionXTo = thePlayer.x + celesteXPos;
					positionYTo = thePlayer.y - random_range(100,160);
				
					var cutter = instance_create_depth(x,y,thePlayer.depth - 1,obj_celestialPizzaCutter);
					cutter.bangStart = 2.5;
					cutter.waitForStartBang = false;
				
					var bonusCuts = 1 + 3;
					if HP <= MaxHp * 0.65 { bonusCuts += 1; }
					if global.celestialHardmode == true { bonusCuts += 2; }
				
					if celestialCutterAmountDid != bonusCuts {
						call_later(2.5,time_source_units_seconds,function(){ audio_play_sound(snd_celestial_pizzaCutterUse,2,false,0.45,0,1); });
					}else if celestialCutterAmountDid == bonusCuts{
						call_later(2.5,time_source_units_seconds,function(){ audio_play_sound(snd_celestial_pizzaCutterFinal,2,false,0.45,0,1); });
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
		
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		if HP <= MaxHp * 0.65 or global.celestialHardmode == true {
			amountOfBeams = 9;
			amountOfTime = 2;
			
			var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestialCircle);
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
				
				var circle = instance_create_depth(thePlayer.x,thePlayer.y,thePlayer.depth - 1,obj_celestialCircle);
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
			
			var beam = instance_create_depth(thePlayer.x + randomOffsetX,thePlayer.y + randomOffsetY,thePlayer.depth - 1,obj_celestialBeam);
			beam.bangStart = amountOfTime;
			beam.waitForStartBang = false;
		};
	}else if attackGot == "INCINERATE" {
		if (!instance_exists(thePlayer)) { exit; }
		catk += 1;
		var cdSeconds = 1.5;
		var amountOfOrbs = 7;
		
		call_later(cdSeconds,time_source_units_seconds,function(){catk -= 1; });
		
		audio_play_sound(snd_celestial_incinerate,2,false,1.5);
		
		for (var i = 1; i <= amountOfOrbs; i++) {
			call_later(i * 0.05,time_source_units_seconds,function(){
				if (!instance_exists(thePlayer)) { exit; }
				var orb = instance_create_depth(x,y,thePlayer.depth - 1,obj_celestialCuttingOrb);
				orb.bangStart = random_range(0.8,1.2);
				orb.waitForStartBang = false;
			});
		};
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
				
				var xOffset = random_range(100,600);
				if irandom_range(1,2) == 1 { xOffset *= -1 }
				var yOffset = random_range(-50,160);
			
				var orb = instance_create_depth(thePlayer.x + xOffset,thePlayer.y + yOffset,thePlayer.depth - 1,obj_celestialOrb);
				orb.bangStart = random_range(1.2,1.5);
				orb.waitForStartBang = false;
			});
		};
	}
	
	lastAttackID = attackGot;
};

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
			global.plrForce[0] += 20;
		} else if x < thePlayer.x {
			global.plrForce[0] -= 20;
		}
	}
	shakeObj(self,0.04,40,0.5,false);
	lastHP = HP;
}

if HP <= 0 and died == false {
	died = true
	Softlock += 999
	wSpeed -= 999
	image_blend = make_colour_rgb(255,0,0)
	if enemyType == 998 { part_system_destroy(_ps); }
	
	call_later(0.175,time_source_units_seconds,function(){
		instance_destroy(body)
		instance_destroy()
	})
}

if global.plrHP <= 0 {
	if enemyType == 998 { part_system_destroy(_ps); part_type_destroy(_ptype1); }
}