bl_info = {
		"name": "Export 3D binary for GameMaker: Studio (.dat)",
		"author": "Michael McFab",
		"version": (1, 0, 3),
		"blender": (2, 7, 9),
		"location": "File > Export",
		"description": "Export 3D Model binary for GameMaker Studio - works with both GameMaker: Studio 1.X and GameMaker Studio 2",
		"warning": "",
		"wiki_url": "",
		"tracker_url": "",
		"category": "Import-Export"}

'''
Woo! Added tangent export. Bring on the fancy mapped meshes and textures.

A note:
	This is based off a script from Martin Crownover, then modified by Michael Savchuk.
	Without their base, I don't think I would have been as willing to make this - it really helped clarify how Python works and how to get a basic export working. Shoutouts to the Blender Python API docs for covering the rest.
	Then I (MaddeMichael) went a little gung-ho on it - made it export as a buffer instead, added vertex color support, made it a little more compact 
	I've stripped out nearly all the original stuff - no more object copies, a plugged memory leak and a bunch of handy settings
	The option to either export only the selection or all visible objects, rather than just the active object.
	
	Also fixed a leak with not clearing meshes created with Object.to_mesh

Usage Notes:
	Build your 3D model, select it, then go to File > Export > GameMaker Studio 3D Model
	Set options as desired, export.
	The resulting file is a buffer that can be loaded into GM via buffer_load(_async), then converted to a vbuffer
	Using Edge Split and marking sharp edges is recommended, as is setting up a proper UV map, though the script seems to work well without. It's just good to be sure

Additional links:
	My Twitter: https://twitter.com/MaddeMichael
	url: http://martincrownover.com
	e-mail: martin {at} martincrownover {dot} com
	Michael Savchuk's twitter: @thepixelrobin
	
	Getting Started with 3D in GameMaker Studio 2 (By me): https://forum.yoyogames.com/index.php?threads/guide-getting-started-with-3d-in-gms2-project-download.12145/
	

'''

import bpy
import bmesh
from bpy.props import *
import mathutils, math, struct
import os
from os import remove
import time
import bpy_extras
from bpy_extras.io_utils import ExportHelper 
import time
import shutil
import mathutils
from math import radians


def writeVertex(mesh, face, i, props, file, flipNorm, tData):
	index = face.vertices[i]
	vert = mesh.vertices[index]
	xx = vert.co.x
	yy = vert.co.y
	zz = vert.co.z
	#This scaling is uniform only - so we do not need to scale normals
	nx = face.normal.x# * props.mod_scale
	ny = face.normal.y# * props.mod_scale
	nz = face.normal.z# * props.mod_scale
	if face.use_smooth:
		nx = vert.normal.x# * props.mod_scale
		ny = vert.normal.y# * props.mod_scale
		nz = vert.normal.z# * props.mod_scale
	#End if
	if flipNorm:#To counter the winding order thing
		nx *= -1
		ny *= -1
		nz *= -1
	
	
	file.write(struct.pack('<fff', xx, yy, zz))
	if props.export_normals:
		file.write(struct.pack('<fff', nx, ny, nz))
	
	if props.export_colors:
		if len(mesh.vertex_colors) > 0:
			faceCol = mesh.tessface_vertex_colors.active.data[face.index]
			#There may be a better way to do this, but this seems to work.
			col = faceCol.color1
			if i == 1:
				col = faceCol.color2
			elif i == 2:
				col = faceCol.color3
			elif i == 3:
				col = faceCol.color4
			
			file.write(struct.pack('<BBBB', int(col[0] * 255.0), int(col[1] * 255.0), int(col[2] * 255.0), 255))
		else:
			file.write(struct.pack('<BBBB', 255, 255, 255, 255))
	
	# 
	if props.export_uvs:
		if len(mesh.uv_textures) > 0:
			faceUV = mesh.tessface_uv_textures.active.data[face.index]
			if props.flip_uvs:
					file.write(struct.pack('<ff', faceUV.uv[i][0], 1 - faceUV.uv[i][1]))
			else:
					file.write(struct.pack('<ff', faceUV.uv[i][0], faceUV.uv[i][1]))
			
		else:
			file.write(struct.pack('<ff', 0, 0))
			
	if props.export_tangents:
		if index in tData: #tData.has_key(index):
			mLoop = tData[index]
			tangent = mLoop.tangent
			normal = mLoop.normal
			bitangent = mLoop.bitangent_sign * normal.cross(tangent)
			if flipNorm:
				file.write(struct.pack('<ffffff', -tangent[0], -tangent[1], -tangent[2], -bitangent[0], -bitangent[1], -bitangent[2]))
			else:
				file.write(struct.pack('<ffffff', tangent[0], tangent[1], tangent[2], bitangent[0], bitangent[1], bitangent[2]))
		else:
			#Failed to find tangent/bitangent info. Add dummy info instead
			file.write(struct.pack('<ffffff', 0, 0, 0, 0, 0, 0))
		
