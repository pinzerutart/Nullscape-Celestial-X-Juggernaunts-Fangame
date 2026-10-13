if hitted == false {
	hitted = true;
	damageNpc(other,0,30,5,global.plrATK,3,0,snd_nothing,0);
	global.plrSP += 2;
	
	if instance_exists(obj_wp_AbsorbBlade) {
		heal(obj_wp_AbsorbBlade.lifeSteal,0.05,global.plrHealM);
	}
}