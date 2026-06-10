# class_name DragableItem
extends Control

signal item_released(item_id, release_pos)
signal item_dragged(item_id, pos)

@export var click_rect: Control
@export var tr_item: TextureRect
@export var offset = Vector2(-40, -40)
@export var item_name: String = "<item_name>"


func _ready() -> void:
    Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
    Bootstrap.State.is_holding_item = true
    Bootstrap.state.current_state = GlobalState.GameState.DRAG_ITEM


func _process(delta: float) -> void:
    var drag_pos = get_global_mouse_position() + offset
    global_position = lerp(global_position, drag_pos, 0.5)



static func create(p_item_name, p_texture):
    var ins = load("uid://625071u2ypr4").instantiate()
    ins.item_name = p_item_name
    ins.tr_item.texture = p_texture
    return ins


func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if !event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
            vanish()

            
func vanish():
    var drop_pos = get_global_mouse_position()
    var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EaseType.EASE_IN)
    t.tween_property(tr_item, "scale", Vector2(0, 0), 0.2)
    await t.finished
    Bootstrap.state.is_holding_item = false
    Bootstrap.state.current_state = GlobalState.GameState.FREE
    Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
    item_released.emit(item_name, drop_pos)

    queue_free()



    
func _get_click_rect():
    return Rect2(click_rect.global_position, click_rect.size)
