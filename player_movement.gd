class_name PlayerMovement
extends Node

signal on_move_changed(pos)
signal direction_changed(prev_dir, dir)

@export var speed = 60
@export var target: Node2D
var _axis_x = 0
var _axis_y = 0
var _prev_dir = Vector2.ZERO


func _unhandled_input(event: InputEvent) -> void:
    _axis_x = Input.get_axis("ui_left", "ui_right")
    _axis_y = Input.get_axis("ui_up", "ui_down")


func _physics_process(delta: float) -> void:
    var dir = Vector2(_axis_x, _axis_y)
    if dir != _prev_dir:
        direction_changed.emit(_prev_dir, dir)
    _prev_dir = dir
    var move_by = speed * delta * dir
    var pos = target.global_position + move_by
    on_move_changed.emit(pos)

    
