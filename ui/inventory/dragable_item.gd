extends Control

signal item_released()
signal item_picked()

@export var click_rect: Control
@export var tr_item: TextureRect
var _is_dragging = false
var allow_pick = true

func _ready() -> void:
    tr_item.mouse_entered.connect(func():
        if allow_pick:
            z_index = 10
            var t = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EaseType.EASE_OUT)
            t.tween_property(tr_item, "scale", Vector2(1.2, 1.2), 0.2)
    )

    tr_item.mouse_exited.connect(func():
        if allow_pick && !_is_dragging:
            z_index = 0
            var t = create_tween().set_trans(Tween.TRANS_BACK)
            t.tween_property(tr_item, "scale", Vector2(1, 1), 0.2)
    )

func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if event.pressed:
                if !_is_dragging:
                    if _get_click_rect().has_point(get_global_mouse_position()):
                        item_picked.emit()
                        _is_dragging = true
            else:
                if _is_dragging:
                    tr_item.position = Vector2.ZERO
                    print("release")
                    item_released.emit()
                    _is_dragging = false


func _process(delta: float) -> void:
    if _is_dragging:
        var drag_pos = get_global_mouse_position() - click_rect.size/2
        tr_item.global_position = lerp(tr_item.global_position, drag_pos, 0.3)


func _get_click_rect():
    return Rect2(click_rect.global_position, click_rect.size)
