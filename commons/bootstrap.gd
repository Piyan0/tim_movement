extends Node

var portraits: AssetLoader = AssetLoader.new()
var state: GlobalState
var drag_item_manager: DragItemManager

func _enter_tree():
    drag_item_manager = DragItemManager.new()
    
    portraits.base_path = "res://assets/images/portraits"
    _add_hud()
    state = GlobalState.new()
    
    

func _add_hud():
    return
