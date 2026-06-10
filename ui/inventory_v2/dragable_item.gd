extends Control

var _drag = false
var _drag_pos = Vector2.ZERO


func _process(delta):
    position = lerp(position, _drag_pos, 0.2)
    
    
func _gui_input(event: InputEvent):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && event.is_pressed():
            _drag = true
            _drag_pos = event.position
    
    if event is InputEventMouseMotion:
        _drag_pos = event.position


func _input(event: InputEvent):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_LEFT && !event.is_pressed():
            _drag = false

    