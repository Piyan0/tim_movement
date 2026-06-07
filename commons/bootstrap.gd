extends Node


var portraits: AssetLoader = AssetLoader.new()
var state: GlobalState
func _enter_tree():
    portraits.base_path = "res://assets/images/portraits"
    _add_hud()
    state = GlobalState.new()
    
    

func _add_hud():
    return
