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
* For starters, it is very much a WIP. I highly recommend you don't use this for anything serious.
* You're using a different window than the actual GM window which 
  is only hidden when you disable the draw event. This is demonstrated in the demos.
* A few of the built-in variables and functions don't work with this extension.
* It's far from complete. I'm trying to make it as complete as possible but there 
  will inevitably be some abstraction to make things work correctly with GMS.
* You can't create more than one window. I just don't see a purpose for it since 
  this is for game dev and not software dev. It could be added in the future though.
* If you're going to take a look at the C++ source code, I'm sorry. I'm inexperienced
  and probably have a ton of amateur mistakes riddled throughout the project. I'm open
  to advice though.
---
### Program directly with OpenGL using GML
![alt text](https://i.imgur.com/86lTGtw.png,"")
---
### Screenshots & GIFs
![alt text](https://i.imgur.com/K4kS50U.png,"")
![alt text](https://i.imgur.com/esI2D2H.gif,"")
![alt text](https://i.imgur.com/NtrpRoR.gif,"")