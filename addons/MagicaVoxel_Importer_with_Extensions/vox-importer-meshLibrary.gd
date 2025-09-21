@tool
extends EditorImportPlugin

const VoxImporterCommon = preload("./vox-importer-common.gd");

func _init():
	print('MagicaVoxel MeshLibrary Importer: Ready')

func _get_importer_name():
	return 'MagicaVoxel.With.Extensions.To.MeshLibrary'

func _get_visible_name():
	return 'MagicaVoxel MeshLibrary'

func _get_recognized_extensions():
	return [ 'vox' ]

func _get_resource_type():
	return 'MeshLibrary'

func _get_save_extension():
	return 'meshlib'

func _get_preset_count():
	return 0

func _get_preset_name(_preset):
	return 'Default'

func _get_import_order():
	return 0

func _get_priority() -> float:
	return 1.0

func _get_import_options(path, preset_index):
	return [
		{
			'name': 'Scale',
			'default_value': 0.1
		},
		{
			'name': 'GreedyMeshGenerator',
			'default_value': true
		},
		{
			'name': 'SnapToGround',
			'default_value': false
		}
	]

func _get_option_visibility(path, option, options):
	return true

func _import(source_path, destination_path, options, _platforms, _gen_files):
	var meshes = VoxImporterCommon.new().import(source_path, destination_path, options, _platforms, _gen_files);
	var meshLib = MeshLibrary.new()
	var block_metadata: BlockMetadata = load("res://magicavoxel_files/block_metadata.tres")
	var block_previews = EditorInterface.make_mesh_previews(meshes, 64)
	for mesh in meshes:
		var itemId = meshLib.get_last_unused_item_id()
		var itemMeta: BlockDesc = block_metadata.blocks.get(itemId)
		if not itemMeta:
			block_metadata.blocks.resize(itemId + 1)
			itemMeta = BlockDesc.new()
			block_metadata.blocks[itemId] = itemMeta
		meshLib.create_item(itemId)
		meshLib.set_item_mesh(itemId, mesh)
		meshLib.set_item_name(itemId, "#%d: \n%s" % [itemId, itemMeta.name])
		meshLib.set_item_preview(itemId, block_previews[itemId])
		itemMeta.preview = block_previews[itemId]
	ResourceSaver.save(block_metadata)
	var full_path = "%s.%s" % [ destination_path, _get_save_extension() ]
	return ResourceSaver.save(meshLib, full_path)
