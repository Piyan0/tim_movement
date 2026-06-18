extends Control

@export var _map_marker: Control
@export var _btn_close: Button

var marker_pos:
    set(value):
        marker_pos = value
        if _map_marker:
            _map_marker.position = value

func _ready() -> void:
    _btn_close.pressed.connect(func():
        queue_free()    
    )
