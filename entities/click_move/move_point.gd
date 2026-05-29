class_name MovePoint
extends Node2D

@export var neighbours: Array[MovePoint]
@export var point_hint: Control
var h = 0

func _ready():
    if !OS.is_debug_build():
        point_hint.hide()
        
    
func set_h(click_pos: Vector2):
    h = global_position.distance_to(click_pos)
