class_name AssetLoader
extends RefCounted

var base_path = "res://"

func get_asset(asset):
    return load(base_path.path_join(asset))