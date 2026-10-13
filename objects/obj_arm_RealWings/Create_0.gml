obj_PlayerPlat.defaultFlyAmount += 0.9;

Bar = instance_create_layer(x, y, global.layerBattleID, obj_Bar);
Bar.depth = -999;
Bar.image_xscale = 0.15;
Bar.image_yscale = 0.15;
Border = instance_create_layer(x, y, global.layerBattleID, obj_Border);
Border.depth = -999;
Border.image_xscale = 0.15;
Border.image_yscale = 0.15;