extends Control

signal item_released()

@export var click_rect: Control
@export var tr_item: TextureRect
@export var offset = Vector2(-40, -40)


func _process(delta: float) -> void:
    var drag_pos = get_global_mouse_position()
    global_position = lerp(global_position + offset, drag_pos, 0.3)


func vanish():
    var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EaseType.EASE_IN)
    t.tween_property(tr_item, "scale", Vector2(0, 0), 0.2)
    await t.finished
    queue_free()

    
func _get_click_rect():
    return Rect2(click_rect.global_position, click_rect.size)
