@tool
class_name GridMapToCubos
extends GridMap

#@export_file("*.tres") var
const meta_res_path := "res://magicavoxel_files/block_metadata.tres"

@export_tool_button("Generate .cubos scene", "Grid")
var export_cubos_scene_action = export_cubos_scene

@export_tool_button("Edit block UUIDs and names", "EditInternal")
var edit_block_medatada_action = edit_block_medatada


func edit_block_medatada():
	EditorInterface.edit_resource(preload(meta_res_path))


func export_cubos_scene():
	var block_meta: Array[BlockDesc] = load(meta_res_path).blocks
	for cell_i in get_used_cells():
		var mesh_id := get_cell_item(cell_i)
		var entity_dict := {
			"cubos::engine::RenderVoxelGrid": {
				"asset": block_meta[mesh_id],
				"offset": {
					"x": cell_i.x as float,
					"y": cell_i.y as float,
					"z": cell_i.z as float,
				}
			},
			"cubos::engine::Position": {
				"x": cell_i.x as float,
				"y": cell_i.y as float,
				"z": cell_i.z as float,
			},
		}
		print(JSON.stringify(entity_dict, "    ", false))
