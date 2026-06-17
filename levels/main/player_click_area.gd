extends Control


func _ready() -> void:
    mouse_filter = Control.MOUSE_FILTER_IGNORE
    await get_tree().process_frame
    mouse_filter = Control.MOUSE_FILTER_STOP


func _gui_input(event: InputEvent) -> void:
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
            Player.instance.move_to_click_pos(event.position)
    elif event is InputEventScreenTouch:
        if event.pressed:
            Player.instance.move_to_click_pos(event.position)
