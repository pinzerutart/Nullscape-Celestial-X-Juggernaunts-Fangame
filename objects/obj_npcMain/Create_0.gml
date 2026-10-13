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

// VISUAL
image_alpha = 0;


body = instance_create_depth(x, y, depth, obj_npcSprite);
body.npcMain = id;
body.image_xscale = 1;
body.image_yscale = 1;
body.image_speed = 1;



// Enemy Type 999 is "Flowery"
// Enemy Type 998 is "Celestial"