def exportMesh(mesh, file, props):
	#basename = mesh.name.capitalize()
	
	#Triangulate so that tangents always work.
	# Get a BMesh representation
	bm = bmesh.new()
	bm.from_mesh(mesh)
	bmesh.ops.triangulate(bm, faces=bm.faces[:], quad_method=0, ngon_method=0)
	# Finish up, write the bmesh back to the mesh
	bm.to_mesh(mesh)
	bm.free()
	
	if(props.flip_y): 
		mesh.transform(mathutils.Matrix.Scale(-1, 4, mathutils.Vector((0.0, 1.0, 0.0))))
	if(props.flip_z): 
		mesh.transform(mathutils.Matrix.Scale(-1, 4, mathutils.Vector((0.0, 0.0, 1.0))))
	mesh.transform(mathutils.Matrix.Scale(props.mod_scale, 4))
	
	reverseCull = False
	if props.flip_z != props.flip_y:
		reverseCull = True
	if props.reverse_cull:
		if reverseCull:
			reverseCull = False
		else: reverseCull = True
	
	mesh.calc_normals()
	
	TangentData = {}
	#Uh oh, doesn't work for non-triangulated meshes.
	if props.export_tangents:
		mesh.calc_normals_split()
		mesh.calc_tangents()
		for mLoop in mesh.loops:
			#Add data to a dict so it's quicker to lookup later. 
			TangentData[mLoop.vertex_index] = mLoop
	
	if reverseCull:
		mesh.flip_normals()#This normally happens..
	mesh.calc_tessface()
	
	for face in mesh.tessfaces:
		if len(face.vertices) >= 3:
			writeVertex(mesh, face, 0, props, file, False, TangentData)
			writeVertex(mesh, face, 1, props, file, False, TangentData)
			writeVertex(mesh, face, 2, props, file, False, TangentData)
		if len(face.vertices) == 4:                      
			writeVertex(mesh, face, 2, props, file, False, TangentData)
			writeVertex(mesh, face, 3, props, file, False, TangentData)
			writeVertex(mesh, face, 0, props, file, False, TangentData)
				
	#End loop
#End exportMesh
		
def do_export(context, props, filepath):
		
	apply_modifiers = props.apply_modifiers
	current_scene = context.scene  
	
	file = open(filepath, "wb") 
	
	LOOPOBS = context.visible_objects
	if props.selection_only:
		LOOPOBS = context.selected_objects
	
	for ob in LOOPOBS:
		
		#ob = context.active_object
		
		if ob.type == 'MESH':#Only export meshes

			#Will still use a copy to allow application of modifiers
			mesh = ob.to_mesh(current_scene, apply_modifiers, 'PREVIEW', True)#Make a mesh copy and tesselate
			if props.apply_transforms:
				mesh.transform(ob.matrix_world)
			
			
			exportMesh(mesh, file, props)

			bpy.data.meshes.remove(mesh)
			

	#End Selection Loop
	file.flush()
	file.close()
	
	

	return True


