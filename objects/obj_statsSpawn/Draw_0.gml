var color = c_red;
draw_set_font(font_homeVideo_2);
draw_text_transformed_colour_outline(redHP.x,redHP.y,string(round(global.plrHP / 10)),global.camformulaWidth,global.camformulaHeight,0,color,color,color,color,1,c_black,1);