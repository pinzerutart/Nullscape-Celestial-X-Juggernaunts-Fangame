if beamBang == 0 { gpu_set_blendmode(bm_add); } else { gpu_set_blendmode(bm_normal); }
draw_self();
gpu_set_blendmode(bm_normal);