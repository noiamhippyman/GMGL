/*

	This extension comes with GLFW's event system.
	Below are all the events currently available.
	More will be added as I work on this.
	I will note when it's finally complete.

*/
switch (async_load[?"event"]) {
	case eGMGLevent.Error:
		// This event is triggered when an error occurs and returns an error code and a description
		var error = async_load[?"error"];
		var description = async_load[?"description"];
		
		show_error("GMGL ERROR CODE::"+string(error)+"::DESC::"+string(description),true);
	break;
	
	case eGMGLevent.FramebufferSize:
		// This event is triggered when the window is resized and returns the new width and height of the framebuffer
		var width = async_load[?"width"];
		var height = async_load[?"height"];
		
		gl_viewport(0,0,width,height);
	break;
	
	case eGMGLevent.WindowClose:
		// This event is triggered when the window is closed. This is where you want to terminate GLFW
		// otherwise nothing will happen when you press the close button.
		glfw_terminate();
		
		// The GM process will not actually close when you close the GLFW window. You need to end the game
		game_end();
		
		// You can also enable the draw event again to get the GM window back.
		// Just make sure you don't accidentally make any GLFW or GL calls or you'll get a GMGL error
		//draw_enable_drawevent(true);
	break;
	
	case eGMGLevent.MousePos:
		// This event is triggered when the mouse is moved and returns the new x and y position of the mouse
		var mx = async_load[?"xpos"];
		var my = async_load[?"ypos"];
		
		show_debug_message("Mouse pos: " + string(mx) + ", " + string(my));
	break;
}