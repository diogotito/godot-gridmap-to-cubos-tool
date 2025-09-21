# Godot GridMap .cubos scene generation tool

Emits Cubos scene JSON from a GridMap with meshes imported from a MagicaVoxel file (1 mesh per frame)
through [MagicaVoxel importer with extensions++](https://godotengine.org/asset-library/asset/1587)
as MeshLibrary, with a few hacks on top of it to generate previews and link them to a custom resource
that allows writing a name and the UUID for each mesh.
