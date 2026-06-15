extends Node

var portraits: AssetLoader = AssetLoader.new()
var state: GlobalState
var drag_item_manager: DragItemManager
var canvas: CanvasLayer
var hud: HUD
var slot_save_manager: SlotSaveSystem
var fade: Fade

func _enter_tree():
    drag_item_manager = DragItemManager.new()
    canvas = _create_canvas()
  
    portraits.base_path = "res://assets/images/portraits"
    state = GlobalState.new()
    slot_save_manager = SlotSaveSystem.new()
    fade = Fade.spawn()

    get_tree().scene_changed.connect(func():
        print(get_tree().current_scene)
        if get_tree().current_scene is MainMenu:
            state = GlobalState.new()
            hud.queue_free()
            hud = null
        else:
            if hud == null:
                hud = HUD.spawn()
    )


func _create_canvas():
    var canvas = CanvasLayer.new()
    add_child(canvas)
    return canvas
    