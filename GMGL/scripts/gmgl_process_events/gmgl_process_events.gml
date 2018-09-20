/*

	This extension comes with GLFW's event system.
	Below are all the events currently available.
	More will be added as I work on this.
	I will note when it's finally complete.

*/
if (!gmgl_is_active()) exit;


switch (async_load[?"event"]) {
	case eGMGLevent.Error:
		/*
			This event is triggered when an error occurs.
			Returns an error code and a description.
		*/
		var error = async_load[?"error"];
		var description = async_load[?"description"];
		
		show_error("GMGL ERROR CODE::"+string(error)+"::DESC::"+string(description),true);
	break;
	
	case eGMGLevent.WindowPos:
		/*
			This event is triggered when the window is moved. 
			Returns the new x,y positions of the client window.
		*/
		var xpos = async_load[?"xpos"];
		var ypos = async_load[?"ypos"];
		
		//show_debug_message("EVENT::WindowPos::pos("+string(xpos)+", "+string(ypos)+")");
	break;
	
	case eGMGLevent.WindowResize:
		/*
			This event is triggered when the window is resized. 
			Returns the new width and height of the client window.
		*/
		var width = async_load[?"width"];
		var height = async_load[?"height"];
		
		//show_debug_message("EVENT::WindowResize::size("+string(width)+", "+string(height)+")");
	break;
	
	case eGMGLevent.WindowClose:
		/*
			This event is triggered when the window is closed. This is where you want to terminate GLFW
			otherwise nothing will happen when you press the close button.
		*/
		glfw_terminate();
		
		// The GM process will not actually close when you close the GLFW window. You need to end the game
		//game_end();
		
		/*
			You can also enable the draw event again to get the GM window back.
			Just make sure you don't accidentally make any GLFW or GL calls or you'll get an error
		*/
		draw_enable_drawevent(true);
		room_goto(rmMainMenu);
	break;
	
	case eGMGLevent.WindowRefresh:
		/*
			This event is triggered when the window is refreshed. 
			I'm honestly not sure what the purpose is for this event
			It triggers basically when you stop resizing the window
		*/
		//show_debug_message("EVENT::WindowRefresh");
	break;
	
	case eGMGLevent.WindowFocus:
		/*
			This event is triggered when the window is focused/unfocused. 
			Returns whether it's focused or not
		*/
		var focused = async_load[?"focused"];
		//show_debug_message("EVENT::WindowFocus::" + (focused ? "true" : "false"));
	break;
	
	case eGMGLevent.WindowIconify:
		/*
			This event is triggered when the window is moved. 
			Returns the new x,y positions of the client window.
		*/
		var iconified = async_load[?"iconified"];
		//show_debug_message("EVENT::WindowIconify::" + (iconified ? "true" : "false"));
	break;
	
	case eGMGLevent.FramebufferSize:
		/*
			This event is triggered when the window is resized. 
			Returns the new width and height of the framebuffer.
		*/
		var width = async_load[?"width"];
		var height = async_load[?"height"];
		
		gl_viewport(0,0,width,height);
	break;
	
	case eGMGLevent.Key:
		/*
			This event is triggered when any key is pressed, released or repeated.
			
			"key" is any GLFW_KEY_* that was pressed, released or repeated
			"scancode" is the system-specific scancode of the key
			"action" is GLFW_PRESS, GLFW_RELEASE, GLFW_REPEAT
			"mods" is a bitfield describing which modifier keys were held down (ctrl, alt, shift)
		*/
		var key = async_load[?"key"];
		var scancode = async_load[?"scancode"];
		var action = async_load[?"action"];
		var mods = async_load[?"mods"];
		
		//show_debug_message("EVENT::Key::key("+string(key)+")::scancode("+string(scancode)+")::action("+string(action)+")::mods("+string(mods)+")");
	break;
	
	case eGMGLevent.Mouse:
		/*
			This event is triggered when any mouse button is pressed or released.
			
			"button" is any GLFW_KEY_* that was pressed or released
			"action" is either GLFW_PRESS or GLFW_RELEASE
			"mods" is a bitfield describing which modifier keys were held down (ctrl, alt, shift)
		*/
		var button = async_load[?"button"];
		var action = async_load[?"action"];
		var mods = async_load[?"mods"];
		
		//show_debug_message("EVENT::Mouse::button("+string(button)+")::action("+string(action)+")::mods("+string(mods)+")");
	break;
	
	case eGMGLevent.Joystick:
		/*
			This event is triggered when any key is pressed, released or repeated.
			
			"joy" is the id of the joystick
			"joyEvent" is either GLFW_CONNECTED or GLFW_DISCONNECTED
		*/
		var joy = async_load[?"joy"];
		var joyEvent = async_load[?"joy event"];
		
		//show_debug_message("EVENT::Joystick::joy("+string(joy)+")::joy event("+string(joyEvent)+")");
	break;
	
	case eGMGLevent.CursorPos:
		/*
			This event is triggered when the mouse is moved.
			Returns the new x and y position of the mouse.
		*/
		var xpos = async_load[?"xpos"];
		var ypos = async_load[?"ypos"];
		
		global.gmgl_mouse_pos = [xpos, ypos];
		
		//show_debug_message("EVENT::CursorPos::pos("+string(xpos)+", "+string(ypos)+")");
	break;
	
	case eGMGLevent.CursorEnter:
		/*
			This event is triggered when the mouse enters/leaves the client window. 
			Returns whether the mouse enter or left the window.
		*/
		var entered = async_load[?"entered"];
		
		//show_debug_message("EVENT::CursorEnter::"+ (entered ? "true" : "false"));
	break;
	
	case eGMGLevent.Scroll:
		/*
			This event is trigged when you use the scroll wheel. 
			Returns scrolling xoffset/yoffset.
		*/
		var xoffset = async_load[?"xoffset"];
		var yoffset = async_load[?"yoffset"];
		
		//show_debug_message("EVENT::Scroll::offset("+string(xoffset)+", "+string(yoffset)+")");
	break;
	
	case eGMGLevent.Drop:
		/*
			This event is triggered when you drop one or more files/folders into the window.
			"count" is the number of files/folders dropped 
			"paths[n]" is an array of file/folder paths
		*/
		var count = async_load[?"count"];
		var str = "EVENT::FileDrop";
		for (var i = 0; i < count; ++i) {
			str += "\n" + async_load[?"paths["+string(i)+"]"];
		}
		
		show_message(str);
	break;
}