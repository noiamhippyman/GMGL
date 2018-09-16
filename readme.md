# GMGL
## GLFW wrapper for Gamemaker Studio 2

---

### Reasons to actually check this out
* Learn OpenGL in a simple environment.
* Use any version of OpenGL.
* Write your own renderer in GML.
* Want more than just vertex and fragment shaders.
* Want to define your own attributes for shaders.
* Basically if you want complete control of your shaders.
* There are probably reasons I'm not thinking of because 
I don't know much about OpenGL or 3D really in general.

### Reasons to go away and not use this
* You can't call GML scripts from extensions so you can't use 
  any of the callback event systems that GLFW provides with GML.
  If you're comfortable with C/C++ though, you could make your own
  callback functions in the source code and recompile.
* You're using a different window than the actual GM window which 
  is only hidden when you disable the draw event. This is demonstrated in the demos.
* The GML keyboard_* and mouse_* functions don't work and the input
  from GLFW is limited to only press and release functions and for some 
  reason the release function is literally no different than just calling
  the negated return value of the press function so this all that's included
  in the extension.
* You have to run an alarm and check if the extension is still active 
  to actually end the game's process. This is demonstrated in the demos.
* It's not even a complete wrapper. I plan on adding as many functions
  as possible but some things require work-arounds and some things will 
  probably never happen like passing a GML script as a callback for the 
  DLL to execute. I'm trying to make it as complete as possible but there 
  will inevitably be some abstraction to make things work correctly with GMS.

---
### Program directly with OpenGL using GML
![alt text](https://i.imgur.com/86lTGtw.png,"")
---
### Screenshots & GIFs
![alt text](https://i.imgur.com/K4kS50U.png,"")
![alt text](https://i.imgur.com/esI2D2H.gif,"")
![alt text](https://i.imgur.com/NtrpRoR.gif,"")