class_name MovePoint
extends Node2D

@export var neighbours: Array[MovePoint]
@export var connect_click_pos = false
@export var point_hint: Control
var h = -1
var g = -1


func _ready():
    add_to_group("move_point")
    if !OS.is_debug_build():
        point_hint.hide()
        
    
func set_h(click_pos: Vector2):
    h = global_position.distance_to(click_pos)


