@tool
class_name BlockMetadata
extends Resource

@export_tool_button("Reimport .vox & sync block previews", "FileAccess")
var reimport_action = perform_reimport

@export_file("*.vox") var magica_voxel_project

@export var blocks: Array[BlockDesc]


func perform_reimport():
	EditorInterface \
	  .get_resource_filesystem() \
	  .reimport_files(
		PackedStringArray([
		  magica_voxel_project
		])
	  )
	notify_property_list_changed()
