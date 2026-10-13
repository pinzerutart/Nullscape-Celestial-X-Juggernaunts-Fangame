var color1 = make_colour_rgb(60,134,209);
var color2 = make_colour_rgb(23,67,111);
var spaces = "";
if global.plrSP < 100 {spaces = " "}
if global.plrSP < 10 {spaces = "  "}
if global.plrSP < 0 {spaces = " "}
if global.plrSP <= -10 {spaces = "  "}
if global.plrSP <= -100 {spaces = "   "}
draw_set_font(font_homeVideo)
draw_text_colour(x,y,(string(round(global.plrSP)) + spaces + "/" + (string(round(global.plrMaxSP)))),color1,color1,color2,color2,1);