global.plrSpeed = 15;
global.plrSP = 100;
global.plrMaxSP = 100;
global.plrHP = 100;
global.plrMaxHP = 100;
global.plrSPAdd = 0.05;
global.plrSPDel = 1.5;
global.plrMoving = 0;
global.plrForce = [0,0];
global.plrDF = 0;
global.plrResistance = 0;
global.plrATK = 0;
global.plrInvF = 0;
global.inPlatformer = 0;
global.inDanger = 0;

part_system_destroy(particlePart);
global.particleHurtPart = part_system_create(partc_redHurt);

room_goto(room_gameOver);