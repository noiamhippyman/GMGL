This Extension contains 2 GML scripts:
	model_load(filepath, vformat)
		Loads a model from the given filepath (arg0) using the specified vertex format (arg1).
		The loaded model is drawn using vertex_submit(returnedValue, pr_trianglelist, texID);
		The most important part is that the primitive type is ALWAYS "pr_trianglelist"
		
	vertex_format_create_simple(hasNormal, hasColour, hasTexture)
		Creates and returns a simple vertex format with a 3D position and the other attributes specified by the arguments (if true or false)
		The truthiness of the arguments should correspond with what attributes you had the Blender export script write
		
		Remember that multiple vbuffers can share vformats, so you don't need a new one for every model, just a new one for every attribute variant!
		
The extension also includes a single Python script in the included files: GameMakerStaticModelExportForBlender.py
	Simply install this into Blender and enable it (File > User Preferences > Addons > Install From File)
	This will add the script to the export list under File > Export > GameMaker Studio 3D Model
	You can then add the file exported to your included files and load it with model_load()
	
	
The models should be cross-platform compatible too, so that's nice.
Remember that freezing vertex buffers (vertex_freeze) can make the game run faster, though it prevents you from editing/copying the buffer!

If you just want to read info from the file (to generate a heightmap, for example), you can load it into a buffer, without conversion with buffer_load (or buffer_laod_sync). Buffer read types are as follows:
PositionXYZ = 3 x f32
NormalXYZ = 3 x f32
ColourRGBA = 4 x u8
TextureUV = 2 x f32

The models are stored directly like that in vertex order. The first value will always be the x-coord of position. All read values are in order, there are no terminating values.


For information on getting started with 3D, please check out my quick guide: Getting Started With 3D (in GMS2)
https://forum.yoyogames.com/index.php?threads/guide-getting-started-with-3d-in-gms2-project-download.12145/


With thanks to Martin Crownover and Michael Savchuk for the codebase I used to understand how to make an export for Blender
The former for creating the original model export for Blender, and the latter for updating it to use vertex buffers (for use with GameMaker Studio 2)

While the above scripts were useful, they exported as GameMaker scripts. For complex models, this resulted in huge scripts that caused the game to take a long time to compile, or completely prevent the YYC from working at all
I created this export in order to speed up compile times and improve workflow (no export, copy/paste to update scripts - just re-export to an included file and it's updated)
I also added colour information support, because why not, eh?

If you want a real world example of this script in action, I use it for every 3D model seen in Too Many Birds!™
