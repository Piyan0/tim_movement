class_name ClickMoveDestination
extends Node2D

var routes: Array[MovePoint]

func _ready() -> void:
    pass


func get_routes(target_pos, click_pos):
    var g = 0
    
