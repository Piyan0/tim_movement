extends Control

signal item_clicked(item_name, texture)

@export var tr_item: TextureRect
@export var item_name: String = "item_name"
var t: Tween
var hover_effect = true

func _ready() -> void:
    mouse_entered.connect(func():
        if !hover_effect: return
        t = create_tween().set_trans(Tween.TRANS_BOUNCE).set_parallel()
        t.tween_property(tr_item, "scale", Vector2(1.2, 1.2), 0.1)
        await t.finished
    )
    mouse_exited.connect(func():
        if !hover_effect: return
        reset_scale()
    )

    
func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
            if Rect2(global_position, size).has_point(get_global_mouse_position()):
                item_clicked.emit(item_name, tr_item.texture)


func reset_scale():
    t = create_tween().set_trans(Tween.TRANS_BACK)
    t.tween_property(tr_item, "scale", Vector2(1, 1), 0.2)
    await t.finished


func hide_item_icon(animation = true):
    if t:
        t.custom_step(INF)
    if !animation:
        tr_item.scale = Vector2.ZERO
        return

    t = create_tween().set_trans(Tween.TRANS_BACK)
    t.tween_property(tr_item, "scale", Vector2(0, 0), 0.2)
    await t.finished


func show_item_icon():
    t = create_tween().set_trans(Tween.TRANS_BACK)
    t.tween_property(tr_item, "scale", Vector2(1, 1), 0.2)
    await t.finished
