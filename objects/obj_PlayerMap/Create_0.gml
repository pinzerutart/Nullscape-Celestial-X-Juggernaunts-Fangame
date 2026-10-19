//STATS
global.plrSpeed = 15;
global.plrSP = 20;
global.plrMoving = 0;
global.plrForce = [0,0];
global.plrInvF = 0;
global.plrSoftlock = 0;
global.plrAnimChange = 2;

//VARIABLES
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
walking = false;
oneStepDo = false;
changedDirectionOfAnim = false;
inDanger = 0;
madeInvisible = false;
looking = "R";
autoRun = false;

//SPAWN
image_alpha = 0;
image_xscale = 0.055;
image_yscale = 0.05;

ptorso = instance_create_depth(x, y, depth, obj_plrTorso_map);
ptorso.image_xscale = 1;
ptorso.image_yscale = 1;
ptorso.image_speed = 0;


if not instance_exists(obj_plrHurtbox) {
	global.plrPossesed = true;
	hurtBox = instance_create_depth(x, y, depth, obj_plrHurtbox);
	hurtBox.image_alpha = 0;
	hurtBox.depth -= 1;
	hurtBox.image_xscale = 2;
	hurtBox.image_yscale = 2;
}else {
	hurtBox = obj_plrHurtbox;
	hurtBox.layer = layer_get_id("Instances");
	hurtBox.depth -= 1;
	hurtBox.image_alpha = 0;
}