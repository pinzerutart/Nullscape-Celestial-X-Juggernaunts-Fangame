pressedF4 = keyboard_check_pressed(vk_f11);
if pressedF4 {
	if f4Thing == 0 {
		f4Thing = 1;
		window_set_fullscreen(true);
	} else if f4Thing == 1 {
		f4Thing = 0;
		window_set_fullscreen(false);
	}
}