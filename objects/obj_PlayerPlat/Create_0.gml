//STATS
global.plrSpeed = 40;
global.plrSP = 20;
global.plrMoving = 0;
global.plrForce = [0,0];
global.plrInvF = 0;
global.plrSoftlock = 0;
global.plrAnimChange = 2;


//VARIABLES
spritesBody = {
	"Idle": spr_plrBodyPlatIdle,
	"Walk": spr_plrBodyPlatWalk,
	"Jump": spr_plrBodyPlatJump,
	"Fall": spr_plrBodyPlatFall,
};
spritesLegs = {
	"Idle": spr_playerLegsPlatformerIdle,
	"Walk": spr_playerLegsPlatformerWalk,
	"Jump": spr_playerLegsPlatformerJump,
	"Fall": spr_playerLegsPlatformerFall,
};
isRunning = 0;
dashCD = false;
bA = false;
bD = false;
bW = false;
bS = false;
died = false;
invEffect = false;
invEffectType = 0;
invEffectFirst = false;
otherIdle = 0;
oneStepDo = false;
changedDirectionOfAnim = false;
torsoXOffset = 0;
torsoYOffset = 0;
torsoXOffsetLeft = 0;
torsoXOffsetRight = 0;
legsXOffset = 0;
legsYOffset = 0;
looking = "R";
canJump = 1;
releasedJump = false;
defaultFlyAmount = 0;
flyAmount = defaultFlyAmount;
flyRegen = 0;
defaultJumpHold = 0.2;
jumpHold = defaultJumpHold;
jumpSpare = 0.2;	
smoothWalkMultiplier = 0;
smoothWalkSpeed = 1;
walkDirectionMultiplier = 1;
tilt = 0;


//SPAWN
image_alpha = 0;
image_xscale = 0.03;
image_yscale = 0.19;

if !layer_exists(global.layerBattleID) { global.layerBattleID = layer_create(-100, "Fight") }


ptorso = instance_create_layer(x, y, global.layerBattleID, obj_plrTorso);
ptorso.image_xscale = 1;
ptorso.image_yscale = 1;
ptorso.image_speed = 0.2;

plegs = instance_create_layer(x, y, global.layerBattleID, obj_plrLegs);
plegs.image_xscale = 1;
plegs.image_yscale = 1;
plegs.image_speed = 0.2;

if not instance_exists(obj_plrHurtbox) {
	hurtBox = instance_create_layer(x, y, global.layerBattleID, obj_plrHurtbox);
	hurtBox.image_alpha = 0;
	hurtBox.depth -= 1;
	hurtBox.image_xscale = 2;
	hurtBox.image_yscale = 2;
}else {
	hurtBox = obj_plrHurtbox;
	hurtBox.layer = global.layerBattleID;
	hurtBox.depth -= 1;
	hurtBox.image_alpha = 0;
}

particleSoulCD = true;

//PARTICLES FOR STUFF
particlePart = part_system_create();
particleType = part_type_create();
part_type_sprite(particleType, spr_redNoBorders, false, false, false);
part_type_size(particleType, 2, 2, 0, 0);
part_type_alpha2(particleType, 0.8, 0);
part_type_life(particleType, 25, 25);


//WEAPON
weapon = instance_create_layer(x, y, global.layerBattleID, asset_get_index("obj_wp_" + global.Weapon));

//MODE
mode = instance_create_layer(x, y, global.layerBattleID, asset_get_index("obj_md_" + global.Mode));

//ABILITIES
mainAbility = instance_create_layer(x, y, global.layerBattleID, asset_get_index("obj_AB_" + global.MainAbility));

//UPGRADES
struct_foreach(global.upgradeCards, function(_name,_data){
	var upgrade = instance_create_layer(x, y, global.layerBattleID, asset_get_index("obj_upg_" + _name));
	upgrade.stacks = global.upgradeCards[$ _name].Stacks
	upgrade.startStep = true;
})