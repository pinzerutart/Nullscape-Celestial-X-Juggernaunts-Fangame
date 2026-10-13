var color1 = make_colour_rgb(228,48,48);
var color2 = make_colour_rgb(75,0,0);
var spaces = "";
if global.plrHP < 100 {spaces = " "}
if global.plrHP < 10 {spaces = "  "}
if global.plrHP < 0 {spaces = " "}
if global.plrHP <= -10 {spaces = "  "}
if global.plrHP <= -100 {spaces = "   "}
draw_set_font(font_homeVideo)
draw_text_colour(x,y,(string(round(global.plrHP)) + spaces + "/" + (string(round(global.plrMaxHP)))),color1,color1,color2,color2,1);