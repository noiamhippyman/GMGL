if (mouseHovering) {
	
	var c = c_black;
	draw_set_alpha(0.5);
	draw_rectangle_color(bbox_left,bbox_top,bbox_right,bbox_bottom,c,c,c,c,false);
	draw_set_alpha(1);
	
	draw_set_halign(1);
	draw_set_valign(1);
	draw_text((bbox_left+bbox_right)/2, (bbox_top+bbox_bottom)/2, roomName);
	draw_set_halign(0);
	draw_set_valign(0);
}