extends Node2D


@export var cr_rect: ColorRect

func _input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT:
            if !event.is_pressed():
                var rect = Rect2(cr_rect.position, cr_rect.size)
                var mouse = get_global_mouse_position()
                print(rect.has_point(mouse))