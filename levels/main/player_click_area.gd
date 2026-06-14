extends Control


func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
            Player.instance.move_to_click_pos(event.position)
    elif event is InputEventScreenTouch:
        if event.pressed:
            Player.instance.move_to_click_pos(event.position)