###### EXPORT OPERATOR #######
class Export_gm3d2F(bpy.types.Operator, ExportHelper):
		'''Exports as a GameMaker: Studio 3D model buffer'''
		bl_idname = "export_mesh.dat"
		bl_label = "Export Gamemaker Studio 2 3D Model"
		bl_options = {'UNDO', 'PRESET'}
		
		filename_ext = ".dat"
		filter_glob = StringProperty(
				default="*.dat",
				options={'HIDDEN'},
				)
				
		selection_only = BoolProperty(name="Selection Only",
		  description="Only export the current selection, otherwise, exports all visible",
		  default=True)
		
		apply_modifiers = BoolProperty(name="Apply modifiers",
		  description="Applies Modifiers to the Object before exporting",
		  default=True)
		
		#exclude_armature = BoolProperty(name="Exclude Armature",
		#  description="Skips applying the armature modifier",
		#  default=True)

		#rot_x90 = BoolProperty(name="Rotate X by 90",
		#  description="Rotate 90 degrees around X to convert to Y-up",
		#  default=False)
		apply_transforms = BoolProperty(name="Apply Transforms",
		  description="Applies Object transforms to exported Vertices",
		  default=True)
		
		reverse_cull = BoolProperty(name="Reverse Winding Order",
		  description="Reverses vertex order to change culling",
		  default=False)
			
		flip_y = BoolProperty(name="Flip Y coordinates",
		  description="Flips the Y coordinates of the object",
		  default=True)
		  

		flip_z = BoolProperty(name="Flip Z coordinates",
		  description="Flips the Z coordinates of the object. Use if your camera up vertex is ( 0, 0, 1 )",
		  default=False)
														
		flip_uvs = BoolProperty(name="Flip UV vertically",
		  description="Flips the UV coordinates on the Y axis",
		  default=True)
														
		mod_scale = FloatProperty(name="Scale",
		  description="Adjusts the scale of the model",
		  default=1.0,
		  min=0.0, 
		  soft_min=0.001, 
		  max=10000.0, 
		  soft_max=100.0)
		  
		  
		export_normals = BoolProperty(name="Export Normals",
		  description="Used to toggle normal export. Useful for lightweight models",
		  default=True)
		  
		export_colors = BoolProperty(name="Export Colors",
		  description="Used to toggle color export. Useful for lightweight models",
		  default=True)
		  
		export_uvs = BoolProperty(name="Export UVs",
		  description="Used to toggle texcoord export. Useful for lightweight models",
		  default=True)
		  
		export_tangents = BoolProperty(name="Export Tangents",
		  description="Enable export of tangents and binormals/bitangents. 2 sets of float3 per vertex. Useful for normal mapping and more",
		  default=False)
		
		@classmethod
		def poll(cls, context):
				#Always true since the whole scene can be exported
				return True#context.active_object.type in ['MESH', 'CURVE', 'SURFACE', 'FONT']

		def execute(self, context):
				start_time = time.time()
				print('\n_____START_____')
				props = self.properties
				filepath = self.filepath
				filepath = bpy.path.ensure_ext(filepath, self.filename_ext)

				exported = do_export(context, props, filepath)
				
				if exported:
						print('finished export in %s seconds' %((time.time() - start_time)))
						print(filepath)
						
				return {'FINISHED'}

		def invoke(self, context, event):
				wm = context.window_manager

				if True:
						# File selector
						wm.fileselect_add(self) # will run self.execute()
						return {'RUNNING_MODAL'}
				elif True:
						# search the enum
						wm.invoke_search_popup(self)
						return {'RUNNING_MODAL'}
				elif False:
						# Redo popup
						return wm.invoke_props_popup(self, event) #
				elif False:
						return self.execute(context)


### REGISTER ###

def menu_func(self, context):
		self.layout.operator(Export_gm3d2F.bl_idname, text="GameMaker Studio 3D Model")

def register():
		bpy.utils.register_module(__name__)

		bpy.types.INFO_MT_file_export.append(menu_func)

def unregister():
		bpy.utils.unregister_module(__name__)

		bpy.types.INFO_MT_file_export.remove(menu_func)

if __name__ == "__main__":
		register()