extends Node

var portraits: AssetLoader = AssetLoader.new()
var state: GlobalState
var drag_item_manager: DragItemManager
var canvas: CanvasLayer
var hud: HUD
var slot_save_manager: SlotSaveSystem

func _enter_tree():
    drag_item_manager = DragItemManager.new()
    canvas = _create_canvas()
    # hud = HUD.spawn()

    portraits.base_path = "res://assets/images/portraits"
    _add_hud()
    state = GlobalState.new()
    slot_save_manager = SlotSaveSystem.new()


func _create_canvas():
    var canvas = CanvasLayer.new()
    add_child(canvas)
    return canvas
    

func _add_hud():
    return
